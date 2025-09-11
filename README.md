# Starting a new doc

```typst
#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#set page(height: auto)
#set page("a4") // Sets the page size to A4
#set heading(numbering: "1.1")
#set text(lang: "en")

#let title-page(title:[], email:[], name:[], fill: yellow, body) = {
  set page(fill: rgb("#FFD700"), margin: (top: 1.5in, rest: 2in))
  set heading(numbering: "1.1.1")
  line(start: (0%, 0%), end: (8.5in, 0%), stroke: (thickness: 2pt))
  align(horizon + left)[
    #text(size: 24pt, title)\
    #v(1em)
    Term Year - Instructor Name
    #v(2em)
    #name, #linebreak() #email
  ]
  
  align(bottom + left)[]
  pagebreak()
  set page(fill: none, margin: auto)
  align(outline(indent: auto))
  pagebreak()
  body
}

#show: body => title-page(
  title: [Course Code Course Notes: \ Course Name ],
  name: [Talha Yildirim],
  email: [ tyildir [ at ] uwaterloo [ dot ] ca ],
  body
)

// order important so it doesnt effect content and title page 

#set page(header: [
  _ACTSC 221 Course Notes_
  #h(1fr)
  Talha Yildirim $<$$3$ 
])

#set page(numbering: "1 of 1")
```

# Other things to consider

If you are using neovim check out [typst-preview plugin](https://github.com/chomosuke/typst-preview.nvim)

don't forget to compile your typst doc if it is not previewing properly or at all.
