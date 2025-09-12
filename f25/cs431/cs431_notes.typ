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
    Fall 2025 - Dan Holtby
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
  title: [CS 431 Course Notes: \ Data Intensive Distributed Analytics ],
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

= Introduction 

== Big Ideas 



#proposition(title: "Scale 'out', not 'up'")[
  For data-intensive workloads, a large number of commodity low-end servers (i.e. scaling "out") is preferred over a small number of high-end servers (i.e. scaling "up")

  #highlight("Cost Considerations:")

  - *Scaling up (Symmetric Multiprocessing SMP machines):*
    - Not cost effective because costs do not scale linearly
    - A machine with twice the processors often costs much more than twice as much

  - *Scaling Out (Commodity Servers):*
    - Benefits from overlap with high-volume desktop market
    - Prices are kept low by competition, interchangebale components, and economies of scale

  #highlight("Performance Trade Offs:")

  - *High-end SMP server:*
    - Faster intra-node communication (within machine) compared to cluster communication
  - *Clusters:*
    - Network communication is unavoidable since no single machine can handle modern workloads alone
  - *Comparison Results:*
    - Cluster of low-end servers perform close to cluster of high-end servers
    - Network communication acts as a speed bottleneck 
    - Parallelization hides latency 
  
  #highlight("Operational Costs:")

  - *Electricity Dominates Operational Costs:*
    - Energy efficiency is therefore a key issue in warehouse-scale computing
    - Non-linearity between load and power draw
      - Example: A server at 10% utilization may use more than half the power of a server at 100% utilization
]

#proposition(title: "Assume Failures are Common")[
  At warehouse scale, hardware failures are the norm, so distributed computing systems like MapReduce must be designed from the ground up to tolerate, recover from, and adapt to frequent failures automatically.

  #highlight("Requirements for Fault-Tolerant Services")

  - Failures should not cause inconsistencies or indeterminate results
  - Other cluster nodes should seamlessly take over workloads from failed nodes
  - Performance should degrade gradually, not collapse, as failures accumulate
  - Repaired servers should be able to rejoin automatically without manual reconfiguration.

]

#proposition(title: "Move Processing to the Data")[
  Unlike high performance computers (HPC), which separates compute and storage, MapReduce co-locates them to exploit data locality, reducing costly data movement across the network.
]

#proposition(title: "Process Data Sequentially and Avoid Random Access")[
  Because random disk access is extremely slow compared to sequential access, MapReduce organizes workloads into sequential streaming operations, leveraging cluster-wide disk bandwidth and optimizing for throughput over latency.
]

#proposition(title: "Hide System-Level Details from the Application Developer")[
  Distributed programming is notoriously complex due to concurrency issues, but MapReduce simplifies it by abstracting away system-level details, letting developers concentrate on high-level computation logic.
]

#proposition(title: "Seamless Scalability")[
  While perfect scalability is impossible due to communication costs, MapReduce brings algorithms much closer to the ideal by abstracting away execution details, enabling near-linear scaling across large clusters.
]





