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
  title: [CS 430 Course Notes: \ Applications Software Engineering],
  name: [Talha Yildirim],
  email: [ tyildir [ at ] uwaterloo [ dot ] ca ],
  body
)

// order important so it doesnt effect content and title page 

#set page(header: [
  _CS 430 Course Notes_
  #h(1fr)
  Talha Yildirim $<$$3$ 
])

#set page(numbering: "1 of 1")

// BEGIN NOTES BELOW

= The Scope of Software Engineering

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
  Removal of residual faults while software functionality and specification remain relatively unchanged. 

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

#proposition(title: "Team Development Aspects")[
  1. Communication becomes challenging when teams are far apart geographically, especially when they are in different time zones
  2. Interpersonal problems can undermine team effectiveness 
  3. If a call to a module written by another developer mentions the arguments in the wrong order
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

#linebreak()

= Software Life Cycle Models

==  Iteration and Incrementation 

#linebreak()

#proposition(title: "Idealized Software Development")[
  #sym.nothing #sym.arrow.r Requirements #sym.arrow.r Analysis #sym.arrow.r Design #sym.arrow.r Implementation
] 

#linebreak()

The _Classical model_ is most effective when the IT team can work without accepting change to the requirements after the requirements are complete.

Changing requirements negatively affects software:
  - Quality
  - Delivery dates 
  - Budget

#linebreak() 

#definition(title: "Moving Target Problem")[
  The *moving target problem* occurs when the requirements change while the software is being developed
]

#definition(title: "Scope Creep")[
  *Scope creep* or feature creep is a succession of small, almost trivial requests for additions to the requirements
]

#definition(title: "Fault")[
  A *fault* is the observable result of a mistake made by any project staff member while working on any artifact 
]

#definition(title: "Regression Fault")[
  A *regression fault* occurs when a change in one part of the software product induces a fault in an apparently unrelated part of the software product 
]

#definition(title: "Regression Test")[
  A *regression test* provides evidence that we have not unintentionally changed something that we did not intend to change
]

#definition(title: "Miller's Law")[
  *Miller's Law* states that, at any one time, a human is only capable of concentrating on approximately seven chunks of Integration
]

#remark[
  Miller's Law Applied:

  - Any large project will have much more then $7$ components
  - Hence we must start by working on $<= 7$ important components first temporarily ignoring the rest
  - This technique is known as *stepwise refinement*
]

== Life-Cycle Models 

Other life-cycle models 

1. Code and Fix Life-Cycle Model
2. Waterfall Life-Cycle Model
3. Rapid Prototyping Life-Cycle Model
4. Open Source Life-Cycle Model
5. Agile Processes 
6. Synchronize and Stabilize Life-Cycle Model
7. Spiral Life-Cycle Model 

#definition(title: "Code and Fix Life-Cycle Model")[
  Implement the software product without requirements, specification, or design

  *Strengths:*

  1. Thus technique may work on _very small_ systems ($<= 200$ lines of code)
  2. Easy to incorporate changes to requirements
  3. Generates a lot of lines of code 

  *Weaknesses:* 

  1. This technique is totally unsuitable for systems of any reasonable size
  2. This technique is unlikely to yield the optimal solution
  3. Slow 
  4. Costly 
  5. Likelihood of regression faults is high 

  #remark[
    Only really works for user base of size 1 (e.g. assignments)
  ]
]

#definition(title: "Waterfall (modified) Life-Cycle Model")[
  Augment the "vanilla" waterfall to include feedback loops during the project, and for post delivery maintenance. No phase is complete until all its documents are complete and approved by QA 

  *Strengths:* 
  
  1. Discipline enforced by QA

  *Weaknesses:*

  1. Specification documents may not be fully understood before they are approved
  2. Finished product product may not actually meet the clients needs 
]

#definition(title: "Rapid Prototyping Life-Cycle Model")[
  A rapid prototype is a working model that is functionally equivalent to a subset of the software product 
]

#definition(title: "Open Source Life-Cycle Model")[
  1. Single individual has an idea for a program, builds initial version, makes it available free of charge to anyone who wants a copy
  2. If there is sufficient interest then users become co-developers for post delivery maintenance
  3. All participants can offer suggestions
  4. Participation is voluntary and typically unpaid
  5. Success depends on the interest generated by the initial version
  6. In direct competition with enterprise software
]

#definition(title: "Agile Process")[
  1. Communication
  2. Speed 
  3. MVP is always kept in mind 
  
  *Scrum Method*

  _Requirements_
  
  - User Stories 
  - Prioritization
  - Making Backlog 

  _Sprints_

  - Daily Meetings 
  - Reassigning Tasks 

  Tries to ensure frequent delivery of new versions

  *Strengths:*
  
  1. Speed 
  2. Flexibility 
  3. Team Cohesion 
  4. Some history of success with smaller projects 

  *Weaknesses:*

  1. Heavy on meetings
  2. Not scalable with team size
]

#definition(title: "Synchronize and Stabilize Life-Cycle Model")[
  1. Pull requirements from the clients 
  2. Write specification documentation 
  3. Divide work into four builds 
    1. Critical 
    2. Major 
    3. Minor 
    4. Trivial 
  4. Carry out each build using small teams working parallel
  5. *Synchronize* at the end of each day 
  6. *Stabilize* at the end of each build  

  *Strengths:* 

  1. Users needs are met 
  2. Components are successfully integrated 
  3. Tolerant of changes to specifications 
  4. Encourages individual developers to be innovative and creative 
  5. Daily synchronization and build stabilization ensures developers will all work in the same direction 
  6. Good for large projects 
  7. Holay glaze what the jelly 

  *Weaknesses:* 

  1. Only been used successfully at Microsoft 
]

#definition(title: "Spiral Life-Cycle Model")[
  - Minimize risk inherent in software development by the use of constant *proof of concept prototypes* and other means 
  - Proof of concept aims to determine whether an architecture design is good

  We can make break this down into 

  1. Planning / Requirements
  2. Risk Analysis 
  3. Develop and Verify  
  4. Plan Next Phase 

  *Strengths:* 

  1. Emphasis on alternative sand constraints supports reuse and software quality
  2. This technique encourages doing the correct amount of testing

  *Weaknesses:* 

  1. This model is only meant for internal building of large scale software
  2. Project can look fine but really be heading for disaster 
  3. Makes assumptions that software is developed in discrete phases
]


#figure(
  image("images/lifecycles.png"),
)

#linebreak()

= The Software Process 

== Unified Process 

#linebreak()

#definition(title: "Software Process")[
  The *software process* encompasses the activities, techniques and tools used to produce software
]

#definition(title: "The Unified Process")[
  1. We want to explore the unified process, which will be our software development methodology for the rest of the course 
    - Object Oriented
  2. The workflows 
    - Task orientation 
  3. Phases have 
    - Economic context 
    - Time orientation
]

