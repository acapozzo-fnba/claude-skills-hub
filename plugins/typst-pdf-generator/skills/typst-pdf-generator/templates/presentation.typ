// Presentation Template - Slide-like layout for handouts

#set page(
  paper: "us-letter",
  margin: (x: 0.75in, y: 0.75in),
)

#set text(
  font: "Linux Libertine",
  size: 14pt,
  lang: "en",
)

#set par(
  leading: 0.75em,
  justify: false,
)

// Heading styling for slides
#set heading(numbering: none)

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  align(center)[
    #block(
      fill: rgb("#1e40af"),
      inset: 20pt,
      width: 100%,
      text(size: 24pt, weight: "bold", fill: white, it.body)
    )
  ]
  v(1em)
}

#show heading.where(level: 2): it => {
  v(0.75em)
  block(
    text(size: 18pt, weight: "bold", fill: rgb("#1e40af"), it.body)
  )
  v(0.5em)
}

// Title slide
#align(center + horizon)[
  #block(
    fill: rgb("#1e40af"),
    inset: 30pt,
    width: 100%,
    [
      #text(size: 28pt, weight: "bold", fill: white)[
        #sys.inputs.at("title", default: "Presentation")
      ]
    ]
  )

  #v(2em)

  #text(size: 16pt)[
    #sys.inputs.at("author", default: "")
  ]

  #v(1em)

  #text(size: 12pt)[
    #sys.inputs.at("date", default: datetime.today().display())
  ]
]

#pagebreak()

// Document content
#sys.inputs.at("content", default: "")
