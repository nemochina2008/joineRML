% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootSE.R
\name{bootSE}
\alias{bootSE}
\title{Standard errors via bootstrap for an \code{mjoint} object}
\usage{
bootSE(object, nboot = 100, ci = 0.95, use.mle = TRUE, verbose = FALSE,
  control = list(), progress = TRUE, ncores = 1, safe.boot = FALSE, ...)
}
\arguments{
\item{object}{an object inheriting from class \code{mjoint} for a joint model
of time-to-event and multivariate longitudinal data.}

\item{nboot}{the number of bootstrap samples. Default is \code{nboot=100}.}

\item{ci}{the confidence interval to be estimated using the
percentile-method. Default is \code{ci=0.95} for a 95\% confidence
interval.}

\item{use.mle}{logical: should the algorithm use the maximizer from the
converged model in \code{object} as initial values for coefficients in each
bootstrap iteration. Default is \code{use.mle=TRUE}.}

\item{verbose}{logical: if \code{TRUE}, the parameter estimates and other
convergence statistics are value are printed at each iteration of the MCEM
algorithm. Default is \code{FALSE}.}

\item{control}{a list of control values with components: \describe{

  \item{\code{nMC}}{integer: the initial number of Monte Carlo samples to be
  used for integration in the burn-in phase of the MCEM. Default is
  \code{nMC=}100\emph{K}.}

  \item{\code{nMCscale}}{integer: the scale factor for the increase in Monte
  Carlo size when Monte Carlo has not reduced from the previous iteration.
  Default is \code{nMCscale=5}.}

  \item{\code{nMCmax}}{integer: the maximum number of Monte Carlo samples
  that the algorithm is allowed to reach. Default is \code{nMCmax=20000}.}

  \item{\code{burnin}}{integer: the number of iterations for 'burn-in' phase
  of the optimization algorithm. It is computationally inefficient to use a
  large number of Monte Carlo samples early on until one is approximately
  near the maximum likelihood estimate. Default is \code{burnin=}100\emph{K}
  for \code{type='antithetic'} or \code{type='montecarlo'} and
  \code{burnin=}5 for \code{type='sobol'} or \code{type='halton'}. For
  standard methods, such a large burn-in will generally be unnecessary and
  can be reduced on an application-specific basis.}

  \item{\code{mcmaxIter}}{integer: the maximum number of MCEM algorithm
  iterations allowed. Default is \code{mcmaxIter=burnin+200}.}

  \item{\code{convCrit}}{character string: the convergence criterion to be
  used. See \strong{Details}.}

  \item{\code{gammaOpt}}{character string: by default (\code{gammaOpt='NR'}),
  \eqn{\gamma} is updated using a one-step Newton-Raphson iteration, with the
  Hessian matrix calculated exactly. If \code{gammaOpt='GN'}, a Gauss-Newton
  algorithm-type iteration is implemented, where the Hessian matrix is
  approximated based on calculations similar to those used for calculating
  the empirical information matrix? If it is used, then the step-length is
  adjusted by a nominal scaling parameter of 0.5 in order to reduce the
  chance of over-shooting the maximizer.}

  \item{\code{tol0}}{numeric: tolerance value for convergence in the
  parameters; see \strong{Details}. Default is \code{tol0=1e-03}.}

  \item{\code{tol1}}{numeric: tolerance value for convergence in the
  parameters; see \strong{Details}. Default is \code{tol1=1e-03}.}

  \item{\code{tol2}}{numeric: tolerance value for convergence in the
  parameters; see \strong{Details}. Default is \code{tol2=5e-03} for
  \code{type='antithetic'} or \code{type='montecarlo'} and \code{tol2=1e-03}
  for \code{type='sobol'} or \code{type='halton'}.}

  \item{\code{tol.em}}{numeric: tolerance value for convergence in the
  multivariate linear mixed model (MV-LMM). When \eqn{K > 1}, the optimal
  initial parameters are those from the MV-LMM, which is estimated using a
  separate EM algorithm. Since both the E- and M-steps are available in
  closed-form, this algorithm convergences relatively rapidly with a high
  precision. Default is min(\code{1e-04}, \code{tol2}).}

  \item{\code{rav}}{numeric: threshold when using \code{convCrit='sas'} that
  applies absolute change (when \eqn{<}\code{rav}) or relative change (when
  \eqn{\ge}\code{rav}) criterion; see \strong{Details}. Default is
  \code{0.1}, which is an order of magnitude higher than the SAS
  implementation.}

  \item{\code{type}}{character: type of Monte Carlo integration method to
  use. Options are \describe{

  \item{\code{type='montecarlo'}}{Vanilla Monte Carlo sampling.}

  \item{\code{type='antithetic'}}{Variance reduction method using antithetic
  simulation. This is the default option.}

  \item{\code{type='sobol'}}{Quasi-Monte Carlo with a low
  deterministic Sobol sequence with Owen-type scrambling.}

  \item{\code{type='halton'}}{Quasi-Monte Carlo with a low deterministic
  Halton sequence.}

  }}

  }}

\item{progress}{logical: should a progress bar be shown on the console to
indicate the percentage of bootstrap iterations completed? Default is
\code{progress=TRUE}.}

\item{ncores}{integer: if more than one core is available, then the \code{bootSE}
function can run in parallel via the \code{\link[foreach]{foreach}}
function. By default, \code{ncores=1}, which defaults to serial mode. Note
that if \code{ncores}>1, then \code{progress} is set to \code{FALSE} by
default, as it is not possible to display progress bars for parallel
processes at the current time.}

\item{safe.boot}{logical: should each bootstrap replication be wrapped in a
\code{\link[base]{tryCatch}} statement to catch errors (e.g. during the
optimisation progress)? When model fitting throws errors, a new bootstrap
sample is drawn for the current iteration and the model is re-fit; this
process continuex until a model fits successfully. Default is \code{FALSE}.}

\item{...}{options passed to the \code{control} argument.}
}
\value{
An object of class \code{bootSE}.
}
\description{
This function takes a model fit from an \code{mjoint} object and
  calculates standard errors and confidence intervals for the main
  longitudinal and survival coefficient parameters, including the latent
  association parameters, using bootstrapping (Efron and Tibshirani, 2000).
}
\details{
Standard errors and confidence intervals are obtained by repeated
  fitting of the requisite joint model to bootstrap samples of the original
  longitudinal and time-to-event data. Note that bootstrap is done by
  sampling subjects, not individual records.
}
\note{
This function is computationally intensive. A dynamic progress bar is
  displayed showing the percentage of bootstrap models fitted. On computer
  systems with more than one core available, computational time can be
  reduced by passing the argument \code{ncores} (with integer value >1) to
  \code{bootSE}, which implements parallel processing via the
  \code{\link[foreach]{foreach}} package. \strong{Note:} if parallel
  processing is implemented, then the progress bar is not displayed.

  Due to random sampling, an \code{mjoint} model fitted to some bootstrap
  samples may not converge within the specified control parameter settings.
  The \code{bootSE} code discards any models that failed to converge when
  calculating the standard errors and confidence intervals. If a large
  proportion of models have failed to converge, it is likely that it will
  need to be refitted with changes to the \code{control} arguments.
}
\examples{
\dontrun{
# Fit a joint model with bivariate longitudinal outcomes

data(heart.valve)
hvd <- heart.valve[!is.na(heart.valve$log.grad) & !is.na(heart.valve$log.lvmi), ]

fit <- mjoint(
    formLongFixed = list("grad" = log.grad ~ time + sex + hs,
                         "lvmi" = log.lvmi ~ time + sex),
    formLongRandom = list("grad" = ~ 1 | num,
                          "lvmi" = ~ time | num),
    formSurv = Surv(fuyrs, status) ~ age,
    data = list(hvd, hvd),
    inits = list("gamma" = c(0.11, 1.51, 0.80)),
    timeVar = "time",
    verbose = TRUE)

fit.boot <- bootSE(fit, 50, use.mle = TRUE, control = list(
    burnin = 25, convCrit = "either",
    tol0 = 6e-03, tol2 = 6e-03, mcmaxIter = 60))
}
}
\references{
Efron B, Tibshirani R. \emph{An Introduction to the Bootstrap.} 2000; Boca
Raton, FL: Chapman & Hall/CRC.
}
\seealso{
\code{\link{mjoint}} for approximate standard errors.
}
\author{
Graeme L. Hickey (\email{graeme.hickey@liverpool.ac.uk})
}
\keyword{methods}
\keyword{multivariate}
\keyword{survival}