#definition(title: "Artifact")[
  An artifact is a work product from a workflow
]

#corollary(title: "Iteration and Incrementation within the Object Oriented Paradigm")[
  All variations on iteration and incrementation, including the unified process, attempt to preserve some classical structure, while being more tolerant of change than the classical model. 

  Under the unified process 

  1. Phases are the increments 
  2. we iterate through increments to complete the project
]

#definition(title: "Unified Modelling Language")[
  UML stands for Unified Modelling Language
]

#definition(title: "Model")[
  A model is a set of UML diagrams which describes one or more aspects of the software product to be developed
]

#remark[
  *What is the motivation behind these innovations*

  1. Even the best software engineers almost never get their artifacts right on the first attempt. So stepwise refinement will be needed
  2. UML diagrams are visual, hence more intuitive than block verbiage
  3. The visual nature of a UML model fosters collaborative refinement 
]

#linebreak()

== Summary of Requirements, Analysis, Design, and Implementation Workflows 

#linebreak()

#highlight[*Requirements Workflow*]

Requirement artifacts can be 

1. Incorrect (only client can detect this)
2. Ambiguous (e.g. AND versus OR in the inclusion criteria IT can detect this)
3. Incomplete (e.g. mission criterion to filter down to the program - only the client can detect this)
4. Contradictory (e.g. conflicting sort criteria - IT can detect this)

Using UML diagrams effectively helps to mitigate such problems with requirements

#linebreak()

#highlight[*Analysis Workflow*]

1. Analyze and refine the requirements to achieve the level of detail needed to begun designing the software and maintain it effectively later 
2. Once the analysis is complete, the cost and duration of the development are estimated $arrow.r$ create the Software Project Management Plan (SPMP)
3. Terminology: Deliverables, Milestones, and Budget

#linebreak()

#highlight[*Design Workflow*]

1. Show *how* the product is to do what it must do 
2. Refine the artifacts of the analysis workflow until the result is good enough for the developers to implement it
3. There are differences between the classical and the object oriented paradigms here
4. It is important to keep detailed records about design decisions

#linebreak()

#highlight[*Implementation Workflow*]

1. Implement the target software product in the chosen implementation language 
2. Usually code artifacts are implemented by different developers and integrated once implemented - thus design shortcomings may not come to light until the time of integration

#linebreak()

#highlight[*Test Workflow*]

1. Ensure the correctness of the artifacts from all other workflows 

#linebreak()

#highlight[*Requirements*]

1. Traceability: every later artifact must trace back to a requirement artifact 
2. Until implementation there will be no code to test, only documents. Hence we test by holding a review of the document, with the key stakeholders.

#linebreak()

#highlight[*Analysis*]

1. Tactic: Hold a review of analysis artifacts with key stakeholders chaired by QA
2. Review the SPMP too 

#linebreak()

#highlight[*Design*]

1. Design artifacts must trace back to analysis artifacts
2. Tactic: Hold a review of design artifacts

#linebreak()

#highlight[*Implementation*]

1. Some projects also incorporate *alpha* and *beta* testing 
2. Although it is tempting *alpha* testing should not replace thorough testing by the QA group 

#linebreak()

#highlight[*Post Delivery Maintenance*] 

1. This is *not* an afterthought - it must be planned from the start 
2. Pitfall: Lack of adequate documentation 
3. Testing changes must include *positive* and *regression* testing 

#definition(title: "Positive Testing")[
  Positive testing means testing that what you intended to change was changed in the desired way 
]

#linebreak()

#highlight[*Retirement*]

1. This is triggered when post delivery maintenance is no longer feasible or cost effective 
2. Usually a software product is replaced at this point
3. True retirements are rare

#linebreak()

== Unified Process Part II 

#linebreak()

#highlight[*The Interaction Between Phases and Workflows*]

1. Phases have a *time orientation*
2. workflows have a *task orientation*

Why separate the 2?

Moving target problem with iteration and incrementation leads to the splitting of tasks and time, which in turn leads us to the unified process.

#remark[
  *Goal:*
  Determine whether it is worthwhile to develop the target software product. Is it economically viable to build it?
]

#linebreak()


#highlight[*Requirements Workflow - Key steps*]

1. Understand what is 

#definition(title: "Domain")[
  The domain of a software product is the place 

  e.g. TV station, hospital air traffic
]

2. Build 

#definition(title: "Business Model")[
  A business model is a description of the clients business process
]

3. Determine the project scope 

4. The developers make the initial

#definition(title: "Business Case")[
  A *business case* is a document which answers these questions

  1. Is the proposed software cost effective? Will the benefits outweigh the costs? In what time frame? What are the costs of not developing the software?

  2. Can the proposed software be delivered on time? What impacts will be realized is the software is delivered late?

  3. What risks are involved in developing the software, and how can these risks be mitigated? 
]

#linebreak()

#corollary(title: "Major Risk Categories")[
  1. Technical risks
  2. Bad Requirements
  3. Bad Architecture 
]

#linebreak()

#highlight[*Analysis Workflow*]

*Goal:* Extract the information need to design the architecture 

#linebreak()

#highlight[*Design Workflow*] 

1. Create the design 
2. Answer all questions required to start implementation

#linebreak()

#highlight[*Implementation Workflow*]

1. Usually little to no coding happens during the inception phase 
2. Sometimes it will be necessary to build a proof-of-concept prototype 

#linebreak()

#highlight[*Test Workflow*]

*Goal:* Ensure that the requirements artifacts are correct

#linebreak()

#highlight[*Deliverables from the Inception Phase*]

1. Initial version of the domain model 
2. Initial version of the business model 
3. Initial version of the requirements artifacts 
4. Initial version of the analysis artifacts 
5. Initial version of the architecture 
6. Initial list of risks 
7. Initial use cases 
8. Plan for Elaboration phases 
9. Initial version of the business case 
  - Software is to be marketed this includes revenue projections, market estimates, initial cost estimates, etc
  - If software is to be used in-house, this includes the initial cost/benefit analysis

#linebreak()

#highlight[*Elaboration Phase*]

*Goals:*

1. Refine the initial requirements
2. Refine the architecture 
3. Monitor risk and refine their priorities 
4. Refine the business case
5. Produce the SPMP

*Deliverables:*

1. The completed domain model
2. The completed business model
3. The completed requirements artifacts 
4. The completed analysis artifacts 
5. Updated the version of the architecture 
6. Updated the list of risks 
7. SPMP
8. The completed business case 

#linebreak()

#highlight[*Construction Phase*]

*Goal:* 

Produce the first operational-quality version of the software product (the *beta* release)

*Deliverables:*

1. Initial user manual and other manuals
2. Completed version of the architecture 
3. Updated list of risks 
4. SPMP updated 
5. If needed, the revised business case

#linebreak()

#highlight[*Transition Phase*]

