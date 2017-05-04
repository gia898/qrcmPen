\name{piqr}
\alias{piqr}
\title{
Penalized Quantile Regression Coefficients Modeling
}
\description{
This package implements a penalized Frumento and Bottai's (2015) method for quantile regression
coefficient modeling (qrcm), in which quantile regression coefficients are described
by (flexible) parametric functions of the order of the quantile.
This package fits lasso qrcm using coordinate descent.
}
\usage{
piqr(formula, formula.p = ~ slp(p, 1), weights, data, s, nl=70,
     display=TRUE, tol=1e-6, maxit=100)
}
\arguments{
  \item{formula}{
    a two-sided formula of the form \code{y ~ x1 + x2 + \ldots}:
    a symbolic description of the quantile regression model.
  }
  \item{formula.p}{
    a one-sided formula of the form \code{~ b1(p, \ldots) + b2(p, \ldots) + \ldots}, describing how
    quantile regression coefficients depend on \kbd{p}, the order of the quantile.
  }
  \item{weights}{
    an optional vector of weights to be used in the fitting process.
  }
  \item{data}{
    an optional data frame, list or environment containing the variables in \code{formula}.
  }
  \item{s}{
    an optional 0/1 matrix that permits excluding some model coefficients
    (see \sQuote{Examples}).
  }
  \item{nl}{
    the number of lambda values - default is 70.
  }
  \item{display}{
    if TRUE something is printed - default is TRUE.
  }
  \item{tol}{
    convergence criterion for numerical optimization - default is 1e-6.
  }
  \item{maxit}{
    maximum number of iterations - default is 100.
  }
}
\details{
  Quantile regression permits modeling conditional quantiles of a response variabile,
  given a set of covariates. A linear model is used to describe the conditional
  quantile function:
  \deqn{Q(p | x) = \beta_0(p) + \beta_1(p)x_1 + \beta_2(p)x_2 + \ldots.}{%
  Q(p | x) = \beta0(p) + \beta1(p)*x1 + \beta2(p)*x2 + \ldots.}
  The model coefficients \eqn{\beta(p)} describe the effect of covariates on the \eqn{p}-th
  quantile of the response variable. Usually, one or more
  quantiles  are estimated, corresponding to different values of \eqn{p}.

  Assume that each coefficient can be expressed as a parametric function of \eqn{p} of the form:
  \deqn{\beta(p | \theta) = \theta_{0} + \theta_1 b_1(p) + \theta_2 b_2(p) + \ldots}{%
  \beta(p | \theta) = \theta0 + \theta1*b1(p) + \theta2*b2(p) + \ldots}
  where \eqn{b_1(p), b_2(p, \ldots)}{b1(p), b2(p), \ldots} are known functions of \eqn{p}.
  If \eqn{q} is the dimension of
  \eqn{x = (1, x_1, x_2, \ldots)}{x = (1, x1, x2, \ldots)}
  and \eqn{k} is that of
  \eqn{b(p) = (1, b_1(p), b_2(p), \ldots)}{b(p) = (1, b1(p), b2(p), \ldots)},
  the entire conditional quantile function is described by a
  \eqn{q \times k}{q*k} matrix \eqn{\theta} of model parameters.

  Users are required to specify two formulas: \code{formula} describes the regression model,
  while \code{formula.p} identifies the 'basis' \eqn{b(p)}.
  By default, \code{formula.p = ~ slp(p, k = 3)}, a 3rd-degree shifted
  Legendre polynomial (see \code{\link{slp}}). Any user-defined function \eqn{b(p, \ldots)}
  can be used, see \sQuote{Examples}.

  Estimation of penalized \eqn{\theta} is carried out by minimizing a penalized integrated loss function,
  corresponding to the integral, over \eqn{p}, of the penalized loss function of standard quantile regression. This
  motivates the acronym \code{piqr} (penalized integrated quantile regression).

  See details in \code{\link{iqr}}
}
\value{
An object of class \dQuote{\code{piqr}}, a list containing the following items:
\item{call}{the matched call.}
\item{lambda}{The actual sequence of lambda values used.}
\item{coefficients}{a list of estimated model parameters describing the fitted quantile function along the path.}
\item{minimum}{the value of the minimized integrated loss function for each value of lambda.}
\item{dl}{a matrix of gradient values along the path.}
\item{df}{The number of nonzero coefficients for each value of lambda.}
\item{seqS}{a list containg each matrix s for each value of lambda.}
\item{internal}{a list containing some initial object.}
}
\references{
Frumento, P., and Bottai, M. (2015). \emph{Parametric modeling of quantile regression coefficient functions}.
Biometrics, doi: 10.1111/biom.12410.
}
\author{
Gianluca Sottile \email{gianluca.sottile@unipa.it}
}
\note{

  By expressing quantile regression coefficients as functions of \eqn{p}, a parametric model for the conditional
  quantile function is specified. The induced \acronym{PDF} and \acronym{CDF} can be used as diagnostic tools.
  Negative values of \code{PDF} indicate quantile crossing, i.e., the conditional quantile function is not
  monotonically increasing. Null values of \code{PDF} indicate observations that lie outside the
  estimated support of the data, defined by quantiles of order 0 and 1. If null or negative \code{PDF}
  values occur for a relatively large proportion of data, the model is probably misspecified or ill-defined.
  If the model is correct, the fitted \code{CDF} should approximately follow a Uniform(0,1) distribution.
  This idea is used to implement a goodness-of-fit test, see \code{\link{summary.iqr}}
  and \code{\link{test.fit}}.

  The intercept can be excluded from \code{formula}, e.g.,
  \code{iqr(y ~ -1 + x)}. This, however, implies that when \code{x = 0},
  \code{y} is always {0}. See example 5 in \sQuote{Examples}.
  The intercept can also be removed from \code{formula.p}.
  This is recommended if the data are bounded. For example, for strictly positive data,
  use \code{iqr(y ~ 1, formula.p = -1 + slp(p,3))} to force the smallest quantile
  to be zero. See example 6 in \sQuote{Examples}.


}
\seealso{
\code{\link{summary.piqr}}, \code{\link{plot.piqr}}, \code{\link{predict.piqr}},
for summary, plotting, and prediction.
\code{\link{gof.piqr}} to select the best value of the tuning parameter though AIC, BIC, GIC, GCV criteria.
}
\examples{

  ##### Using simulated data in all examples


  ##### Example 1

  n <- 1000
  x <- runif(n)
  y <- rnorm(n, 1 + x, 1 + x)
  # true quantile function: Q(p | x) = beta0(p) + beta1(p)*x, with
    # beta0(p) = beta1(p) = 1 + qnorm(p)

  # fit the true model: b(p) = (1 , qnorm(p))
  m1 <- piqr(y ~ x, formula.p = ~ I(qnorm(p)))
  best1 <- gof.piqr(m1, method="AIC", plot=FALSE)
  # the fitted quantile regression coefficient functions are
    # beta0(p) = m1$coef[1,1] + m1$coef[1,2]*qnorm(p)
    # beta1(p) = m1$coef[2,1] + m1$coef[2,2]*qnorm(p)

  # a basis b(p) = (1, p), i.e., beta(p) is assumed to be a linear function of p
  m2 <- piqr(y ~ x, formula.p = ~ p)
  best2 <- gof.piqr(m2, method="AIC", plot=FALSE)

  # a 'rich' basis b(p) = (1, p, p^2, log(p), log(1 - p))
  m3 <- piqr(y ~ x, formula.p = ~ p + I(p^2) + I(log(p)) + I(log(1 - p)))
  best3 <- gof.piqr(m3, method="AIC", plot=FALSE)

  # 'slp' creates an orthogonal spline basis using shifted Legendre polynomials
  m4 <- piqr(y ~ x, formula.p = ~ slp(p, k = 3)) # note that this is the default
  best4 <- gof.piqr(m4, method="AIC", plot=FALSE)

  # 'plf' creates the basis of a piecewise linear function
  m5 <- piqr(y ~ x, formula.p = ~ plf(p, knots = c(0.1,0.9)))
  best5 <- gof.piqr(m5, method="AIC", plot=FALSE)


  summary(m4, best4$minLambda)
  par(mfrow = c(2,2))
  plot(m4, xvar="norm")
  plot(m4, xvar="lambda")
  plot(m4, xvar="objective")
  plot(m4, xvar="grad")
  # see the documentation for 'summary.piqr', and 'plot.piqr'

}
\keyword{models}
\keyword{regression}
