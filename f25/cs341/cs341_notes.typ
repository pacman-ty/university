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
  //set page(fill: rgb("#FFD700"), margin: (top: 1.5in, rest: 2in))
  set heading(numbering: "1.1.1")
  line(start: (0%, 0%), end: (8.5in, 0%), stroke: (thickness: 2pt))
  align(horizon + left)[
    #text(size: 24pt, title)\
    #v(1em)
    Fall 2025 - Trevor Brown 
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
  title: [CS 341 Course Notes],
  name: [Talha Yildirim],
  email: [tyildir [ at ] uwaterloo [ dot ] ca],
  body
)

= Introduction, Review of Asymptotics

#linebreak() 

#definition(title: "Cost of Algorithms")[
  - Parameterized by an integer $n$, called the *size*
  
  Runtime of a particular instance:
  $ T(I) = "runtime on input" I $

  Worst case runtime (default choice):
  $ T_("worst")(n) = "max"_(I "of size" n) T(I) $

  Best case runtime, not used much in this course:
  $ T_("best")(n) = "min"_(I "of size" n) T(I) $ 
]

#remark[
  We will sometimes use more than one parameter:

  - Number of rows and columns in a matrix 
  - Vertices and edges in a graph
]

#pagebreak()

== Asymptotic Notation

#linebreak()

  Consider two function $f(n), space g(n)$ with values in $ RR_(>0)$

#linebreak()

#definition[
  *Big-$O$:*

  1. We say that $f(n) in O(g(n))$ if there exists $C > 0$ and $n_0$, such that for $n >= n_0$, $f(n) <= C g(n)$

  #figure(
    image("images/big_o.png", width: 50%),
  ) <big_o>
]

#definition[
  *Big-$Omega$:*
  
  1. We say that $f(n) in Omega (g(n))$ if for all $C > 0$, there exists $n_0$ such that for $n >= n_0$, $f(n) >= C g(n)$
  2. Equivalent to $g(n) in O(f(n))$

  #figure(
    image("images/big_omega.png", width: 50%),
  ) <big_omega>
]

#definition[
  *$Theta$:*
  1. We say that $f(n) in Theta(g(n))$ if $f(n) in O(g(n))$ and $f(n) in Omega(g(n))$
  2. In particular true if $lim_infinity f(n) / g(n) = C$ for some $0 < C < infinity$

    #figure(
    image("images/big_theta.png", width: 70%),
  ) <big_theta>

]

#definition[
  *little-$o$:*
  1. We say that $f(n) in  o(g(n))$ if for all $C > 0$, there exists $n_0$ such that for $n >= n_0$, $f(n) <= C g(n)$
  2. Equivalent to $lim_(n arrow.r infinity) f(n) / g(n) = 0$

  #figure(
    image("images/little_o.png", width: 50%),
  ) <little_o>
]