*Goal:*

Ensure the clients requirements have been met

*Deliverables:* 

1. Final versions of all the artifacts
2. Final versions of all manuals / other documentation

#linebreak()

== One versus Two Dimensional Life-Cycle Models

#linebreak()
*Question:* 

Can one's "position" in the Life-Cycle be described along only one axis, or does it need two axes 

*Example:*

#figure(
  image("images/1d2dmodels.png"),
)

#remark[
  1. Two dimensional models are more complicated, but we cant avoid them, especially the Unified Process 
  2. The Unified Process is the best model we have so far, but it will be surpassed in the future 
]

#definition(title: "Capability Maturity Models")[
  CMMs are related group of strategies for improving the software process, irrespective of the choice of Life-Cycle model used. 

  1. Software-CMM (our focus)
  2. People-CMM
  3. Systems Engineering
  4. Integrated Product Development-CMM 
  5. Software Acquisition-CMM

  These form CMM Integration (CMMI)
]

#definition(title: "Software Capability Maturity Models")[
  Use of new software techniques alone will not result in increased productivity and profitability, because our problems stem from how we manage the software process. Improving our management of the software process should drive improvements in productivity and profitability
]

#linebreak()

== Levels of CMM 

#linebreak()
An organization advances incrementally through five levels of maturity 

1. *Initial*
  1. No sound software engineering practices are in place
  2. Most projects are late and over budget 
  3. Most activities are responses to crises, rather than preplanned tasks 

2. *Repeatable*
  1. Basic Software Project Management practices are in place 
  2. Some measurements are taken 
  3. Managers identify problems as they arise and take immediate corrective action to prevent them from becoming crises 

3. *Defined* 
  1. The process for software production is fully documented 
  2. There is continual process improvement 
  3. Reviews are used to achieve software quality goals
  4. CASE environments increase quality / productivity further

#definition(title: "Computer Aided/Assisted Software Engineering (CASE)")[
  CASE stands for Computer Aided / Assisted Software Engineering
]

4. *Managed*
  1. The organization sets quality productivity goals for each software project 
  2. Both are measured continually and corrective action is taken when there are unacceptable deviations 
  3. Typical measure: faults / 1000 lines of code, in some time interval 

5. *Optimizing*
  1. The goal is continual process improvement 
  2. Statically quality / process control techniques are used to guide the organization 
  3. Positive Feedback Loop: Knowledge gained from each project is used in future projects. Therefore productivity and quality steadily improve


#linebreak  

= Teams

== Team Organization 

#linebreak()
To develop a software product of any significant size a team is required 

Suppose that a software product requires 12 person months to build it. Does it follow that 4 programmers could complete it in 3 months?

*No!!*

1. There are new issues once a team is involved 
2. Not all programming tasks can be fully shared in time or sequencing 

#definition(title: "Brook's Law")[
  Brooks Law states that adding programmers to an already late project makes it later 
]

#definition(title: "Classical Chief Programmer Team")[
  A classical Chief Programmer Team is a team organized according to some variation of the above picture, possibly with fewer or more programmers, and having the following roles

  *Chief Programmer:*
  - Highly skilled programmer 
  - Successful manager
  - Does architectural design
  - Writes critical / complex sections of the code 
  - Handles all interface issues 
  - Reviews the work of all team member 
  - Handles all interface issues 
  - Reviews the work of all team members

  *Backup Programmer*
  - Needed in case chief programmer wins the lottery, gets sick, falls under a bus, etc
  - As competent as the chief programmer in all respects 
  - Does tasks independent of design process 

  *Programmer Secretary (Librarian)*
  - Maintain the production library, including all project documentation 

  *Programmer*
  - They just program 
]

#remark[
  What are the strengths and weaknesses of Classical Chief Programmer Teams?

  *Strengths:*
  - Lots of success in a couple cases 

  *Weaknesses:*
  - Chief/backup programmers are hard to find 
  - Secretaries are also hard to find 
  - The programmers may be frustrated at being "second class citizens" under thus model 
]

#definition(title: "Egoless Programming")[
  1. Code belongs to the team as a whole, not any individual 
  2. Finding faults is encouraged 
  3. Reviewers show appreciation at being asked for advice, rather than ridiculing programmers for making mistakes 
]

#definition(title: "Democratic Team")[
  A team of $<= 10$ egoless programmers constitutes a democratic team 

  *Possible Managerial Issues:*
  1. For such collaboration to flourish, there must be a strong culture of open communication 
  2. The path for career advancement may not be clear

  *Strengths:*
  1. Rapid detection of faults $arrow.r$ higher quality code 
  2. Addresses the problem of programmers being overly attached to their own code

  *Weaknesses:*
  1. Managerial issues 
  2. It is hard to create such a team
  3. A certain organizational culture is required for such a team
]

#linebreak()

== Chief Programmer and Democratic Teams 

#linebreak()

Chief and Democratic are opposite ends of the spectrum 

*Classical Chief Programmer:* 
- Very hierarchical  
- Little individual freedom

*Democratic:*
- Little to no hierarchy 
- Much individual freedom 

#linebreak()

#highlight[*A Conflict Inherent in the Chief Programmer Model*]
- The Chief Programmer must attend all code reviews. They are responsible for every line of code as, as the Technical Manager of the team 

- *Resolution:* Split the Chief programmer role into a Team Manager (non-technical) and Team Leader (technical)

#linebreak()

== Open Source 

#linebreak()

*Why might people not want to participate in open source projects?*

- Unpaid 
- Philosophical disagreements about direction 
- You don't own the code and can't monetize it 
- You give up control over the finished product and give away your effort 

*Why might you contribute to an open source project?*

- Fix a bug your facing 
- You believe in the product / it has value to you 
- You admire the lead maintainer 
- You feel better "making the world a better place"
- Learning experience for your next job 

#linebreak()

== Morals 

1. For success, high quality programmers are required. They can succeed even in an environment as unstructured as open source one typically is

2. Provided \#1 holds, the way that a successful open source project team is organized is essentially irrelevant to the success or failure of the project 

#figure(
  image("images/figure47.png")
)

#figure(
  image("images/figure472.png")
)

- There is no choice of team organization that is optimal in all situations

#pagebreak()

= Tools of the Trade 

#linebreak()

1. Stepwise Refinement 
2. Cost Benefit Analysis 
3. Divide and Conquer 
4. Separation of Concern 
5. Software Metrics 
6. Taxonomy of CASE 
7. Scope of CASE 
8. Software Versions 
  1. Revisions 
  2. Variations 
  3. Moral 
9. Configuration Control 
  1. Configuration Control During post-delivery maintenance
  2. Baselines 
  3. Configuration Control During Development 
10. Build Tools 
11. Productivity Gains with CASE Technology 

#linebreak()

== Stepwise Refinement

#linebreak()

