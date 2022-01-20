# Startup files for sagemath
# Place in ~/.sage/
#
# Chris Grossack, 2021

# {{{ imports

# used in automatically solving recurrences
import sympy
import sympy.abc

# used in black magic
from sage.symbolic.expression_conversions import ExpressionTreeWalker

# used in automatically computing asymptotic expansions
from sage.rings.asymptotic.asymptotics_multivariate_generating_functions \
  import FractionWithFactoredDenominatorRing

#}}}

# {{{ repl black magic

# get the ipython instance so we can
# do black magic with our repl
_ipy = get_ipython()

# add a macro so typing aa will automatically run ascii_art 
# on the most recent output. 
# the _oh nonsense is to make this robust in case the _ variable is
# accidentally overwritten
_ipy.define_macro('aa', 'print(ascii_art(_oh[max(_oh.keys())]))')


# recursively apply .n() to constants in a symbolic expression
# while leaving the variables untouched. 
# I feel like there should be a less hacky way to do this...
# Most of this is shamelessly stolen from
# https://ask.sagemath.org/question/46059/
#   is-it-possible-to-round-numbers-in-symbolic-expression/

class SubstituteNumericalApprox(ExpressionTreeWalker):
  def __init__(self, digits=None):
    self.digits = digits

  def pyobject(self,ex,obj):
    if hasattr(obj, 'parent'):
      if obj.parent() == IntegerRing():
        return obj

    if hasattr(obj, 'numerical_approx'):
      return obj.numerical_approx(digits=self.digits)

    # for some reason constants like pi break things... this fixes them
    if hasattr(obj, 'expression'):
      if hasattr(obj.expression(), 'numerical_approx'):
        return obj.expression().numerical_approx(digits=self.digits)

    return obj

  def __call__(self, ex):
    try:
      result = super().__call__(ex)
      return result.numerical_approx(digits=self.digits) if result in CC else result
    except AttributeError:
      return ex.numerical_approx(digits=self.digits)
    

# add a macro so typing nn will automatically convert the most
# recent output to a numeric.
# again, the _oh nonsense is to make this marginally more robust

_ipy.define_macro('nn' , 'SubstituteNumericalApprox( )(_oh[max(_oh.keys())])')
_ipy.define_macro('nn2', 'SubstituteNumericalApprox(2)(_oh[max(_oh.keys())])')
_ipy.define_macro('nn3', 'SubstituteNumericalApprox(3)(_oh[max(_oh.keys())])')
_ipy.define_macro('nn4', 'SubstituteNumericalApprox(4)(_oh[max(_oh.keys())])')
_ipy.define_macro('nn5', 'SubstituteNumericalApprox(5)(_oh[max(_oh.keys())])')

# }}}

# {{{ we want a large stock of variables defined up front

# define variables out of the gate
t,u,v,w,x,y,z = var('t,u,v,w,x,y,z')

# actually, let's have more variables
a,b,c = var('a,b,c')

# what if... more
# by default r is an R interpreter
# but I think I'll be fine without that
p,q,r = var('p,q,r')

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
assume(K, "integer")
assume(K >= 0)
assume(M, "integer")
assume(M >= 0)
assume(N, "integer")
assume(N >= 0)

# careful! psi is already the digamma function...
# I suspect I won't miss that, though
eps, phi, psi, xi, theta, tau = var('ε, φ, ψ, ξ, θ, τ')
assume(eps > 0)
assume(eps < 1)
assume(theta >= 0)
assume(theta < 2*pi)

# define some variables to be functions
T = function('T')(n)
S = function('S')(n)

f = function('f')(x)
g = function('g')(x)
h = function('h')(x)

# }}}

# {{{ lazy aliases

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

# }}}

# {{{ automatically solve recurrences

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

# }}}

# {{{ automatically compute asymptotic expansions

# sage can actually compute asymptotic expansions for us,
# but there's a bunch of overhead that I don't feel like remembering.

# this is an amalgam of two asymptotic methods:

# the examples here, which work on series with multiple variables, at the
# cost of requiring polynomial denominators:

