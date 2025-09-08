#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#set page(height: auto)
#set page("a4") // Sets the page size to A4
#set heading(numbering: "1.1")
#set text(lang: "en")

= Floating Point Number System

== Floating Point Number System 
#03/09/2025

#definition[
  hello world 
]

#important-box[
  Fill in with last lectures content
]

#linebreak()
#08/09/2025


#strong[Examining IEEE standards]

Why are we only storing 23 manitssa digits even though we can store 24 

why do we only have $L=-127$ when it could be $-128$

The way that IEEE standard works the first digit of a normalized number is $1$ 

$ 1 . d_1 d_2 "..." times 2^p $

#linebreak()

#note-box[
  Relative error falls off when answer is 0 or close to 0
]


== Floating Point Error Analysis and Stability 