#definition(title: "Stepwise Refinement")[
  Stepwise Refinement is a technique by which we defer nonessential decisions until later, while focusing on the essential decisions first
]

- This is a response to Millers Law
- *Key Challenge:* Decide which issues must be handled in the current refinement, and which can be deferred until a later refinement. 

- Brainstorming can be used in early stages
- Features of brainstorming
  - The problem to be solved initially be unclear
  - All team members are encouraged to speak, especially the shy ones 
  - No editing in the first round, when ideas are being suggested 

#linebreak()

== Cost Benefit Analysis

#linebreak()

#definition(title: "Cost-Benefit Analysis")[
  Cost Benefit Analysis is 

  - A technique for determining whether a possible course of action would be profitable, in which we 
    - Compare estimated future benefits against estimated future costs,
    - Often referred to as the "balance sheet view"
    - When selecting among several options the optimal choice maximizes the difference

  $
    ("estimated benefits") - ("estimated costs")
  $
]

- *Pitfalls*
  - We must quantify everything to start 
  - Some things are easier to quantify than others 

- *Tangible Benefits* 
  - Tangible benefits are easy to measure, e.g. estimated revenue from launching a new product 

- *Intangible Benefits*
  - Intangible benefits can be more challenging to quantify, e.g. the reputation of your organization 

#linebreak()

== Divide and Conquer 

#linebreak()

#definition(title: "Divide and conquer")[
  Is it break a large problem down into sub-problems, each of which is easier to to solve.
]

#definition(title: "Analysis Package")[
  An analysis package is defined by: 
  During the analysis workflow:

  1. Partition the software product into analysis packages 
  2. Each package consists of a set of related classes that can be implemented as a single unit
]

- During the design workflow:
  - Partition the implementation workflow into corresponding manageable pieces, termed subsystems 
- During the implementation workflow:
  - Implement each subsystem in the chosen programming language 


- *Divide and Conquer Key Problem:* There is no algorithm for deciding how to partition a software product into smaller pieces. Experience and human intuition are required.

#linebreak()

== Separation of Concerns 

#linebreak()

#definition(title: "Separation of Concerns")[
  A software product has separation of concerns if it is broken in components that overlap as little as possible with respect to their functionalities
]

- Separation of concerns is the "new and improved" divide and conquer
  - Guiding Principal: Reduce / eliminate overlap in functionalities between the subsystems created by dividing them 

- *Motivation:*
  - Minimize the number of regression faults. If separation of concerns is truly achieved then changing one module cannot affect another module 
  - When done correctly this also facilitates reuse of modules in future software products 

- *Manifestation of Separation of Concerns:* 
  - Design technique of high cohesion
  - Design technique of loose coupling 
  - Encapsulation
  - Information hiding 
  - Three tier architecture

#remark[
  Separation of concerns is desirable for Software Engineering
]

#linebreak()

== Software Metric 

#linebreak()

#definition(title: "Metric")[
  A metric is anything that we measure quantitatively 
]

- We need metrics to detect problems early in the software process before they become crises 

- Two types: 
  - Product metrics: e.g. \# of lines of code 
  - Process metrics: e.g. turn over rate

- Five essential fundamental metrics for software project:
 1. Size (e.g. in \# lines of code)
  2. Cost to develop / maintain (in dollars)
  3. Duration to develop (in months)
  4. Effort to develop (in person-months; or as in my experience in person days)
  5. Quality (number of faults detected during the project)

- Augment this list as appropriate for your project 

- There is no universal agreement among software engineers which metrics are right

#linebreak()

== Taxonomy of CASE 

#linebreak()

- CASE stands for Computer Aided/Assisted Software Engineering
- At present a computer is a tool of and not a replacement for a software professional 
- CASE tools used tools during the 
  - Earlier workflows are called front-end or upperCASE tools, and 
  - Later workflows (implementation postdelivery maintenance) are called backend or lowerCASE 

- Examples:
  - Data dictionary 
  - Consistency checker 
  - Report Generator 
  - Screen Generator 

- Combining multiple tools creates a workbench 
- Combining multiple workbenches creates an environment 
- So our taxonomy is: tools (task level) $arrow.r$ workbenches (team level) $arrow.r$ environments (organization level)

#linebreak()

== Scope of CASE 

#linebreak()

Primary motivations for implementing CASE: 

1. Produce high quality code 
2. Have up to date documentation at all times 
3. Automation makes maintenance easier 
4. Do everything more quickly, hence more cheaply 

Coding tools of Case: 
 - Text editor 
 - Debuggers 
 - Formatters 

- *Programming in the small:* Coding a single module 
- *Programming in the large:* Coding at the system level
- *Programming in the many:* Software production by a team 

#definition(title: "Revision")[
  A revision is created when a change is made, e.g. to fix a fault 
]

- Old revisions must be retained for reference
  1. If a fault is found at a site still running the old revision
  2. For auditing 

#definition(title: "Variation")[
  A variation is a slightly changed version that fulfills the same role in a slightly changed situation 
]

#remark[
  A CASE tool is needed to effectively manage multiple revisions of multiple variations 
]

#definition(title: "Configuration")[
  A configuration of a software product is a list, for every code artifact, of which version is included in the software product
]

#definition(title: "Configuration Control Tool")[
  A configuration control tool is a CASE tool for managing configurations 
]

- *configuration Control:*
  - *Motivation:* Fix software faults effectively 
  - The first step towards fixing a problem is to recreate it in a development environment
  - If many configurations are possible, then configuration control will be needed in order to recreate problem in a development environment
  - Version control also facilitates ensuring that the correct versions get included when compiling / linking
  - A common technique is to embed the version as part of the name 
  - Adding details to a configuration yields a derivation of a software product 

#definition(title: "Derivation")[
  A derivation is a detailed record of a version of the software product including 

  - The variation / revision of each code element (i.e. Configuration)
  - The versions of the compilers/linkers used to assemble the product 
  - the date / time of assembly
  - The name of the programmer who created the version 
]

#remark[
  A version control tool is required to effectively track derivations 
]

#highlight[*Configuration Control During Post-Delivery Maintenance*]

- There is an obvious problem when a team maintains a software product 
- Suppose that two programmers receive two different fault reports. Suppose further that fixing both faults requires changes to the same code artifact 
- Without any new process in place, the programmer \#2 will undo programmer \#1 changes at deployment time 

#highlight[*Baselines*]

- When multiple programmers are working on fixing faults a baseline is needed 
- A baseline is a set of versions of all the code artifacts in a project 
- A programmer starts by copying the baseline files into a private workspace. The he can freely change anything without affecting anything else 
- After the fault is fixed, the new code artifact is promoted to production, modifying the baseline 
- The old, frozen version is kept for future reference, and can never be changed
- This technique extends to multiple programmers and multiple code artifacts 

#highlight[*Configuration Control During Development*]

