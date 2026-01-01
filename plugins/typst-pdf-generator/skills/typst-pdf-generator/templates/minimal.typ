// Minimal Template - Clean, simple formatting for general documents

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

#set heading(numbering: none)

// Title block
#align(center)[
  #text(size: 18pt, weight: "bold")[
    #sys.inputs.at("title", default: "Document")
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
