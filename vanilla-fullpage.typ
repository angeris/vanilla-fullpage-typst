#let title_format(title) = {
  v(.5in)
  set text(size: 20pt, weight: 500)
  set align(center)
  v(.25in)

  title
}

#let email_format(email) = {
  // Using fonts shipped with typst for compatibility
  set text(font: "DejaVu Sans Mono", weight:500, size:9pt)
  link("mailto:"+email)
}

#let authors_format(authors) = {
  set align(center)
  set text(size: 14pt)
  let count = authors.len()
  let ncols = calc.min(count, 3)
  set par(leading: .8em)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #author.name \
      #email_format(author.email)
    ])
  )
}

#let date_format(date) = {
  set align(center)
  set text(size: 14pt)
  date
}

#let abstract(abs) = {
  set align(center)
  pad(bottom: .1in, left: .25in, right: .25in, top:.25in)[
      *Abstract*

      #set align(left)
      #set par(leading: .6em, first-line-indent: 1em)
      #set text(size: 11pt)
      
      #abs
  ]
}

#let template(
  title: none,
  authors: (),
  date: none,
  doc
) = {
  // Page stuff
  set page(
    paper: "us-letter",
    margin: (x: 1in, y: 1in),
    numbering: "1",
  )
  
  // Text stuff
  set text(
    font: "New Computer Modern",
    size: 12pt,
    spacing: 70%
  )
  set par(justify: true)
  set heading(numbering: "1.1.1 ")

  // Heading stuff
  show heading: set block(below: 1em, above: 1em)
  show heading.where(level: 4): it => {
      v(.5em)
      text(
      size: 12pt,
      weight: "bold",
      it.body + [.] + h(.4em),
    )
  }

  title_format(title)
  authors_format(authors)
  date_format(date)

  doc
}

#let paragraph(body) = {
  heading(body, depth: 4)
}