- During Development and Desk Checking, changes are too frequent for configuration control to be useful 
- We definitely want configuration control to be in force by the time deploy to production 
- The text author recommends that configuration control should apply once the code artifact is passed off to the QA team 
- The same configuration control procedures as those for postdelivery maintenance should then apply 
- Proper version control permits management to take corrective action if project deadlines start to slip 

#definition(title: "Build Tool")[
  A build tool selects the correct compiled code artifact to be linked into a specific version of the software product
]

#highlight[*Build Tools*]

- Some organizations may not want to purchase a complete configuration control solution 

- *Issue*
  - While version control tools assists programmers in deciding which version of the source code is the latest, compiled code not not automatically get a version attached to it 

#highlight[*Productivity Gains with CASE Technology*]

- Research to date shows a modest gain in productivity following the introduction of CASE tools to an organization 
- Other benefits of using CASE tools:
  - Faster development 
  - Fewer faults 
  - Better usability 
  - Easier maintenance 
  - Improved morale on the IT team

#figure(
  image("images/figure514.png")
)

#pagebreak()

= Testing - Non-Execution Based Testing

#linebreak()


- Quality Issues 
  - Software Quality Assurance 
  - Managerial Independence 
- Non-Execution Based Testing 
  - Reviews 
  - Walkthroughs 
  - Managing Walkthroughs 
  - Inspections 
  - Comparison of Walkthroughs and Inspections
  - Strengths and Weaknesses of Reviews 
  - Metrics for Inspections 

#linebreak()

== Quality Issues 

#linebreak()

#definition(title: "Failure")[
  A failure is an observed incorrect behaviour of the software product cased by a fault 
]

#definition(title: "Error")[
  Error is the amount by which the software product output is incorrect 
]

#definition(title: "Defect")[
  A defect is a generic term for a fault failure or error 
]

#definition(title: "Quality")[
  Quality describes the extent to which the software product satisfies its specification 
]

#linebreak()

== Software Quality Assurance (QA)

#linebreak()

- Quality alone is not enough: software must be easily maintained.
- QA must be built in throughout the project, not simply imposed by the QA group at the end of a workflow

- Primary duty of a QA group: 
  - The quality of the software process 
  - The quality of the software product 
- Once a workflow is complete, QA verify that all artifacts are correct

#linebreak()

== Managerial Independence 

#linebreak()

- Development and QA teams should be led by independent managers, neither of whom can overrule the other

- Reason: Often faults are found towards end of deadlines. We must decide between 
  - Delivering the software on time with faults
  - Fixing the faults and delivering late  

- Both most report to a third manager who must then make the decision about what to do on a case by case basis 

#linebreak()

== Review

#linebreak() 

#definition(title: "Review")[
  A review is a walkthrough or an inspection 
]

- Common Features of All Reviews 
  - Non-execution based testing 
  - Centred around a meeting of key stakeholders
  - Chaired by QA representative 
  - The meeting is to test a document to identify, but not attempt to fix, faults in that document
    - Committees solution is usually of lower than that of trained expert 
    - Committees solution takes 4-6 times as much effort as individual 
    - Not all faults identified during review are truly faults 
    - Takes too much time 


#linebreak()

== Walkthroughs 

#linebreak()

- #highlight[The two steps for a walkthrough]
  1. Preparation 
  2. Team analysis of the document 

- #highlight[4-6 participants]
  1. QA (chair)
  2. Manager responsible for requirements 
  3. Manager responsible for analysis
  4. Manager responsible for design 
  5. Client representative 

- #highlight[Two fundamental approaches to conducting a walkthrough]
  1. Participant driven 
  2. Document driven (more detailed, but time consuming)


#linebreak()

== Inspections 

#linebreak()

- #highlight[The five steps for an inspection:]
1. *Overview* document author gives the overview
2. *Preparation* participants examine the document
3. *Inspection* quick document walkthrough
4. *Rework* document author corrects all faults noted in the written report 
5. *Follow Up* moderator ensures that every fault identified has been fixed and that no new faults were introduced in the process 

- #highlight[Roles for an Inspection]
  1. Moderator (QA)
  2. Analyst (i.e. stakeholder, previous workflow)
  3. Designer (i.e. Document author; stakeholder, current workflow)
  4. Implementer (i.e. stakeholder, next workflow)
  5. Tester (QA, a different person than the moderator)


#linebreak()

== Comparison of Walkthroughs and Inspections 

#linebreak()

Although inspections are more costly there is evidence that they are most effective at finding faults 

#linebreak()

== Strengths and Weaknesses of Reviews 

#linebreak()

- *Strengths*
  - Effective at detecting faults, especially early in the life cycle when they are cheaper to fix 
  
- *Weaknesses*
  - A large software products artifacts are hard to review unless they consists of smaller independent components
  - Effectiveness of review team is hampered if not all documentation from the previous workflow is completed yet 

#linebreak()

== Metrics for Inspections 

#linebreak()

1. *Inspection Rate:*
  - Requirements / design: \# of pages / hour 
  - Code: \# of lines of code / hour 
2. *Fault Density:*
  - Requirements / design: \# of faults / page 
  - code: \# of faults / 1000 lines of code 
3. *Fault detection rate:*
  - \# of faults detected / hour 
4. *Fault detection efficiency:*
  - \# of faults detected / person hour 


#remark[
  - Metrics attempt to measure our effectiveness at finding faults 
  - Spike in faults might mean decrease in software quality, not increase in QA effectiveness 
]

#pagebreak()

= Testing - Execution Based Testing 

#linebreak()

1. *Execution Based Testing* 

- Testing is a crucial part of any software development life-cycle 
- However we must keep in mind that, testing can demonstrate the presence of faults in a software product, not their absence 

remark[
  Test cases are only as good as the tester selecting them. Things can get missed.
]

#definition(title: "Execution Based Testing")[
  Execution Based Testing is a process of inferring certain behavioural properties of  software product, in part, on the results of running the software product in a known environment with selected inputs
]

#warning-box[
  Troubling Details about the definition:

  1. Testing is an *inferential* process: There is no algorithm for determining whether faults are present. A test run with all correct results may simply fail to expose faults

  2. What do we mean by known environment? : We can never fully know our environment. Even if software is perfect there could be a hardware fault.

  3. What do we mean by selecting inputs? : With real time system no control over the inputs is possible 
]

#definition(title: "Utility")[
  The *utility* of a software product is the extent to which the software product meets the users needs when operated under conditions permitted by its specification
]

#remark[
  If a software product fails a test of its utility then testing should proceed no further
]

#definition(title: "Reliability")[
  The reliability of a software product measures the frequency and severity of its failures

  1. Mean time between failures: long times $arrow.r$ more reliable
  2. Mean time to repair failures: Long times $arrow.r$ less reliable
]

1. *Robustness*

- Range of operating conditions, beyond outside its specifications 
- Produces acceptable output given acceptable input 
- Produces acceptable output given unacceptable input 

