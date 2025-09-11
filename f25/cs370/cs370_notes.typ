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

#pagebreak()

= Floating Point Number System

#linebreak()

Recall *Real Number $RR$*:

- For any number $x_1$, there exists another $x_2$, where $|x_1| < |x_2|$
- Infinite in _Extent_: There exists $x$ such that $|x|$ is arbitrarily large
- Infinite in _Density_: Any interval $a =< x =< b$ contains infinitely many numbers

#linebreak()

#problem[
  Computers cannot represent infinite/arbitrarily large quantities
]

#solution[
  The standard (partial) solution is to use floating point numbers to approximate the reals
]

#linebreak()

We can have information cancelling if terms in our approximation are oscillating from positive to negative.

#definition(title: "Normalized Form")[
  After expressing the real number in the desired base $beta$, we multiply by a power of $beta$ to shift it into a *normalized form*:

  $ 0. d_1 d_2 d_3 space dots times beta^p $

  where:
  - $d_i$ are digits in base $beta$, i.e. $0 =, d_i < beta$ 
  - _normalized_ implies we shift to ensure $d_1 != 0$ 
  - exponent $p$ is an integer

  Density (or precision) is bounded by limiting the number of digits, $t$
  Extent (or range) is bounded by limiting the range of values for exponent $p$

  Our non zero floating point representation then has the finite form:

    $ plus.minus 0. d_1 d_2 space dots space d_t times beta^p  $
    for $ L <= p <= U space "and" space d_1 != 0 $
    $ 0 space "as a special case" $ 

  The four integer parameters ${beta, t, L, U}$ characterize a specific floating point system, $F$ where $beta = "base", space t = "mantissa"$, and $L$ and $U$ are the lower and upper bounds for the exponent.

  - If the exponent is too big $(>U)$ or too small $(<L)$, our system cannot represent the number
  - When arithemetic operation generate such a number this is called *overflow* (too big) or *underflow* (too small) respectively.
  - For underflow, answer simply rounds to $0$ instead
  - For overflow, will typically produce a $plus.minus infinity$ (or NaN - not a number)  
]

#definition(title: "Fixed Point Numbers")[
  The number of digits after the decimal (radix) point is fixed.
]

#linebreak()

Unlike fixed point numbers, floating point numbers are not evenly spaced.

Floating point systems offer different rounding modes when converting a real number into a representable $F P$ number:

1. *Round to Nearest -* Rounds to closest available number in $F$. 
  - Usually the default
  - Well break ties by simply rounding $1 /2$ up 

2. *Truncation / Chopping -* Rounds to next number in $F$ towards zero
  - i.e. simply discard any digits after the $t$-th digit


#linebreak()

Our algorithms will compute approximate solutions to problems 

$ x_("exact") = "true solution" $
$x_("approx") = "approximate solution" $ 

The difference between these two gives the error of an algorithm.

#definition(title: "Absolute Error")[
  $ E_("abs") = | x_("exact") - x_("approx") | $ 
]

#definition(title: "Relative Error")[
  $ E_("rel") = ( | x_("exact") - x_("approx") | ) / (| x_("exact") |) $ 

  Relative error is often more useful. It : 

  - is independent of the magnitudes of the numbers involved 
  - relates to the number of significant digits in the result

  A result is correct to _roughly_ $s$ digits if $E_("rel") approx 10^(-s)$ or 

  $ 0.5 times 10^(-s) =< E_("rel") =< 5 times 10^(-s) $
]

#definition(title: "Machine Epsilon")[
  The maximum relative error, $E$, for a $F P$ system is called _machine epsilon_ or _unit round off error_ 

  It is defined as the smallest value such that $f l (1 + E) > 1$ under the given floating point system 

  We have the rule $f l (x) = x(1 + delta)$ for some $| delta | =< E$ 

  For and $F P$ system $(beta, t, L, U)$ with $dots$

  - *Rounding to nearest:* $E = 1 / 2 beta^(1 - t)$
  - *Truncation:* $E = beta^(1 - t)$
]

#linebreak()

= Floating Point Number Systems, Error Analysis and Stability

== Arithmetic with Floating Points 

What guarantees are there on a $F P$ arithmetic operation?

#definition(title: "Floating Point Addition")[
  For $w, z in F$, 

  $ w plus.circle z = f l (w + z)(1 + delta) $

  where $plus.circle$ denotes floating addition 

  again, with $| delta | <= E$ 

  i.e. $w plus.circle z = f l (w + z)$
]

#warning-box[
  This rule only applies to individual $F P$ operations! Not a sequence of operations.

  It is #highlight[*not*] generally true that:

  $ (a plus.circle b) plus.circle c = a plus.circle ( b plus.circle c) = f l (a + b +c) $ 
]
