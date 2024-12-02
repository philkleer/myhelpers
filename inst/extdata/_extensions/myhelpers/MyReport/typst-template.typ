#import "@preview/fontawesome:0.5.0": *
#import "@preview/use-academicons:0.1.0": *

#let MyReport(
  // The document title.
  title: "MyReport",

  // Logo in top right corner.
  typst-logo: none,

  author: "Philipp Kleer", 
  doi: false,
  doi-link: "https://doi.org/",  
  osf: true, 
  osf-link: "https://osf.io/", 
  description: "Recent Job", 
  // The document content.
  body
) = {

  // Set document metadata.
  set document(title: title)
  
  // Configure pages.
  set page(
    margin: (left: 2cm, right: 0.5cm, top: 2cm, bottom: 2cm),
    numbering: "1",
    number-align: right,
    background: place(
      right + top, rect(
        fill: rgb("#579d9050"),
        height: 100%,
        width: 3cm,
      )
    ),
    footer: [
      #grid(
        columns: (17cm, 3cm),
        block(
          outset: 0pt, 
          inset: (
            top: 0pt, 
            right: 2cm
          ), 
          stroke: none,
          width: 100%, { 
            // initiliaze fa pro
            fa-use-pro()

            set text(fill: rgb("#579d90"), size: 16pt)
            [ 
              #if doi == true [
                #link("https://doi.org")[
                  #ai-icon("doi", fill: rgb("#579d90")) 
                ] |
              ]
              #if osf ==true [
                  #link("https://osf.io")[
                  #ai-icon("osf", fill: rgb("#579d90")) 
                ] |
              ] #link("https://orcid.org/0000-0003-1935-387X")[
                #ai-icon("orcid", fill: rgb("#579d90"))
              ] | #link("http://lattes.cnpq.br/4785970328498860")[
                #ai-icon("lattes", fill: rgb("#579d90"))
              ] | #link("https://github.com/bpkleer")[
                #fa-icon("github", fill: rgb("#579d90"))
              ] | #link("https://polsci.social/@philk")[
                #fa-icon("mastodon", fill: rgb("#579D90"))
              ] | #link("https://bsky.app/profile/phil-k.bsky.social")[
                #fa-icon("bluesky", fill: rgb("#579D90"))
              ]
            ]
           }
        ),
        block(
          outset: 0pt, 
          inset: (
            top: 0pt, 
            right: 0cm,
            left: 0.25cm
          ), 
          stroke: none,
          width: 100%, { 
            set text(fill: rgb("#579d90"), size: 12pt, weight: 600)
            context {counter(page).display("1/1", both: true)}
          }
        )
      )
    ]
  )
  
  // Set the body font.
  set text(10pt, font: "Fira Sans")

  // Configure headings.
  show heading.where(level: 1): set block(below: 0.8em)
  show heading.where(level: 2): set block(above: 0.5cm, below: 0.5cm)
  show heading.where(level: 1): set text(size: 16pt, fill: rgb("#579d90"))
  show heading.where(level: 2): set text(size: 14pt, fill: rgb("#579d90"))
  show heading.where(level: 3): set text(size: 12pt, fill: rgb("#579d90"))

  grid(
    columns: (17cm, 3cm),
    block(
      outset: 0pt, 
      inset: (
        top: 0pt, 
        right: 2cm
      ), 
      stroke: none,
      width: 100%, {
        set block(above: 10pt)
        // Title
        pad(bottom: 1cm, text(font: "Fira Sans", 20pt, weight: 800, upper(title), fill: rgb("#579d90")))

        set par(justify: true)
        lorem(50)
        body
      }
    ), 
    block(
      outset: 0pt, 
      inset: (
        top: 0pt, 
        left: -0.75cm,
        right: 1cm
      ), 
      stroke: none,
      width: 100%, {
        set block(above: 0pt)
        // Name
        pad(bottom: 0.75cm, text(font: "Fira Sans", 12pt, weight: 800, upper(author), fill: rgb("#579D90")))
        // Description
        pad(bottom: 0.35cm, text(description, fill: rgb("#579D90"), size:9pt))
        // E-Mail
        [
          #fa-icon("paper-plane", fill: rgb("#579D90")) #link("mailto:philipp.kleer@posteo.com")[#text("E-Mail", fill: rgb("#579D90"), size:8pt)]\
        ]
        // Website
        [
          #fa-icon("globe", fill: rgb("#579D90")) #link("https://bpkleer.github.io")[#text("bpkleer.github.io", fill: rgb("#579D90"), size:8pt)]\
        ]
        // Github
        [
          #fa-icon("github", fill: rgb("#579D90")) #link("https://bpkleer.github.io")[#text("bpkleer", fill: rgb("#579D90"), size:8pt)]\ 
        ]
      }
    )
  )
}