2. *Performance*

- Its crucial to verify that a software product meets its constraints with respect to 
  - Space constraints which an be critical in miniature applications 
  - Time constraints which can be critical in real time applications

#definition(title: "Correct")[
  A software product is correct if it satisfies its output specification, without regard for computing resources consumed, when operated under permissible (pre)conditions 
]

#warning-box[
  Problems with Correctness:

  1. Specifications can be wrong
    - A software product can be correct but not acceptable 
    - A software can be acceptable but not correct 
]


#linebreak()

= Testing - Proving Program Correctness

#linebreak()

#definition(title: "Correctness Proof")[
  A correctness proof is a mathematical technique for demonstrating that a program is correct
]

#remark[
  go over this later 
]
 
#linebreak()

= OO Paradigm

== Cohesion and Coupling 

#linebreak()

#definition(title: "Module")[
  A module is a lexically continuous sequence of program statements, bound by boundary elements and having aggregate identifier 
]

#remark[
  1. Every function / procedure of the classical paradigm is a module 

  2. In the OO paradigm, every class and every method within a class is a module 
    1. The main idea of OO is to keep data, and operations on that data, together 
    2. We need to be clear about the difference between the program statements that define the properties (a.k.a attributes) of a class, and some instantiation of that class. Only an instantiation of a class can actually contain data
]

#definition(title: "Composite and Structured Design")[
  C/SD is an acronym for composite / structured design 

  1. The aim of C/SD is to apply common sense to make software product designs "make sense"
  2. C/SD done well achieves separation of concerns
]

#definition(title: "Cohesion")[
  Cohesion of a module is the degree of interaction within that module 
]

#definition(title: "Coupling")[
  Coupling of a pair of modules is the degree of interaction between the two modules
]

#important-box[

  1. Low cohesion, tight coupling $arrow.r$ bad 

  2. High Cohesion, loose coupling $arrow.r$ good 
]

#remark[
  Why is coupling is important:

  1. Tight coupling means a higher probability of regression faults

  2. Suppose modules $p$ and $q$ are tightly coupled
    - The it is likely that making a change to $p$ requires a change to $q$ 
    - Not making the change to $q$ likely causes a fault later on 
    - Making the change to $q$ adds time, and hence cost to the project 

  3. The stronger the coupling with some other module the more fault prone a module is 
    - This makes it more costly and difficult to maintain 
]

#pagebreak()

== Encapsulation and Abstraction

#linebreak()

#definition(title: "Encapsulation")[
  In OO programming, encapsulation refers to 

  1. A language construct for bundling data with the methods (or other functions) operating on that data 
]

#definition(title: "Information Hiding")[
  In many languages hiding of components is not automatic or can be overridden. Thus information hiding is defined separately.

  Encapsulation plus information hiding is used to hide the values of a structured data module, preventing unauthorized parties direct access to them 

  Public accessible methods are provided (getters and setters) to access the values; other client modules call these modules to retrieve / modify the values within the module  
]

#linebreak()

#remark[
  - Hiding the internals of the module protects its integrity by preventing users from setting the internal data of the module into an invalid / inconsistent state 

  - A benefit of encapsulation is that it can reduce system complexity, thus increase reliability, by allowing the develop to limit inter-dependencies between software components 

  - Encapsulation is supported by using classes in OO programming 

  - Encapsulation is not unique to OO programming. Abstract data types offer similar form of encapsulation

]

#linebreak() 

#definition(title: "Abstraction")[
  Abstraction is suppressing irrelevant details and accentuating relevant details 
]

#definition(title: "Data Abstraction")[
  Abstraction done on data 
]

#definition(title: "Procedural Abstraction")[
  Abstraction done on code
]

#linebreak()

#remark[
  - Abstraction is a way of simplifying things so that they become easier to understand 

  - Effective abstraction helps us to see how things which appear different at first glance are actually the same in all relevant ways 

  - In software development, abstraction lets us focus on what a module does and not on how the module does it 
]

#linebreak()

#remark[
  - Abstraction is a means of achieving stepwise refinement 

  - Effective abstraction guides us to good choices of what to encapsulate when we design and develop our software 
]

#linebreak() 

#example[
  An example of *data abstraction* 

  - A List lets you use operations like `add(item)` and `get(index)`
  - You don’t see whether it's implemented using an array or a linked list

]

#pagebreak()

== Abstract Data Types, Information Hiding and Objects 

#linebreak()

#definition(title: "Abstract Data Type (ADT)")[
  An abstract data type (ADT) is a mathematical model of 

  - The data objects comprising a data type
  - the functions that operate on these data objects 

  Each operation/functions must be defined by some algorithm
]

#linebreak()

#remark[
  - The difference between data structure and ADTs is that data structure have concrete representation from the view point of an implementer 

  - Using abstract data types supports data and procedural abstraction

  - Abstract data points are preferred from the development and maintenance perspective 
]

#linebreak()

#definition(title: "Information Hiding")[
  Information hiding means hiding the implementation details of a module (data + code) from the outside world 
]

#linebreak()

#highlight[How information hiding is useful at design time]

- Make a list of implementation decisions which are likely to change in the future 

- Design the resulting modules such that these implementation details are hidden from the other modules 

- This protects other parts of the software product from changes to the implementation of the module 

#linebreak()

#important-box[
  - A module affords this protection by 
    - Encapsulating the data / operations to be hidden together 
    - Hiding the details using a language construct like private 
    - providing a stable interface 
  
  - A class may be implemented 
    - without information hiding $arrow.r$ bad 
    - with information hiding $arrow.r$ good 
]

#linebreak()

#definition(title: "Class")[
  A class is an abstract data type that supports inheritance
]

#definition(title: "Inheritance")[
  Inheritance allows a new data type to be defined as an extension of a previously defined type, rather than having to be defined from scratch 
]

#linebreak()

#example[
  1. Start with a person class, having:

    - Properties / Attributes 
      - `LastName`
      - `FirstName`
      - `DateOfBirth`
    - Methods 
      - `createFullName`
      - `createEmail`
      - `computeAge`
  
  2. Then define a Student class, having all the Properties / Methods of `Person`, plus

    - Properties 
      - `StudentNumber`
      - `CumulativeAverage` 

  3. Then each `Student`

    - inherits from `Person`
    - isA `Person`
    - is a specialization of `Person`

  Here is a diagram of the relationships between these classes
  
  #figure(
    image("images/inheritance.png", height: 25%),
  )
]

#linebreak

#definition(title: "Object")[
  An object is an instantiation of a class
]

#linebreak()

#remark[
  - Only an instantiation of a class (object) can actually contain data 

  - A class contains the data definitions, but cannot contain actual data
]

#linebreak()

