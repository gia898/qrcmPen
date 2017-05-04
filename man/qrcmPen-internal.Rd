\name{internals}
\alias{internals}
\title{Internal Functions}
\description{
Functions for internal use only, or not yet documented.
}
\usage{
piqr.internal(mf, cl, formula.p, tol=1e-6, maxit=100, s,
              segno=1, lambda=0, check=FALSE, A, st.theta=FALSE, theta0)
check.in.2(mf, formula.p, s)
check.out.2(theta, S, covar)
piqr.newton(theta, y,z,d,X,Xw, bfun, s, type, tol=1e-6, maxit=100, safeit, eps0,
            segno=1, lambda=0)
piqr.ee(theta, y, z, d, X, Xw, bfun, p.star.y, p.star.z, J=TRUE, G,
        i=FALSE, segno=1, lambda=0)
pciqr.ee(theta, y, z, d, X, Xw, bfun, p.star.y, p.star.z, J = TRUE, G,
         i = FALSE, segno=1, lambda=0)
pctiqr.ee(theta, y, z, d, X, Xw, bfun, p.star.y, p.star.z, J = TRUE, G,
          i = FALSE, segno=1, lambda=0)
plotCoef(beta, norm, lambda, df, dev, grad, label=FALSE,
          xvar=c("norm", "lambda", "objective", "grad"),
          xlab=iname, ylab="Coefficients", \ldots)
nonzeroCoef(beta, bystep=FALSE)
cov.theta.2(theta, y,z,d,X,Xw, weights, bfun,
            p.star.y, p.star.z, type, s, segno=1, lambda=0, J)
plot.piqr2(x, lambda, conf.int=TRUE, polygon=TRUE, which=NULL, ask=TRUE, ...)

\method{print}{piqr}(x, digits=max(3L, getOption("digits") - 3L), \ldots)
\method{print}{summary.piqr}(x, digits = max(3L, getOption("digits") - 3L), \ldots)
}
\keyword{internal}