# https://doc.sagemath.org/html/en/reference/
#   asymptotic/sage/rings/asymptotic/
#   asymptotics_multivariate_generating_functions.html

# and the examples here, which only work for single-varaible functions,
# but which is much more flexible with _which_ functions are allowed:

# https://doc.sagemath.org/html/en/reference/asymptotic/sage/rings/
#   asymptotic/asymptotic_ring.html#introductory-examples


def multivar_asy(f, N=5, alpha=None, numeric=0):
  """
  compute the first N terms of the asymptotic expansion of f

  setting numeric = n will give floats with n digits of precision.

  if 

    f = sum_{ns} F_{ns} x^{ns} 

  for ns = (n1,...,nk) a multi-index, then we compute an 
  expansion for F_{r alpha} for alpha = (a1 ... ak) a given
  "direction" and r --> oo

  By default, we assume alpha = [1,...,1], which reduces to what we 
  almost certainly want in the one variable case
  """
  #{{{ 
  fn = f.numerator()
  fd = f.denominator()

  R_internal = PolynomialRing(QQ, fd.variables())

  # FFPD is the ring of quotients p/q
  # where p is in SR and q is in R_internal
  # rather confusingly we put the denominator ring before the numerator ring
  FFPD = FractionWithFactoredDenominatorRing(R_internal, SR)

  # but when we make new element of the ring, we put things in the right order
  # for some reason units in the denominator get clobbered, so we manually
  # add it in the numerator (this is consistent with the examples in the docs)
  fdFactored = R_internal(fd).factor()

  f = FFPD(fn / fdFactored.unit(), fdFactored)

  # now we choose a "direction" alpha
  if alpha == None:
    alpha = [1] * f.dimension()

  decomp = f.asymptotic_decomposition(alpha)

  result = 0
  n = 0
  for part in decomp:
    n += 1
    # this is brittle, but makes things work
    if part == FFPD(0, []):
      continue

    # p is supposed to be a minimal critical point for the denominator of part.
    # let's first find the critical points

    # We start with the smooth case, because why not.
    # I don't _really_ understand what the articles mean by 
    # the asymptotics being dominated by smooth vs singular points...

    I = part.smooth_critical_ideal(alpha)
    s = solve([SR(v) for v in I.gens()], 
              [SR(v) for v in R_internal.gens()], 
              solution_dict=True)

    # ok, if the smooth case gave us no points, 
    # then let's try the singular case. 
    if len(s) == 0:
      print("no smooth points")

      I = part.singular_ideal()
      s = solve([SR(v) for v in I.gens()], 
                [SR(v) for v in R_internal.gens()], 
                solution_dict=True)

    # if there's still no solutions, give up
    if len(s) == 0:
      print("no singular points either")
      return None

    # if we did find points, now we need to find the _minimal_ one
    pMin = s[0]
    for p in s:
      if sum([xi^2 for xi in p.values()]) < sum([yi^2 for yi in pMin.values()]):
        pMin = p

    (a,_,_) = part.asymptotics(pMin, alpha, N, numerical=numeric) 

    result += a

  return result
  #}}}

# allow terms that are (products of)
# - exponential in n with rational base
# - polynomial in n
# - polynomial in log n
# with coefficients in QQbar

AsyRing = AsymptoticRing('QQ^n * n^QQ * log(n)^QQ', QQ)

def singlevar_asy(f, N=5, sings=None):
  """
  compute the first N terms of the asymptotic expansion of f

  sings is a list of dominant singularities
  TODO: get these automatically somehow?
  """
  #{{{
  return AsyRing.coefficients_of_generating_function(f, sings, precision=N)
  #}}}


def asy(f, *args, **kwargs):
  try:
    return multivar_asy(f,*args,**kwargs)
  except:
    # if this blows up in your face, remember that it
    # needs a _callable_ function to work! 
    # so you should make a function using def
    # rather than the usual way of the symbolic ring
    return singlevar_asy(f,*args,**kwargs)

# }}}
