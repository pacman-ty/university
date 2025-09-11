#import "@preview/theorion:0.4.0": *
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#set page(height: auto)
#set page("a4") // Sets the page size to A4
#set heading(numbering: "1.1")
#set text(lang: "en")

#set page(header: [
  _ACTSC 221 Course Notes_
  #h(1fr)
  Talha Yildirim $<$$3$ 
])

#set page(numbering: "1 of 1")

#let title-page(title:[], email:[], name:[], fill: yellow, body) = {
  //set page(fill: rgb("#FFD700"), margin: (top: 1.5in, rest: 2in))
  set heading(numbering: "1.1.1")
  line(start: (0%, 0%), end: (8.5in, 0%), stroke: (thickness: 2pt))
  align(horizon + left)[
    #text(size: 24pt, title)\
    #v(1em)
    Fall 2025 -  Brent Matheson  
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
  title: [ACTSC 221 Course Notes],
  name: [Talha Yildirim],
  email: [ tyildir [ at ] uwaterloo [ dot ] ca ] ,
  body
)


= Introduction to Interest

== Working with Interest

#linebreak()

#figure
  image("images/figure_1.png"),
  caption: [Calculating interest],
) <figure_1>

#linebreak() 

#definition(title: "Effective Rate of Interest")[
  The effective rate of interest is the amount of interest earned (or paid) during the period divided by the initial principal amount, assuming the interest is received (or paid) at the end of the period.
] <eri>

#linebreak()

#warning-box[
  Effective rates can be misleading since the time frame isn't considered. 
 ]

#example[
  
  Imagine you and I invest $\$100$ dollars. After $1$ year my money has turned into $\$110$ dollars. After $3$ years your money has also turned into $\$110$ dollars.

  We both have an effective rate of interest of $E I = 10 / 100 = 10%$, yet it is clear the I got a better return on investment since my investment took $1 / 3$ the time to reach the same accumulated value.  
]

#linebreak()

Generalizing this to the $n^(t h)$ period between time $(n - 1)$ and $n$, we have that $i_n$, which is the effective rate of interest earned over the $n^(t h)$ period is given by:

$
i_n = (A(n) - A(n -1)) / A(n-1) = I_n / A(n -1) = "Interest" / "Amount at the Start"
$

#linebreak()

#definition(title: "Simple Interest")[

  Interest that is earned as a linear function of time.

  Or, more precisely, the interest earned after t years is given by the formula

  $ I = P times r times t $

  Where $P$ is the initial principal, $r$ the annual rate of simple interest, and $t$ the time in years.

  If we let $S$ be the accumulated value of $P$, then 

$ S = P + I = P + P times r times t = P times (1 + r times t) $
]

#note-box[
  Time for simple interest is strictly defined in terms of years.
]

#problem[
  A loan $\$10,000$ is taken out at $5%$ simple interest. Find the amount function, as a function of time $t$ where time is expressed in years.
]

#solution[
  $ A(0) = \$10000 "," space t = 0.05 \ $
  $ A(t) = A(0) + A(0) times r times t $
  $ = A(0)(1 + r times t) $
  $ = \$10,000(1 + 5% times t) $
]

#linebreak()

#remark[
  The general formula for the amount function of an initial principal $P$ invested for $t$ time with interest rate $r$ is given by 
  $ A(t) = P(1 + r t) $ 
]

#linebreak()

If time is given in number of days we use a conversion to get annualized interest rate

#definition(title: "Exact Interest")[

  In exact interest we assume a year has 365,
  $ I = P r times "total number of days" / 365 $
]

#definition(title: "Ordinary Interest")[

  In ordinary interest we assume a year has 360,
  $ I = P r times "total number of days" / 360 $
]

#remark[
  Ordinary interest is also known as #strong[Banker's Rule].
]

#linebreak()

== Compound Interest

#linebreak()

Consider an investment of $\$100$ dollars earning $10%$ interest annually. 

#figure(
  image("images/figure_1.2.2.png"),
) <figure_1_2_2>

So, after $1$ year, our investment has grown to $\$100(1 + 10%) = \$110$.

That amount will then be invested for $1$ more year at $10%$. Over the second year, that amount will grow to 