#definition(title: "Aggregation / Composition")[
  Aggregation / Composition refers to the component classes of a larger class 

  i.e grouping related classes creates a larger class 

  #figure(
    image("images/computer.png", width: 70%)
  )
]

#definition(title: "Association")[
  Association refers to a relationship (of some kind) between two apparently unrelated classes 
  
  i.e. The `Radiologist` class consults the `Lawyer` class
  #figure(
    image("images/radiologist.png", width: 70%)
  )
]

#pagebreak()

== Inheritance, Polymorphism, and Dynamic Binding 

#linebreak()

#example[
  
  1. Consider a `File` class with an `Open` method

  2. An instantiation of a `File` might be on stored on 
    - hard disk 
    - flash drive 
    - tape 
    
    so each `Open` method must e different in each situation 

  3. The `File` base class derived classes 
    - `HardDiskFile`
    - `FlashDriveFile`
    - `TapeFile`

  4. The `File` class has a dummy `Open` method
]

#linebreak()

#definition(title: "Dynamic Binding")[
  At run time, the system decides which `Open` method to invoke. This is called dynamic binding.
]

#definition(title: "Polymorphic")[
  The `Open` method is called polymorphic, because it applies to different subclasses different 
]

#linebreak()

#warning-box[
  Problems with Dynamic Binding / Polymorphism

  1. We cannot determine at compile time which version of a polymorphic method will be called at run time. This can make failures hard to diagnose

  2. Software products that make heavy use of polymorphism can be hard to understand, hence hard to maintain and enhance 
]

#linebreak()

#highlight[Summary of Reasons Why OO is Better than Classical]

1. OO treats data and operations on that data together with equal importance 

2. So a well designed class does a good job of modelling some real world entity 

3. A well designed class fosters re-use 

4. High cohesion + loose coupling $arrow.r$ fewer regression faults 

#pagebreak()

#highlight[History of Software Engineering]

$arrow.r$ 1960s no software engineers

$arrow.r$ Code and Fix was the norm 

$arrow.r$ Classical model was used  

$arrow.r$ Classical model increased productivity

$arrow.r$ OO was proposed as better alternative for larger and more complex software products 

#linebreak()

#highlight[Problems with OO]

There is a learning curve associated with adopting the OO paradigm for the first time. 
It takes longer the first time then doing it with the Classical model.
This is worse with large GUI components 

But 

1. The reuse of classes pay back the initial investment 

2. Post delivery maintenance costs are reduced

#linebreak()

#definition(title: "Fragile Base Class Problem")[
  Any change to the base class affects all of its descendants. This phenomenon is known as the fragile base class problem.

  - In the best case, all descendants need to be recompiled after the case class is changed 
  - In the worst case, all descendants have to be recoded then recompiled. This is bad!
]

#linebreak()

#warning-box[

  - Unless explicitly prevented, every subclass inherits all the Properties / Methods of its parent. The reason to create a subclass is to add Properties / Methods. Hence objects lower in the inheritance tree can quickly become large, leading to storage problems 

  - Recommendation: Change our philosophy from "use inheritance whenever possible" to "use inheritance whenever appropriate"

  - Also explicitly Properties / Methods from being inherited, where this makes sense 
]

#linebreak()

#warning-box[
  
  - One can code badly in any language or paradigm 

  - This is especially true with OO languages since we can add unnecessary complexity 

]

#pagebreak()

= Reusability

#linebreak()

1. #highlight[Advantages of Reuse]

  - Save time / resources during development / testing 

  - Maintenance becomes cheaper 

  - Library subroutines are tested and well documented 


2. #highlight[Pitfalls of Reuse]

  - Depending too heavily on reuse can make us averse to writing new code even when needed 

  - Suppose that we need to extend / enhance an existing module before we can reuse it. This risks introducing regression faults for existing consumers of the module 

  - Old modules might not be as good 

  - Compatibility issues

  - Writing a module to handle multiple situations can make the module less efficient than if it was separate modules for each section

  - Undetected faults propagated 

  - Documentation is often poor 


4. #highlight[Reuse refers not only to code but also]

  - Documents 

  - Duration / Cost Estimates 

  - Test data 

  - Architecture 


5. #highlight[Impediments to Reuse]

  - Sometimes, what is a candidate for being reused is not obvious 
    - Poor documentation to contribute to this problem 
    - If we abstract effectively during analysis / design workflows, what to reuse becomes clearer 

  - QA test cases to outdated to reuse 

  - Ego: Willingness to use someone else's code 

  - Quality concerns 

  - Reuse can be expensive 

  - Legal issues (IP problems)

#pagebreak()

What are the types of reuse?

#linebreak()

#definition(title: "Accidental / Opportunistic Reuse")[
  Developer of a new software product realizes that a previously developed module can be reused as a subroutine in a new software product 
]

#definition(title: "Deliberate / Systematic Reuse")[
   Software Modules are specially designed and constructed to be used in multiple software products 
]

#linebreak()

#remark[
  OO classes are the best type of module that we know about for fostering reuse 
]

#quote-box[
  holy OO glaze bruh 
] 

#linebreak()

Diagrams for each type of reuse have 

- Shaded areas for the parts that are reused 
- White space for the parts that the reuser must supply 

#corollary(title: "Library (toolkit)")[

  #figure(
    image("images/library.png", width: 60%)
  )
  
  *What is reused:* Library with a set of reusable operations 

  *What is new:* Supply control logic of software 
]

#corollary(title: "Application Framework")[

  #figure(
    image("images/application.png", width: 60%)
  )

  *What is reused:* Opposite to library, control logic is reused

  *What is new:* Design application specific subroutines inside the control logic
]

#linebreak()

If the goal is to improve software development, then reusing a framework will be more effective than using libraries

  - More effort to design control logic 
  - Less effort to develop application specific subroutines 

#linebreak()

#definition(title: "Software Architecture")[
  Software architecture encompasses a wide range of design issues including,

  - organization of components 
  - control structures 
  - communication
  - DB organization and access 
  - Performance 

  Architecture can also be reused 
]

#corollary(title: "Component Based Software Engineering")[
  *Goal:* Construct a standard library of reusable components 
] 

#pagebreak()

= Design Patterns 

#linebreak()

#definition(title: "Design Pattern")[
  A design pattern is a solution to a general design problem, in the form of a set of interacting classes that have to be customized to create a specific design 
]

- What is reused: Relationships among classes 
- What is new: Details within each class

#definition(title: "Abstract Class")[
  An abstract class is a class which cannot be instantiated, but can be used as a base class for inheritance 
]

#definition(title: "Abstract Method")[
  An abstract method is a method which has an interface, but which does not have an implementation 
]

- Abstract methods are implemented in subclasses of the abstract class 
- It provides a way for an object to permit access to its internal implementation in such a way that clients are not coupled to the structure of that internal implementation $arrow.r$ benefits of information hiding without actually hiding the implementation details 

#linebreak()

