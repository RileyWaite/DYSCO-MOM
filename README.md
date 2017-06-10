# DYSCO-MOM
Dynamically Scoping Multivariable Optimisation in Matlab

The name of this repo was not planned, and may very well be my greatest achievement.

## What DYSCO is
Dynamic scoping is an algorithmic method for multivariable optimization that I came up with for a class project (which is what the included example is). I'm 100% certain that this is in no way groundbreaking, and for numerical methodoligists it's got to be boring, but it works like this:

DYSCO uses a convergent solution approach. Several user-defined parameters are considered to formalize some important values for DYSCO. These values are Recursion Layer Count, Delta Divisor count for initial optimization sweeps, Delta Fraction for scope reduction, and Sweep Re-focus reduction width.

Then, given a set of initial ranges for the soon-to-be-optimized variables, the algorithm will apply this basic operation:
1. Apply general sweep over every range at increments defined by Delta divisor, creating a performance lattice for the variables
2. Re-scope about the maxima for these variables, redifining the range and deltas for next sweep
3. Repeat this process for A) as many times as defined by the Recursion layer count, or B) when the optimized solution converges within user-defined tolerance.

## Included Example
Included is an example of a project that uses the DYSCO-MOM algorithm to optimize the initial launch vector, speed, and yaw rate of a soccer ball given a wind speed and target. There's a few physical assumptions made in the model (such as that the magnus effect only affects the ball in the XY plane, and that surface friction does not slow the spin rate of the ball). 

Our grade on this project was based on our trajectory's performance compared against the "optimal" trajectory. However, my trajectory turned out to be "more optimal," both in its speed and its accuracy, landing me a grade of over 100%. My trajectory is now the basis for project grades in all students taking ME123. DYSCO-MOM quite literally "threw the curve"! (I'm hilarious).

## Disclaimer
I'll note, begrudgingly, that although the header for this project has both mine and Andrew's name, Andrew ne'er layed even a glance in the general direction of this code. That's right, I wrote the whole thing alone. Shame on you, Andrew. I hope you see this one day and feel bad. 
