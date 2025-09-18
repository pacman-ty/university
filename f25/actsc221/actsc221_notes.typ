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
  title: [ACTSC 221 Course Notes: \ Introductory Financial Mathematics],
  name: [Talha Yildirim],
  email: [ tyildir [ at ] uwaterloo [ dot ] ca ] ,
  body
)

#set page(header: [
  _ACTSC 221 Course Notes_
  #h(1fr)
  Talha Yildirim $<$$3$ 
])

#set page(numbering: "1 of 1")


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

  $ E A R = P V (1 + i^m / m )^n - 1 = i^1  $ 
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

The date we select to compute the values is often called the *focal point*, or *focal date*.

#definition(title: "Equivalent Values")[
  If we move two values into the same *focal point* or *focal date* they are equivalent values when:

  We say that $2$ different values $X$ and $Y$, where $Y$ is received $n$ periods later under a period interest of $i$ are *_equivalent_* if 

  $ Y = X(1 + i)^n space "or equivalently" space X = Y(1 + i)^(-1) $
]

#linebreak()

#problem[
  A person owes $\$100$ dollars in one year and an additional $\$500$ dollars is due in 5 years. What single payment $(a)$ now, $(b)$ in three years, will satisfy these obligations. Assume $i^1 = 10%$.
]

#solution[
  We are being asked to find an amount either $(a)$ today, or $(b)$ in three years which is equivalent to the obligation we must pay.

  Drawing a timeline, we let $X$ be the equivalent amount today that satisfies the obligations, and $Y$ be the equivalent amount in $3$ years that satisfies the obligations.

  #figure(
    image("images/figure_1.5.10.png", width: 70%),
  ) <figrue_1_5_10>

  So, 

  $ X = (\$100) / (1 + 10%)^1 + (\$500) / (1 + 10%)^5 = \$401.37 $

  Since we know the time value at time zero, it is easy to fin $Y$, the equivalent value at time $3$.

  $ Y = X(1 + 10%)^3 = \$534.22 $

  Alternatively, we can caompute the value $Y$ directly by looking at the time line We carry the $\$100$ forward $2$ periods, and the $\$500$ back $2$ periods, yielding 

  $ Y = \$100(1 + 10%)^2 + (\$500) / (1 + 10%)^2 = \$534.22 $

]

#linebreak()

== Unknown Rate and Time

#linebreak()

Recall our fundamental formula 

$ F V = P V (1 + i^m / m)^n $

#problem[
  Find the rate $i^2$ such that $\$100$ dollars will grow to $\$1000$ dollars in $10$ years 
]

#solution[
  We need to solve,

  $ 1000 = 100(1 + i^2 / 2)^20 $

  Dividing by $100$ and taking roots gives 

  $ (1 + i^2 / 2) = (1000 / 100)^(1/20) = 1.122018 $

  Solving for $i^2$ gives $i^2 approx.eq 24.4%$
]

#linebreak()

#problem[
  How long will it take for $\$100$ to grow to $\$1000$ if $i^4 = 10%$ 
]

#solution[
  In this example, we need to solve for the number of periods, $n$, in the equation,

  $ 1000 = 100(1 + (10%) / 4 )^n $

  Dividing by $100$ and taking logs, gives

  $ n times ln ( 1 + (10%) / 4) = ln (1000 / 100) $

  Thus $n = 93.249958$ *periods*. Note this is periods, not years. Since we are solving for an interest rate that compounds quarterly (or $4$ times per year) we need to divide the number of periods by $4$ in order to determine the number of years.

  Therefore, the answer in years is $T = n/4 = 23.3124896$ years 
]

#linebreak()

== Doubling Time

$ n = (ln 2) / (ln(1 + i)) $ 

So, it takes $(ln 2) / (ln(1 + i))$ periods for money to double when invested at a period rate of $i$.

#linebreak()

== Inflation 

#linebreak()

#definition(title: "Real Rate of Return")[
  The *Real Rate of Return* is defined to be the growth in purchasing power available after we consider the effects of inflation. This is distinct from the *nominal rate of interest*, which is the interest rate that does not adjust for inflation. When people speak of interest rates on a day-to-day basis, they are really talking about nominal rates.

  $ (1 + i)  / (1 + r) $
]

#definition(title: "Real Rate of Interest")[
  $ i_("real") = (1 - r) / (1 + r) $

  or 

  $ i_("real") = (i - r) / (1 + r) $
]

#linebreak()

#problem[
  Joe invests at $8%$ interest; however, Joe expects inflation to be $4%$. What is his real rate of return?
]

#solution[
  Calculate 

  $ i_("real") = (8% - 4%) / (1 + 4%) = 3.85% $

  So, Joe is able to purchase $3.85%$ more goods at the end of the year than at the start of the year.
]

#linebreak()

== Taxes 

#linebreak()

Taxation is applied to to the nominal rate then inflation punishes it

Taxes are paid usually at a fixed rate of the interest earned.

#definition(title: "After Tax Interest Rate")[
  $ i_("after tax") = i(1 - T) $
]

Where $i$ is the nominal interest rate and $T$ is the tax rate.

#linebreak()

== Taxes and Inflation 

#linebreak()

We can now combine both the effects of taxes and inflation to calculate a *real after tax interest rate* which is given by,

#definition(title: "Real After Tax Interest Rate")[
  $ i_("real after tax") = (i(1 - T) - r) / (1 +)
]
= Rates of Discount 

#linebreak()

#figure(
  image("images/figure_1.8.11.png"),
)

When interest is paid at the start of the loan we call it a *rate of discount* and it is denoted by the letter $d$.

So if the loan principal is $P$, the amount you will receive today is then

$ "Amount Recieved" = "Principal" - "Interest" = P - P times d = P (1 - d) $

#linebreak()

#problem[
  Suppose a $1$ year discount loan with principal value of $\$100$ is made at a rate of discount of $5%$. How much money will be advanced on the loan today?
]

#solution[
  The interest amout is $5% times \$1000 = \$50$. This amount will be charged today, so you will recieve today the remainder, whcih is $\$1000 - \$50 = \$950$.

  Alternatively, we can computer the amount directly by the formula,

  $ "Amount" = \$1000 times (1 - 5%) = \$950 $
]

#linebreak()

The *effective rate of discount over period* $n$, denoted $d_n$, is the ratio of the cost of the loan (or the amount of interest) to the amount at the end of the year. Thus,

#definition[
  $ d_n = (A(n) - A(n -1)) / (A(n)) $
]

Recall the effective rate of interest is given by,

#definition[
  $ i_n = (A(n) - A(n -1)) / A(n) $
]


