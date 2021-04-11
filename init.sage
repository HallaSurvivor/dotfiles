# Startup files for sagemath
# Place in ~/.sage/
#
# Chris Grossack, 2021

import sympy
import sympy.abc

# get the ipython instance so we can
# do black magic with our repl
_ipy = get_ipython()


# add a macro so typing nn will
# automatically convert the most
# recent output to a numeric.
_ipy.define_macro('nn', '_.n()')

# add a macro so typing aa will
# automatically run ascii_art 
# on the most recent output. 
_ipy.define_macro('aa', 'ascii_art(_)')


# define variables out of the gate
t,u,v,w,x,y,z = var('t,u,v,w,x,y,z')

#discrete vars
# we can use n because of the nn macro earlier
k,m,n = var('k,m,n')

# careful! psi is already the digamma function...
# I suspect I won't miss that, though
eps, phi, psi = var('eps, phi, psi')

# define some variables to be functions
T = function('T')(n)
S = function('S')(n)


# sympy will solve recurrences for us,
# but it's kind of a hassle to convert
# back and forth between sympy and sage
# symbolic elements. Let's automate it.
def rsolve(eqn, var=None, basecase=None):
    """
    Solve a recurrence relation.

    e.g.

    > eqn = T(n+2) - T(n+1) - T(n) - 2^n
    > rsolve(eqn)
    > rsolve(eqn,basecase=[0,1])

    @var is the variable to recur on (defaults to n)
    @basecase is a list of initial conditions
    """
    sT = sympy.Function('T')

    if var == None:
        v = sympy.abc.n
    else:
        v = var._sympy_()

    res = sympy.rsolve(eqn._sympy_(), sT(v), basecase)

    return res._sage_()