#remark[
  Categories of Design Patterns

  1. Creational e.g. Abstract Factory 

  2. Structural e.g. Adapter, Bridge 

  3. Behavioural e.g. Iterator, Mediator 
]

#linebreak()

#highlight[Strengths of Design Patterns]

1. Promote reuse by solving a general design problem 

2. Provide high level documentation of the design, because patterns specify design abstractions 

3. May already have implementations written

4. Make maintenance easier for programmers who are familiar with the patterns 

#linebreak()

#highlight[Weaknesses of Design Patterns]

1. Lack a systematic way to determine when patterns should be applied 

2. Often require multiple patterns together, which is complicated 

3. Are incompatible with the Classical paradigm 

#linebreak()

#remark[
  Improvement in software methodology has bigger payoff in maintenance than it does in development 
]

#pagebreak()

= Portability

#linebreak()

#definition(title: "Portability")[
  A program P1 is portable if it is significantly cheaper to convert it to P2 than to recode P2 from scratch 
]

#remark[
  Portability does not mean porting the code only. We must port documentation and manuals too 
]

#definition(title: "Hardware Incompatibilities")[
  Character Codes: 

  - ASCII
  - EBCDIC 
  - UNICODE 

  Software developed on a platform with on encoding must be modified to work on a platform with the other encoding 
]

#definition(title: "Operating System Incompatibilities")[
  - MAC OS versus Windows
]

#definition(title: "Numerical System Incompatibilities")[
  Word Size:

  32-bits vs 64-bit cpus 
]

#definition(title: "Compiler Incompatibilities")[
  Different compilers versions can enforce different syntax rules 
]

#linebreak()

#problem[
  Is portability really necessary?
]

#solution[
  Yes.

  1. If your firms business is selling software portability = higher revenue 

  2. Even if not good software lives 10-20 years more while hardware changes ever 4-5 years, so portability saves money 
]

#linebreak()

#definition(title: "Unix")[
  UNIX operating system was constructed for maximum portability  

  More of the code base is platform independent making it ease to port 
]

#remark[
  Lessons of UNIX 

  1. We should emulate the techniques used to design / build UNIX, as much as possible 
  2. When we have a choice of operating system choose UNIX 
]

#quote-box[
  W UNIX propaganda
]

#remark[
  We should try to use high level language $arrow.r$ more insulated from the hardware level / resilient to change in hardware 
]

#corollary(title: "Portable Data")[
  Porting large amounts of data can be very problematic. This is necessary for things like disaster recovery.

  - Flat files are the most portable data format 
]

#linebreak()

Major promise of OO technologies: 
Final product is portable and reusable 

#pagebreak()

= Planning and Estimation 
== Function Points 

#linebreak()

Our ranges of estimates must be broad 

*After requirements workflow:* We provide a preliminary estimate here, so that the client can decide whether to proceed to analysis or not 

*After analysis workflow:* A more detailed understanding of what is needed

#caution-box[
  You may find yourself getting pressured to reduce preliminary estimates to ensure a project goes ahead.

  If cost is too high client can:

  - Reduce the scope of the requirements 
  - Increase total budget 

  Giving into pressure to reduce costs *always* leads to problems later on  
]

#corollary(title: "All costs of Development")[
  1. Internal 
    - Salaries of project tea members 
    - Cost of hardware and software 
    - Overhead costs 

  2. External 
    - Usually internal costs plus some mark up 

  #quote-box[
    milk those mfs ong 
  ]
]

#definition(title: "Estimating Duration")[
  Client will need to know when to expect software product to be delivered
]

#linebreak()

#highlight[Obstacles to Estimating Accurately]

1. Human 
  - Variations in quality 
  - turnover 
  - Varying levels of experience 

#linebreak()

#definition(title: "Function Points")[
  Functions points provide a consistent basis for comparing the sizes of different software products 

  Advantages of FP over LOC (lines of code):

    - Independent of implementation (some languages can be more verbose $arrow.r$ more code for the same thing)
    - We can count FP after the analysis workflow, i.e. before the code is written (useful for project management)
]

#pagebreak()

== Intermediate COCOMO

#linebreak()

#definition(title: "KDSI")[
  KDSI stands for Thousands Delivered Source Instructions (i.e. 1000s of lines of code)
]

#corollary(title: "Techniques for Cost Estimation")[
  1. There is no perfect technique for estimating the cost / duration of a software product 

  2. Some factors to consider 
    - Skill levels of project personnel 
    - Complexity of project 
    - Project deadlines 
    - Target hardware 
    - Availability of CASE tools 
]

#corollary(title: "Techniques for Cost Estimation")[
  1. Expert judging by analogy 
    - compare to similar past projects 

  2. Bottom Up approach
    - Analogous to divide and conquer 
  
  3. Algorithmic Cost Estimation Models 
    - Compute the size of the software product using function points
    - Use size to estimate cost and duration 
]

#definition(title: "Intermediate Constructive Cost Model (COCOMO)")[
  1. COCOMO comprises three models (highest level $arrow.r$ lowest level):
    - Macro estimation 
    - Intermediate 
    - Micro estimation 

  2. Two stages in Intermediate COCOMO 
    - Nominal effort 
    - Estimated effort 
]

#definition(title: "COCOMO II")[
  1. COMOCO is based on LOC (or KDSI)

  2. 3 applications of COCOMO II
    - Application composition model
    - Early design model 
    - Post architecture model 

  3. Where COCOMO outputs a single estimate, COCOMO outputs a range of estimates for each model 
]

#remark[
  Key ideas:

  1. It is rare for a software project to be completed (i.e. my personal projects) ahead of schedule and under budget. Deviations from estimates usually make the project late and over budget

  2. Hence it is critical to detect deviations from our estimates ASAP, to correct it 
]

#pagebreak()

== Project Management


Three main components 

1. The work to be done 
  - project functions continue throughout the project not related to any workflow 
  - Activities / tasks are related to particular work flow 
  - Activities $arrow.r$ major units of work 
  - Tasks $arrow.r$ minor units of work

2. The resources with which to do the work 
  - people 
  - hardware 
  - software 
  
  Including the timing of when those resources should be consumed 

3. Money to pay for t all 
  - How and when it will spent 


#definition(title: "Software Project Management Plan (SPMP) Framework")[
  Omitted not tested 

  praise god
]

#corollary(title: "Planning Testing")[
  Include a detailed schedule for what testing must be done during each workflow
]

#remark[
  Planning / estimation tools (FP, COMOCO) work for OO and Classical assuming no reuse
]

#corollary(title: "Training Requirements")[
  Training requirements should be for everyone not just clients:

    - Developers may need project management training 
    - New development techniques may need training 
    - New hardware many need training 
]


#important-box[
  *Affirmations:*

  1. You are smart and sexy 

  2. You will ace the exam 

  I hope this helped goodluckk on the final <\3
]
