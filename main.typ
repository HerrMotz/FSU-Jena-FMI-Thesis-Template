#import "fsu.typ": *
#import "@preview/equate:0.2.1": equate

/** RECOMMENDATIONS */
// for definition and example subheadings
#import "@preview/great-theorems:0.1.1": *
#show: great-theorems-init
#import "@preview/rich-counters:0.2.2": *

// for listings
#import "@preview/codly:1.1.1": *
#show: codly-init.with()
#codly(languages: (
  HTML: (
    name: "SPARQL", color: green
  )
))

// for ER-Diagrams
#import "@preview/pintorita:0.1.3"

// set your language as required
#set text(lang: "en", region: "GB")
#show raw.where(lang: "pintora"): it => pintorita.render(it.text)

// opinionated abbreviations spaces
#let spct = sym.space.punct
#show "e.g.": [e.#sym.space.thin\g.] // unsure whether I like this.
#show "i.e.": [i.#sym.space.thin\e.]
#show "B. Sc.": [B.#spct\Sc.]
#show "M. Sc.": [M.#spct\Sc.]
#show "Prof. Dr.": [Prof.#spct\Dr.]

// define your assessor here, for use in the cover sheet definition
#let assessor = [Prof. Dr. First Person\ M. Sc. Second Person]
#let degree = [Bachelor of Science (B.Sc.)]

#let mathcounter = rich-counter(
  identifier: "mathblocks",
  inherited_levels: 1
)

#let definition = mathblock(
  blocktitle: "Definition",
  counter: mathcounter
)

#let theorem = mathblock(
  blocktitle: "Theorem",
  counter: mathcounter,
)

#let lemma = mathblock(
  blocktitle: "Lemma",
  counter: mathcounter,
)

#let example = mathblock(
  blocktitle: "Example",
  counter: mathcounter,
)

#let remark = mathblock(
  blocktitle: "Remark",
  prefix: [_Remark._],
  // inset: 5pt,
  // fill: lime,
  // radius: 5pt,
)

#let proof = proofblock()

#let note(it) = text(fill: luma(150), size: 0.7em, it)

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(A.1)", supplement: "Eq.")

#set heading(numbering: "1.1")
#set quote(block: true)

#show heading.where(level: 1): it=> [#v(.5cm) #it #v(.2cm)]
#show heading.where(level: 2): it=> [#v(.5cm) #it #v(.2cm)]

#show raw: set text(
  font: "Noto Sans Mono",
  weight: 300,
  ligatures: true,
  discretionary-ligatures: true,
  historical-ligatures: true,
)
/** END RECOMMENDATIONS */

#show: fsu.with(
  title: [Title of Your Thesis],
  author: "Your Name",

  cover-english: (
    faculty: "Faculty for Mathematics and Computer Science",
    university: "Friedrich Schiller University Jena",
    type-of-work: "Bachelor Thesis",
    academic-degree: degree,
    field-of-study: "Computer Science",
    author-info: "1 April 2001 in Wolkenkuckucksheim, Germany",
    assessor: assessor,
    place-and-submission-date: "Jena, 1 April 2025",
  ),
  
  abstract: [
    This thesis introduces a ..., reducing the effort to ...
    Building on this concept, the newly implemented program features a robust, modular Rust backend and a Web frontend. Early testing by digital humanities students with FactGrid demonstrated the program's usefulness.\ #todo[Put your actual abstract here]
  ],
  
  preface: align(left)[
    Special thanks go to ... for his contributions to implementing UI features. Your technical skills enriched the practical aspects of this work. 

    I owe the programs early public exposure to .... Thank you for testing the early preview of the program in your seminar and for providing crucial support and manpower to accelerate its development.

    My deep gratitude goes to ... and ... for their exceptional mentorship. Their wisdom, encouragement, and thoughtful feedback were instrumental in shaping this project and pushing it to its full potential.
    
    I also wish to acknowledge the many friends, colleagues, and mentors whose support, guidance, and generosity of spirit have enriched this undertaking in countless ways.

    But without you, Mom and Dad, I would never have had the opportunity to enjoy writing this thesis and to encounter so many interesting people and challenges. My deepest gratitude goes to you.
    
    Each of you has played a vital role in bringing this thesis to fruition. Your support has made this journey not only intellectually rewarding but also personally meaningful.

    To all of you, I extend my heartfelt gratitude.  

    #todo[Put your own preface here.]
  ],
  
  appendix: [
    #set heading(outlined: false)
    #heading(numbering: none, "Use of Generative AI")
    This bachelor thesis was written in assistance of the OpenAI large language models GPT-4o and GPT-o1 preview. The large language models were used to ease literature research and to point out stylistic, orthographical, grammatical mistakes and to make formulation suggestions to the writer.
  ],
  
  abbreviations: (
    ("W3C", "World Wide Web Consortium (registered trademark)"),
    ("RDF", "Resource Description Framework"),
    ("RDFS", "Resource Description Framework Schema (Ontology within RDF)"),
    ("VQL", "Visual Query Language"),
    ("WASM", [Web Assembly]),
    ("API", "Application Programming Interface"),
    ("WWW", "World Wide Web")
  ),

  external-link-circle: true, // TODO: TURN THIS OFF IF YOU GENERATE THE PRINT VARIANT
  use-print-margins: false, //  TODO: TURN THIS ON BEFORE PRINTING TO GET BOOK MARGINS
  
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
  bibliography: bibliography(title: "Bibliography", style: "ieee", "bib.yaml")
)

= Introduction <heading:introduction>

