# Thesis Template for the FMI Jena

This template adheres to the following guidelines: [Gestaltungshinweise zu Abschlussarbeiten an der Fakultät für Mathematik und Informatik der Friedrich-Schiller-Universität Jena](https://www.fmi.uni-jena.de/fmi_femedia/5973/gestaltungshinweise-abschlussarbeiten.pdf?nonactive=1&suffix=pdf).

The main purpose of this template is to create a cover page with all mandatory information, as well as follow the numeration guidelines and so forth. The template in `main.typ` also gives you a head start into your thesis, by recommending packages and a structure. 

> [!TIP]
> You can generate an English and a German cover page by simply renaming the parameter from `cover-english` to `cover-german`.

> [!WARNING]
> This theme is **NOT** affiliated with the University of Jena. The logo and the fonts are the property of the University of Jena.

```typst
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

  /* cover-german: ( use the same dictionary structure ) */
  
  abstract: [Abstract here],
  
  preface: [Put your preface here.],
  
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
```
