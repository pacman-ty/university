#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#set page(height: auto)
#set page("a4") // Sets the page size to A4
#set heading(numbering: "1.1")
#set text(lang: "en")

= Map Reduce 

#linebreak()

#definition(title: "Key Value Pairs")[
  MapReduce is based around Key-Value pairs.
]

#example[

  If the input is a text file:

  #strong[Key] - Position of a line \(Byte \# not line \# \)

  #strong[Value] - Text of a line 
]

#linebreak()

#example[

     $"map:"$ $(k_1, v_1)$ #sym.arrow.r $"List" [(k_2, v_2)]$

     $"reduce:"$ $(k_2, "List"[v_2])$ #sym.arrow.r $"List"[(k_3, v_3)]$

]




