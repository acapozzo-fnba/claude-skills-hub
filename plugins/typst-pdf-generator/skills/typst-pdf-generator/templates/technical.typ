// Technical Template - Code-friendly with syntax highlighting

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
  justify: false,  // Technical docs often look better left-aligned
)

// Code block styling
#show raw.where(block: true): it => {
  set par(justify: false)
  set text(font: "Courier New", size: 9pt)
  block(
    fill: luma(245),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    it
  )
}

#show raw.where(block: false): it => {
  box(
    fill: luma(245),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    it
  )
}

// Heading numbering for technical sections
#set heading(numbering: "1.1")

// Title block
#align(center)[
  #text(size: 18pt, weight: "bold")[
    #sys.inputs.at("title", default: "Technical Document")
  ]

  #v(0.5em)

  #text(size: 12pt)[
    #sys.inputs.at("author", default: "")
  ]

  #v(0.25em)

  #text(size: 10pt)[
    #sys.inputs.at("date", default: datetime.today().display())
  ]
]

#v(1em)

// Document content
#sys.inputs.at("content", default: "")
