\name{qrcmPen-package}
\alias{qrcmPen-package}
\docType{package}
\title{
Penalized Quantile Regression Coefficients Modeling
}
\description{
This package implements a penalized Frumento and Bottai's (2015) method for quantile regression
coefficient modeling (qrcm), in which quantile regression coefficients are described
by (flexible) parametric functions of the order of the quantile.
This package fits lasso qrcm using coordinate descent.
}
\details{
\tabular{ll}{
Package: \tab qrcmPen\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2016-10-05\cr
License: \tab GPL-2\cr
}
The function \code{\link{piqr}} permits specifying the lasso regression model. The function \code{\link{gof.piqr}} permits to select the best tuning parameter through AIC, BIC, GIC and GCV criteria.
The auxiliary functions \code{\link{summary.piqr}}, \code{\link{predict.piqr}}, and \code{\link{plot.piqr}}
can be used to extract information from the fitted model.
}
\author{
Gianluca Sottile

Maintainer: Gianluca Sottile <gianluca.sottile@unipa.it>
}
\references{
Frumento, P., and Bottai, M. (2015). \emph{Parametric modeling of quantile regression coefficient functions}.
Biometrics, doi: 10.1111/biom.12410.

Friedman, J., Hastie, T. and Tibshirani, R. (2008). \emph{Regularization Paths for Generalized Linear Models via Coordinate Descent}. Journal of Statistical Software, Vol. 33(1), 1-22 Feb 2010.}
\keyword{ package }
\examples{

# use simulated data

n <- 1000
x <- rexp(n)
y <- runif(n, 0, 1 + x)
model <- piqr(y ~ x, formula.p = ~ p + I(p^2))
}



