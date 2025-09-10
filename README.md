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

#set heading(numbering: "1.")
#outline()
```

# Other things to consider

If you are using neovim check out [typst-preview plugin](https://github.com/chomosuke/typst-preview.nvim)

don't forget to compile your typst doc if it is not previewing properly or at all.