Over its thousands of years in existence, humanity has built an _infrastructure for knowledge_. It started out with stone tablets, evolved to hand-written papyrus books, libraries, the printing press and recently culminated in computer and the internet. Instead of using a library and asking a librarian, we usually consult "the internet" using a search engine -- even for small questions. Now, in order to answer a question, the search engine needs to be able to treat the contents of a website in a semantically correct way, just like a human would. This is achieved using i.e. network analysis and techniques of natural language processing. However, what if the contents of websites could be semantically annotated by their creators?

...

For example, a researcher might ask: "What professions did members of societies dedicated to advancements in the natural sciences in Jena hold?" There are many ways to interpret this question: Does the question refer to registered clubs, meaning a legal entity or does a regular's table in a pub count? What does the term profession refer to? Is it the current _occupation_ or the _trained_ profession? Secondly, before starting to write a SPARQL query, the next step is to 'pre-formalise' the question using the concise 'subject, predicate, object' syntax, to adequately captures the interpretation's essence. This requires familiarity with the database's modelling conventions. For example, a researcher could query for entities classified as clubs and ensure that these entities are also associated with 'natural sciences' through the predicate 'interested in'. Alternatively, things related to 'Natural research association' through the predicate 'instance of' could be queried. Both options seem just, but in practice, only _one_ returns results.

However, these initiatives want to reach a broader user base than the one likely to engage given these hurdles. It is unreasonable to expect users to navigate these steps without substantial training, a clear understanding of typical modelling practices, and in-depth knowledge of SPARQL language features.

#figure(caption: [A possible SPARQL query to the professions of members of societies for natural sciences in Jena from the database FactGrid.],
  [
    #set text(size: 2pt)
    ```HTML
    PREFIX fg: <https://database.factgrid.de/entity/>
    PREFIX fgt: <https://database.factgrid.de/prop/direct/>
    SELECT DISTINCT ?careerStatement WHERE {
      ?society fgt:P2 fg:Q266832 .
      ?society fgt:P83 fg:Q10391 .
      ?people fgt:P91 ?society .
      ?people fgt:P165 ?careerStatement .
    }
    ```
    #set text(size: 1em)
  ]
) <fig:example_query_introduction>

== Problem
#lorem(200)

== Proposal
#lorem(200)


= Preliminaries
In order to do XY, it is essential to define YZ. #todo[Write the actual preliminaries.] #lorem(200)

== Resource Description Framework
In order to #lorem(100)

== Wikibase Data Model

#lorem(200)

= Querying

== SPARQL Protocol and RDF Query Language

== Qualifiers

= Mapping

== Visual Query Graphs and Basic Graph Patterns

== Specification

== Implementation


= Discussion <heading:discussion>

#lorem(100)

#figure(
  caption: [An overview of all features currently implemented comparing with other approaches.\ #text(size:.8em)["#sym.checkmark" means implemented and tested, "(#sym.checkmark)" means implemented but not bug-free and "#sym.crossmark" means not implemented. A full feature list can be found in the technical documentation of the repository.]],
  table(columns: (2),
    [Feature Description], [Implementation Status],
    [Drawing a VQG with variables and literals], [#sym.checkmark],
    [Searching for entities on multiple Wikibase instances], [#sym.checkmark],
    [Creating SPARQL-SELECT queries from a VQG], [#sym.checkmark],
    [Code editor for SPARQL queries], [#sym.checkmark], 
    [Applying changes in the code editor to the VQG], [(#sym.checkmark)], 
    [Enriching unseen entities with metadata from the Wikibase API], [(#sym.checkmark)], 
    [Literals with standard RDF data types (string, int, date, ...)], [(#sym.checkmark)], 
    [Use multiple Wikibase instances as data sources], [#sym.checkmark],  
    [Meta-Info Panel], [#sym.checkmark], 
    [Rendering qualifiers with the proposed visualisation], [#sym.crossmark], 
    [Value Constraints], [#sym.crossmark], 
    [Result Modifiers (e.g. `ORDER`, `LIMIT`)], [#sym.crossmark], 
  )
)

// TODO: Vielleicht deine Idee noch unterbringen mit den LLMS? Hier wäre auch could in ordnung, da du ja nur einen Vorschlag bringst, mit dem man auch gut die Arbeit abschließen könnte. Vielleicht noch
// The biggest challenge remains effectively conveying the data model to the end user.
// An intriguing direction for future development is leveraging neuro-symbolic AI to enhance querying. Rather than relying on direct natural language translations to SPARQL, which often overlook database-specific modeling conventions, Query by Graph would provide more interactive relational suggestions based on a specified users intent. 
//When a user specifies a variable and an item, the system would analyze the database to retrieve potential relations and, using embeddings or LLM-based semantic search, suggest contextually relevant connections based on the underlying model. This iterative approach would enable users to construct queries step-by-step while staying aligned with the database’s inherent relationships, offering improved accuracy and an intuitive workflow. This would be especially beneficial in fields like digital humanities, where relational nuances are key.

/*
#todo[Man könnte noch etwas mit LLMs machen, aber das ist jetzt hier glaube ich genug.
bspw.
  - "what are possible relations between a variable and an item" und man gibt noch mit was man modellieren will. Im Hintergrund wird abgefragt welche Relationen es gibt und welche davon ähnliche Bedeutungen haben wie das vom Nutzer angefragte. Das könnte man schrittweise für einen ganzen Graphen machen (neuro-symbolic AI :)))
    - Das wäre besser als einfach nur zu versuchen eine natürlichsprachliche Frage in eine SPARQL query zu übersetzen, weil sich das nicht an den konkret vorhandenen Relationen orientiert.
]
*/