$ \$100(1 + 10%) = \$121 $

If we put all this together we see that 

$ 

  \$121 = \$100(1 + 10%) \ 
  = \$100(1 + 10%)(1 + 10%) \ 
  = \$100(1 + 10%)^2 
$

#note-box[
  With simple interest we would have had an accumulated value of $\$120$ dollars.

  The difference comes from the _interest on the interest_.
]

#linebreak()

Generalizing the above, we have the formula for the amount function for an initial principal invested for $n$ years at compound interest $r$ is given by

#definition(title: "Compound Interest")[
  $ A(t) = P(1 + r)^n $
]


So far we have seen accumulated or future value of the principal. Often we want the initial value or present value, given a final value

This process, where we bring cash flows back in time, is called *_discounting_*  the values.

The idea that $1 + r$ carries values into the future, and dividing by $1 + r$ carries values back to the present can be summarized as follows:

#figure(
  image("images/figure_1.2.3.png"),
) <figure_1_2_3>

#definition(title: "Discounting Interest")[
  $ A(0) = P V  = A(t) / (1 + r)^n $ 
]

#linebreak()

== Nominal Rates of Interest

#linebreak()

So far, our examples of compound interest assume that the interest is received and reinvested at the end of each year.

In many cases, that actual frequency of interest payments may be more often than annually.

#example[
  Many banks pay interest at the end of each month, so the interest received is reinvested monthly
]

We would say the interest on the account *_compounds monthly_*.

#note-box[
  $i^m$ means a nominal or stated annual rate compounded $m$ times per year. 

  So, $i^2 = 10%$ means that the nominal rate is $10%$, compounded twice a year.

]

#example[
    The $\$1$ in my account (student poverty) will grow by $5%$ in the first $6$ months, then the new principal will grow by another $5%$ in the next six months.
]

#figure(
  image("images/figure_1.3.4.png"),
) <figure_1_3_4>

$ A = \$1(1 + (10%) / 2)^2 = \$1.1025 $ 

We can generalize for an initial principal, $P$, we will accumulate a final value, $A$, when invested at $i^m$ for $n$ periods

#definition(title: "Nominal Interest")[
  $ A = P(1 + (i^m) / m)^n $
]

#caution-box[
  The principal is invested for n periods, not years. This makes sense, since each period, the principal is earning only $(i^m) / m$
]

#linebreak()

Given nominal rate we know that $i^2 != i^(12)$. As a result it is not immediately obvious which generate a higher accumulated value, $i^10 = 10%$ or $i^1 = 11%$. 

We need to compare rates on an equivalent basis.

#definition(title: "Equivalent Rates")[

Two rate are called #strong[equivalent] if a given amount of principal invested for the same length of time at either rate produces the same accumulated values. 
]

#corollary[

  If you are going from any $m$ to $n$ where $m > n$ $(i^m #sym.arrow.r i^n)$ we should see the nominal rate in terms of $n$ be greater 
]
#definition(title: "Effective Annual Rate - EAR")[

  Annually compounded rate that is equivalent to the given nominal rate is called the *effective annual rate*

  // $ (1 + i^m / m )^m - 1 = E A R $ 
]

== Varying Rates of Interest

#linebreak()

Varying rates of interest examine interest rates that vary over the life of an investment.

#linebreak()

#problem[
  Suppose $\$200$ dollars is invested in an account that pays $i^1 = 5%$ for the first $2$ years, followed by $i^1 = 8%$ for the next $3$ years. Find the accumulated value.
]

#solution[
  Drawing a timeline of the values helps make this a bit more clear.

  #figure(
    image("images/figure_1.4.5.png"),
  ) <figure_1_4_5>

  Now we can compute $A(2)$ by 

  $ A(2) = \$200(1 + 5%)^2 $

  and we also have 

  $ A(5) = A(2)(1 + 8%)^3 $ 

  Putting these together gives 

  $ A(5) = \$200(1 + 5%)^2(1 + 8%)^3 = \$277.77 $
]

#linebreak()

== Dated Values

#linebreak()

Dated values are similar to equivalent values 

#definition(title: "Equivalent Values")[

  If we move two values into the same *focal point* or *focal date* they are equivalent values
]



