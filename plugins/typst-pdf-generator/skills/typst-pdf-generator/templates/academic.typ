// Academic Template - Citation support, numbered sections, formal styling

#set page(
  paper: "us-letter",
  margin: (x: 1.25in, y: 1in),
)

#set text(
  font: "Linux Libertine",
  size: 12pt,
  lang: "en",
)

#set par(
  leading: 0.65em,
  justify: true,
  first-line-indent: 0.5in,
)

// Heading numbering for academic sections
#set heading(numbering: "1.1")

// Remove indent after headings
#show heading: it => {
  it
  par()[#text(size: 0pt)[#h(0.0em)]]
}

// Title page
#align(center)[
  #v(2in)

  #text(size: 20pt, weight: "bold")[
    #sys.inputs.at("title", default: "Academic Paper")
  ]

  #v(1em)

  #text(size: 14pt)[
    #sys.inputs.at("author", default: "")
  ]

  #v(0.5em)

  #text(size: 12pt)[
    #sys.inputs.at("affiliation", default: "")
  ]

  #v(2em)

  #text(size: 11pt)[
    #sys.inputs.at("date", default: datetime.today().display())
  ]
]

#pagebreak()

// Document content
#sys.inputs.at("content", default: "")
