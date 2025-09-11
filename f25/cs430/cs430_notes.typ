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
    Fall 2025 - Collin Roberts
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
  title: [CS 430 Course Notes],
  name: [Talha Yildirim],
  email: [tyildir [ at ] uwaterloo [ dot ] ca],
  body
)

= Software Life Cycle Models 

== The Classical and Object Oriented Paradigms

#linebreak()

#definition(title: "Classical (Waterfall) Life Cycle Model")[
  1. *Requirements Phase*
    - Elicit Client Requirements
    - Understand client needs
  2. *Analysis (specification) phase*
    - Analyze client requirements
    - Draft specification Documentation
    - Draft Software Project Management Plan
  3. *Design phase*
    - Design architecture: Divide software functionality into components
    - Draft detailed design for each component
  4. *Implementation phase* 
    - Coding (development): Code and document each component 
    - Unit test each individual component
    - Integration (system) testing: Combine components, test interfaces among components
    - Acceptance testing: Use live data in client’s test environment. Clients participate in testing & verification of test results, and sign off when they are happy with the results.
    - Deploy to production environment 
  5. *Post delivery maintenance*
    - Maintain the software while it's being used to perform the tasks for which it was developed
  6. *Retirement*
    - Product is removed from service: functionality provided by S/W is no longer useful / further maintenance is no longer economically feasible
]

#problem[
  Why does the Waterfall life cycle model not have any of the following phases?

  - Planning 
  - Testing 
  - Documentation
]

#solution[

  - All three activities are crucial to project success
  - Therefore all three activities must happen throughout the project and cannot be limited to just one project phase.
]

#linebreak()

#remark[
  Difference between Classical and Object Oriented paradigms

  #strong[Classical paradigm] #sym.arrow.r One monolithic thing 

  #strong[Object Oriented Paradigm] #sym.arrow.r Many smaller classes that work together 
]

#linebreak()

#definition(title: "Corrective maintenance")[
  Removal of residual faults while software funcationality and specification remain relatively unchanged. 

  a.k.a fix production problems 
]

#definition(title: "Perfective Maintenance")[
  1. Implement changes the client thinks will improve effectiveness of the software product. (e.g. Additional functionality, reduce response time)
  2. Specifications must be changed
]

#definition(title: "Adaptive Maintenance")[
  1. Change the software to adapt to changes in environment (e.g. new policy, tax rate, regulatory requirements, changes in systems environment) - may not necessarily add to functionality. You allow software to survive.
  2. Specifications may change to address the new environment
]

#linebreak()

#important-box[
  #strong[The Importance of Post delivery Maintenance]

  - Shelf life of good software: 10, 20, even 30 years
  - Good software is a model of the real world, and the real world keeps changing, therefore software must change too 
  - Cost of post delivery maintenance continues to go up, while cost of Implementation is nearly flat
]

#linebreak()

#proposition(title: "Problems with the Classical Paradigms")[
  1. Works well for small systems ($<=$ 5000 lines of code), but does not scale effectively to larger systems
  2. Fails to address growing costs of post-delivery maintenance
]

#linebreak()

#proposition(title: "Ethical issues")[
  Software engineers commit to these ethical principles:
    1. Public 
    2. Client and Employer
    3. Product
    4. Judgement
    5. Management
    6. Profession
    7. Colleagues
    8. Self
]

