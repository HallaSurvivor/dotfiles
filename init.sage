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
_ipy.define_macro('aa', 'print(ascii_art(_))')


# define variables out of the gate
t,u,v,w,x,y,z = var('t,u,v,w,x,y,z')

# actually, let's have more variables
a,b,c = var('a,b,c')

#discrete vars
# we can use n because of the nn macro earlier
k,m,n = var('k,m,n')
assume(k, "integer")
assume(k >= 0)
assume(m, "integer")
assume(m >= 0)
assume(n, "integer")
assume(n >= 0)

# and upper bounds as well
K,M,N = var('K,M,N')
assume(k, "integer")
assume(k >= 0)
assume(m, "integer")
assume(m >= 0)
assume(n, "integer")
assume(n >= 0)

# careful! psi is already the digamma function...
# I suspect I won't miss that, though
eps, phi, psi, xi = var('eps, phi, psi, xi')
assume(eps > 0)
assume(eps < 1)

# define some variables to be functions
T = function('T')(n)
S = function('S')(n)

f = function('f')(x)
g = function('g')(x)
h = function('h')(x)

# I always try to do this... let's just add it
def series(f,order=None,var=None):
    """
    Return the series expansion of f
    """
    if var == None:
        var = f.variables()[0]
    if order == None:
        order = 5

    # taylor is analytic, and works in some cases where
    # series doesn't, but series returns an object ordered
    # from low to high degrees. We want the best of both.
    try:
        return f.series(var, order)
    except ValueError as e:
        return f.taylor(var,0,order).series(var,order)

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

    if res == None:
        print("sympy failed to solve this recurrence")
        return res
    else:
        return res._sage_()

# I really am this lazy (also I forget, 
# because some programs use binom and 
# some use binomial... let's not even 
# allow the mistake)
binom = binomial

# we don't use this often, but every time we do
# I think to myself 
# "gee. I sure do wish that was built in"
def lg(x): 
    return log(x,2)
