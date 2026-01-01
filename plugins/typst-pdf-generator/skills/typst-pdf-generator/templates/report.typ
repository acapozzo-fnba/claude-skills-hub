// Report Template - Professional business style with cover page

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)

#set text(
  font: "Linux Libertine",
  size: 11pt,
  lang: "en",
)

#set par(
  leading: 0.65em,
  justify: true,
)

// Heading styling
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  block(
    text(size: 18pt, weight: "bold", it.body)
  )
  v(0.5em)
}

#show heading.where(level: 2): it => {
  v(0.5em)
  block(
    text(size: 14pt, weight: "bold", it.body)
  )
  v(0.25em)
}

// Cover page
#align(center + horizon)[
  #text(size: 24pt, weight: "bold")[
    #sys.inputs.at("title", default: "Report")
  ]

  #v(2em)

  #text(size: 14pt)[
    #sys.inputs.at("subtitle", default: "")
  ]

  #v(4em)

  #text(size: 12pt)[
    Prepared by: #sys.inputs.at("author", default: "")
  ]

  #v(1em)

  #text(size: 11pt)[
    #sys.inputs.at("date", default: datetime.today().display())
  ]
]

#pagebreak()

// Document content
#sys.inputs.at("content", default: "")
