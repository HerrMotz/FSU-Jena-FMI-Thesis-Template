// Workaround for the lack of an `std` scope.
#let std-bibliography = bibliography
#let std-smallcaps = smallcaps
#let std-upper = upper

// Overwrite the default `smallcaps` and `upper` functions with increased spacing between
// characters. Default tracking is 0pt.
#let smallcaps(body) = std-smallcaps(text(tracking: 0.6pt, body))
#let upper(body) = std-upper(text(tracking: 0.6pt, body))

// Colors used across the template.
#let stroke-color = luma(200)
#let fill-color = luma(250)

// This function gets your whole document as its `body` and formats it as a simple
// non-fiction paper.
#let fsu(
  // The title for your work.
  title: [Your Title],

  // Author's name.
  author: "Author",

  // The paper size to use.
  paper-size: "a4",

  uni-logo: none,
  
  cover-german: (
    faculty: none, 
    university: none,
    type-of-work: none,
    academic-degree: none,
    field-of-study: none,
    author-info: none,
    assessor: none,
    place-and-submission-date: none,
  ),

  /** e.g.
    cover-german: (
      faculty: "Fakultät für Mathematik und Informatik",
      university: "Friedrich-Schiller-Universität Jena",
      type-of-work: "Bachelorarbeit",
      academic-degree: [Bachelor of Science (B.#sym.space.punct\Sc.)],
      field-of-study: "Informatik",
      author-info: "01. April 2000 in Wolkenkuckucksheim",
      assessor: "Prof. Dr. Name Hier",
      place-and-submission-date: "Jena, 1. April 2025",
    ),
  */

  cover-english: (
    faculty: none,
    university: none,
    type-of-work: none,
    academic-degree: none,
    field-of-study: none,
    author-info: none,
    assessor: none,
    place-and-submission-date: none,
  ),

  // An abstract for your work. Can be omitted if you don't have one.
  abstract: none,

  // The contents for the preface page. This will be displayed after the cover page. Can
  // be omitted if you don't have one.
  preface: none,

  // The result of a call to the `outline` function or `none`.
  // Set this to `none`, if you want to disable the table of contents.
  // More info: https://typst.app/docs/reference/model/outline/
  table-of-contents: outline(depth: 2),

  appendix: none,

  abbreviations: (),

  // The result of a call to the `bibliography` function or `none`.
  // Example: bibliography("refs.bib")
  // More info: https://typst.app/docs/reference/model/bibliography/
  bibliography: none,

  // Whether to start a chapter on a new page.
  chapter-pagebreak: true,

  // Whether to display a maroon circle next to external links.
  external-link-circle: true,

  // Whether to use printing margins wwith a big margin in the middle
  use-print-margins: false,

  // Display an index of figures (images).
  figure-index: (
    enabled: false,
    title: "",
  ),

  // Display an index of tables
  table-index: (
    enabled: false,
    title: "",
  ),

  // Display an index of listings (code blocks).
  listing-index: (
    enabled: false,
    title: "",
  ),

  // The content of your work.
  body,
) = {
  // Set the document's metadata.
  set document(title: title, author: author)

  // Set the body font.
  // Default is Linux Libertine at 11pt
  set text(font: "Libertinus Serif", size: 12pt)

  // Set raw text font.
  // Default is Fira Mono at 8.8pt
  show raw: set text(font: "Noto Sans Mono", size: 8.8pt)

  // Configure page size and margins.
  let print_margin = (inside: 4.5cm, outside: 3cm, bottom: 1.75cm, top: 2.25cm)
  let digital_margin = (x: 3cm, y: 2.8cm)
  
  set page(
    paper: paper-size,
    margin: if use-print-margins {print_margin} else {digital_margin}
  )

  let cover-page-helper(cover, language-specific-text) = page(align(center + horizon, block(width: 90%)[
        #let v-space = v(2em, weak: true)
  
        #uni-logo
        
        #text(3em)[*#title*]
        
        #text(2em, smallcaps[#cover.type-of-work])
  
        #language-specific-text.at(0)
  
        #cover.academic-degree
  
        #language-specific-text.at(1) #cover.field-of-study
  
        #v-space
  
        #smallcaps[#cover.university]
  
        #cover.faculty
  
        #v-space

        #language-specific-text.at(2)
  
        #text(1.6em, author)
        #v(-3mm)
        #language-specific-text.at(3) #cover.author-info

        #v-space
  
        #language-specific-text.at(4)
        
        #cover.assessor

        #v(2em)
        
        #cover.place-and-submission-date
  
    ]))


  // German cover page.
  if (cover-german.values().all(x => x != none)) {
    let german-language-specific-text = (
      "zur Erlangung des akademischen Grades",
      "im Studienfach",
      "eingereicht von",
      "geboren am",
      "Betreuer"
    )
    cover-page-helper(cover-german, german-language-specific-text)
  }

  if (cover-english.values().all(x => x != none)) {
    let english-language-specific-text = (
      "for the attainment of the academic degree",
      "in",
      "submitted by",
      "born on",
      "assessed by"
    )
    cover-page-helper(cover-english, english-language-specific-text)
  }

  page[]

  page(align(horizon+center, block(width:90%, if abstract != none {
    smallcaps[Abstract]
        block(width: 80%)[
          // Default leading is 0.65em.
          #par(leading: 0.78em, justify: true, linebreaks: "optimized", abstract)
        ]
      })))

  // Configure paragraph properties.
  // Default leading is 0.65em.
  // Default spacing is 1.2em.
  set par(leading: 0.7em, spacing: 1.35em, justify: true, linebreaks: "optimized")

  // Add vertical space after headings.
  show heading: it => {
    it
    v(2%, weak: true)
  }
  // Do not hyphenate headings.
  show heading: set text(hyphenate: false)

  // Show a small maroon circle next to external links.
  show link: it => {
    it
    
    //if external-link-circle and type(it.dest) != label and type(it.dest) != location { // this excludes e.g. ctheorems links and abbreviations in this document
    if external-link-circle and type(it.dest) == str { // this only adds to links to external websites
      sym.wj
      h(1.6pt)
      sym.wj
      super(box(height: 3.8pt, circle(radius: 1.2pt, stroke: 0.7pt + rgb("#993333"))))
    }
  }

  // Indent nested entires in the outline.
  set outline(indent: auto)

  // Display table of contents.
  page("")
  if table-of-contents != none {
    table-of-contents
  }

  page[]

  // Display preface as the second page.
  if preface != none {
    pagebreak()
    heading(numbering: none, level: 1)[Preface]
    box(
      width: 100%,
      preface
    )
  }

  // Configure heading numbering.
  set heading(numbering: "1.")
  show heading.where(level: 1): it => pagebreak(to: "odd", weak: false) + it

  show heading.where(level: 6): set heading(outlined: false)

  show heading.where(
    level: 4,
  ): it => text(
    weight: "regular",
    style: "italic",
    it.body + [. ]
  )
  
  show heading.where(
    level: 5,
  ): it => text(
    weight: "regular",
    style: "italic",
    it.body,
  )

  show heading.where(
    level: 6,
  ): it => text(
    weight: "regular",
    style: "italic",
    it.body,
  )

  // Configure page numbering and footer.
  set page(
    footer: context {
      // Get current page number.
      let i = counter(page).at(here()).first()

      // Align right for even pages and left for odd.
      let is-odd = calc.odd(i)
      let aln = if is-odd { right } else { left }

      // Are we on a page that starts a chapter?
      let target = heading.where(level: 1)
      if query(target).any(it => it.location().page() == i) {
        return align(aln)[#i]
      }

      // Find the chapter of the section we are currently in.
      let before = query(target.before(here()))
      if before.len() > 0 {
        let current = before.last()
        let gap = 1.75em
        let chapter = upper(text(size: 0.68em, current.body))
        if current.numbering != none {
            if is-odd {
              align(aln)[#chapter #h(gap) #i]
            } else {
              align(aln)[#i #h(gap) #chapter]
            }
        }
      }
    },
  )

  // Configure equation numbering.
  set math.equation(numbering: "(1)")

  // Display inline code in a small box that retains the correct baseline.
  show raw.where(block: false): box.with(
    fill: fill-color.darken(2%),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // Display block code with padding.
  show raw.where(block: true): block.with(
    inset: (x: 5pt),
  )

  let image_width = 360pt

  // Break large tables across pages.
  // show figure.where(kind: table): set block(breakable: true) // DM 02.01.2025
  set figure.caption(position: bottom)
  show figure.caption: it => box(width: image_width, text(size: .8em, [

    #it
  ]))

  // set the width of images in the whole document
  set image(width: image_width)
  
  set table(
    // Increase the table cell's padding
    inset: 7pt, // default is 5pt
    stroke: (0.5pt + stroke-color)
  )
  // Use smallcaps for table header row.
  show table.cell.where(y: 0): smallcaps

  // Wrap `body` in curly braces so that it has its own context. This way show/set rules will only apply to body.
  {
    // Start chapters on a new page.
    show heading.where(level: 1): it => {
      if chapter-pagebreak { }
      it
    }

    for a in abbreviations {
      let abbreviation_ref = "abbreviation_ref_"+a.at(0)
      body = context {
        show a.at(0): if query(ref.where(target: "abbreviation_ref_"+a.at(0))).len() > 1 { // todo: make counter work
            link(locate(label(abbreviation_ref)), text(a.at(1) + " (" + insert-zwsp(a.at(0)) + ")"))
          } else {
            link( locate(label("abbreviation_ref_"+a.at(0))), a.at(0))
          }
        body
      }
    }
    body
  }

  // Display bibliography.
  if bibliography != none {
    pagebreak()
    show std-bibliography: set text(0.85em)
    // Use default paragraph properties for bibliography.
    show std-bibliography: set par(leading: 0.65em, justify: false, linebreaks: auto)
    bibliography
  }

   let abbreviation_index = {
    heading(level: 1, numbering: none, "Abbreviations")
    let i = 0
    while i < abbreviations.len() {
      context {
        let k = 0
        let a = abbreviations.at(i)
        let width_of_abbrev_text = 14cm-measure(a.at(0)).width
        let d = if measure(a.at(1)).width > width_of_abbrev_text {
          width_of_abbrev_text
        } else {
          measure(a.at(1)).width
        }
        grid(columns: (auto, auto, d), align: (left, center, right),
          ..while k < 3 {
            ( ( (k == 0, text(hyphenate: false)[#a.at(0) #label("abbreviation_ref_"+a.at(0))]),
              (k == 1, repeat[.]),
              (k == 2, text(hyphenate: true, a.at(1))),
              ).find(t => t.at(0)).at(1),)
            k += 1
            
          }
        )
      }
      i += 1
      v(-.6em)
    }
  }

  if abbreviations.len() > 0 {
    page(columns: 1,
      abbreviation_index
    )
  }

  heading(numbering: none, level: 1)[Appendix]
  

  // Display indices of figures, tables, and listings.
  let fig-t(kind) = figure.where(kind: kind)
  let has-fig(kind) = counter(fig-t(kind)).get().at(0) > 0
  if figure-index.enabled or table-index.enabled or listing-index.enabled {
    show outline: set heading(outlined: true)
    context {
      let imgs = figure-index.enabled and has-fig(image)
      let tbls = table-index.enabled and has-fig(table)
      let lsts = listing-index.enabled and has-fig(raw)

      if imgs { outline(title: figure-index.at("title", default: "Index of Figures"), target: fig-t(image)) }
      if tbls { outline(title: table-index.at("title", default: "Index of Tables"), target: fig-t(table)) }
      if lsts { outline(title: listing-index.at("title", default: "Index of Listings"), target: fig-t(raw)) }
    }
  }

  if appendix != none {
    appendix
  }

  pagebreak()
  [
= Declaration of Academic Integrity

1. I hereby confirm that this work — or in case of group work, the contribution for which I am responsible and which I have clearly identified as such — is my own work and that I have not used any sources or resources other than those referenced.

   I take responsibility for the quality of this text and its content and have ensured that all information and arguments provided are substantiated with or supported by appropriate academic sources. I have clearly identified and fully referenced any material such as text passages, thoughts, concepts or graphics that I have directly or indirectly copied from the work of others or my own previous work. Except where stated otherwise by reference or acknowledgement, the work presented is my own in terms of copyright. 
   
2. I understand that this declaration also applies to generative AI tools which cannot be cited (hereinafter referred to as "generative AI").

  I understand that the use of generative AI is not permitted unless the examiner has explicitly authorised its use (Declaration of Permitted Resources). Where the use of generative AI was permitted, I confirm that I have only used it as a resource and that this work is largely my own original work. I take full responsibility for any AI-generated content I included in my work. 
   
  Where the use of generative AI was permitted to compose this work, I have acknowledged its use in a separate appendix. This appendix includes information about which AI tool was used or a detailed description of how it was used in accordance with the requirements specified in the examiner#sym.quote.single\s Declaration of Permitted Resources. I have read and understood the requirements contained therein and any use of generative AI in this work has been acknowledged accordingly (e.g. type, purpose and scope as well as specific instructions on how to acknowledge its use). 

3. I also confirm that this work has not been previously submitted in an identical or similar form to any other examination authority in Germany or abroad, and that it has not been previously published in German or any other language. 

4. I am aware that any failure to observe the aforementioned points may lead to the imposition of penalties in accordance with the relevant examination regulations. In particular, this may include that my work will be classified as deception and marked as failed. Repeated or severe attempts to deceive may also lead to a temporary or permanent exclusion from further assessments in my degree programme. 

#v(40pt)
#grid(columns: (1fr, 1fr), row-gutter: 1em,
  line(length: 150pt, stroke: (dash: "dashed")),
  line(length: 200pt, stroke: (dash: "dashed")),
  "Place and date",
  "Signature"
)
  ]
}

// This function formats its `body` (content) into a blockquote.
#let blockquote(body) = {
  block(
    width: 100%,
    fill: fill-color,
    inset: 2em,
    stroke: (y: 0.5pt + stroke-color),
    body
  )
}

#let todo(it) = text(fill: luma(50), style: "italic", size: 0.8em, [\/\/ to do: ]+it)
