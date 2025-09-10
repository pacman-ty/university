#import "@preview/theorion:0.4.0": *
// #import cosmos.fancy: *
// #import cosmos.rainbow: *
 #import cosmos.clouds: *
#show: show-theorion

#set page(height: auto)
#set page("a4") // Sets the page size to A4
#set heading(numbering: "1.1")
#set text(lang: "en")

= Introduction to Interest

== Working with Interest

#linebreak()

#figure(
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

#linebreak()

== Nominal Rates of Interest

#linebreak()

#definition(title: "Equivalent Rates")[

  Two rate are called #strong[equivalent] if a given amount of principal invested for the same length of time at either rate produces the same accumulated values. 
]


