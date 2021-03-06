% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mjoint.R
\name{mjoint}
\alias{mjoint}
\title{Fit a joint model to time-to-event data and multivariate longitudinal data}
\usage{
mjoint(formLongFixed, formLongRandom, formSurv, data, survData = NULL,
  timeVar, inits = NULL, verbose = FALSE, pfs = TRUE, control = list(),
  ...)
}
\arguments{
\item{formLongFixed}{a list of formulae for the fixed effects component of
each longitudinal outcome. The left hand-hand side defines the response,
and the right-hand side specifies the fixed effect terms. If a single
formula is given (either as a list of length 1 or a formula), then it is
assumed that a standard univariate joint model is being fitted.}

\item{formLongRandom}{a list of one-sided formulae specifying the model for
the random effects effects of each longitudinal outcome. The length of the
list must be equal to \code{formLongFixed}.}

\item{formSurv}{a formula specifying the proportional hazards regression
model (not including the latent association structure). See
\code{\link[survival]{coxph}} for examples.}

\item{data}{a list of \code{data.frame} objects for each longitudinal outcome
in which to interpret the variables named in the \code{formLongFixed} and
\code{formLongRandom}. The \code{list} structure enables one to include
multiple longitudinal outcomes with different measurement protocols. If the
multiple longitudinal outcomes are measured at the same time points for
each patient, then a \code{data.frame} object can be given instead of a
\code{list}. It is assumed that each data frame is in long format. \code{tibble}
objects are automatically converted to plain \code{data.frame} objects.}

\item{survData}{a \code{data.frame} in which to interpret the variables named
in the \code{formSurv}. This is optional, and if not given, the required
data is searched for in \code{data}. Default is \code{survData=NULL}.}

\item{timeVar}{a character string indicating the time variable in the linear
mixed effects model. If there are multiple longitudinal outcomes and the
time variable is labelled differently in each model, then a character
string vector can be given instead.}

\item{inits}{a list of initial values for some or all of the parameters
estimated in the model. Default is \code{NULL}, with initial values
estimated using separate multivariate linear mixed effects and Cox
proportional hazard regression models.}

\item{verbose}{logical: if \code{TRUE}, the parameter estimates and other
convergence statistics are value are printed at each iteration of the MCEM
algorithm. Default is \code{FALSE}.}

\item{pfs}{logical: if \code{TRUE}, then assuming the MCEM algorithm has
converged, post-fit statistics including the posterior means and variances
of the random effects, and the approximate standard errors are calculated
and returned as part of the model object. Default is \code{TRUE}. If
\code{FALSE}, then these additional calculations are not performed, which
can reduce the overall computational time. This option is intended to be
used with computationally intensive routines such as simulation and
bootstrap standard error estimation where these calculations are not
required.}

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

\item{...}{options passed to the \code{control} argument.}
}
\value{
An object of class \code{mjoint}. See \code{\link{mjoint.object}} for
  details.
}
\description{
This function fits the joint model proposed by Henderson et al.
  (2000), but extended to the case of multiple continuous longitudinal
  measures. The time-to-event data is modelled using a Cox proportional
  hazards regression model with time-varying covariates. The multiple
  longitudinal outcomes are modelled using a multivariate version of the
  Laird and Ware linear mixed model. The association is captured by a
  multivariate latent Gaussian process. The model is estimated using a
  (quasi-) Monte Carlo Expectation Maximization (MCEM) algorithm.
}
\details{
Function \code{mjoint} fits joint models for time-to-event and
  multivariate longitudinal data. A review of relevant statistical
  methodology for joint models of multivariate data is given in Hickey et al.
  (2016). This is a direct extension of the models developed in the seminal
  works of Wulfsohn and Tsiatis (1997) and Henderson et al. (2000), with the
  calculations based largely on Lin et al. (2002) who also extended the model
  to multivariate joint data. A more detailed explanation of the model
  formulation is given in the technical vignette. Each longitudinal outcome
  is modelled according to a linear mixed model (LMM), akin to the models fit
  by \code{\link[nlme]{lme}}, with independent and identically distributed
  Gaussian errors. The latent term in each model (specified by
  \code{formLongRandom}) is a linear combination of subject-specific
  zero-mean Gaussian random effects with outcome-specific variance
  components. We denote these as \eqn{W_{i1}(t, b_{i1})}, \eqn{W_{i2}(t,
  b_{i2})}, \eqn{\dots}, \eqn{W_{iK}(t, b_{iK})}, for the \emph{K}-outcomes.
  Usually, \eqn{W(t, b)} will be specified as either \eqn{b_0} (a
  random-intercepts model) or \eqn{b_0 + b_1t} (a random-intercepts and
  random-slopes model); however, more general structures are allowed The
  time-to-event model is modelled as per the usual Cox model formulation,
  with an additional (possibly) time-varying term given by

  \deqn{\gamma_{y1} W_{i1}(t, b_{i1}) + \gamma_{y2} W_{i2}(t, b_{i2}) + \dots
  + \gamma_{yK} W_{iK}(t, b_{iK}),}

  where \eqn{\gamma_y} is a parameter vector of proportional latent
  association parameters of length \emph{K} for estimation.

  The optimization routine is based on a Monte Carlo Expectation Maximization
  algorithm (MCEM) algorithm, as described by Wei and Tanner (1990). With
  options for using antithetic simulation for variance reduction in the Monte
  Carlo integration, or quasi-Monte Carlo based on low order deterministic
  sequences.
}
\section{Convergence criteria}{


  The routine internally scales and centers data to avoid overflow in the
  argument to the exponential function. These actions do not change the
  result, but lead to more numerical stability. Several convergence criteria
  are available: \describe{

  \item{\code{abs}}{the maximum absolute parameter change is
  \eqn{<}\code{tol0}. The baseline hazard parameters are not included in this
  convergence statistic.}

  \item{\code{rel}}{the maximum (absolute) relative parameter change is
  \eqn{<}\code{tol2}. A small value (\code{tol1}) is added to the denominator
  of the relative change statistic to avoid numerical problems when the
  parameters are close to zero.}

  \item{\code{either}}{\emph{either} the \code{abs} or \code{rel} criteria
  are satisfied.}

  \item{\code{sas}}{if \eqn{| \theta_p | < }\code{rav}, then the \code{abs}
  criteria is applied for the \emph{l}-th parameter; otherwise, \code{rel} is
  applied. This is the approach used in the SAS EM algorithm program for
  missing data.}

  }

  Due to the Monte Caro error, the algorithm could spuriously declare
  convergence. Therefore, we require convergence to be satisfied for 3
  consecutive iterations. The algorithm starts with a low number of Monte
  Carlo samples in the 'burn-in' phase, as it would be computationally
  inefficient to use a large sample whilst far away from the true maximizer.
  After the algorithm moves out of this adaptive phase, it uses an automated
  criterion based on the coefficient of variation of the relative parameter
  change of the last 3 iterations to decide whether to increase the Monte
  Carlo sample size. See the technical vignette and Ripatti et al. (2002) for
  further details.
}

\section{Standard error estimation}{


  Approximate standard errors (SEs) are calculated (if \code{pfs=TRUE}).
  These are based on the empirical observed information function (McLachlan &
  Krishnan, 2008). Through simulation studies, we have found that this
  approximation does not work particularly well for \eqn{n < 100} (where
  \emph{n} is the number of subjects). In these cases, one would need to
  appeal to the bootstrap SE estimation approach. However, in practice, the
  reliability of the approximate SEs will depend of a multitude of factors,
  including but not limited to, the average number of repeated measurements
  per subject, the total number of events, and the convergence of the MCEM
  algorithm.

  Bootstrap SEs are also available, however they are not calculated using the
  \code{mjoint} function due to the intense computational time. Instead, a
  separate function is available: \code{bootSE}, which takes the fitted joint
  model as its main argument. Given a fitted joint model (of class
  \code{mjoint}) and a bootstrap fit object (of class \code{bootSE}), the SEs
  reported in the model can be updated by running
  \code{summary(fit_obj,boot_obj)}. For details, consult the
  \code{\link{bootSE}} documentation.
}

\examples{
# Fit a classical univariate joint model with a single longitudinal outcome
# and a single time-to-event outcome

data(heart.valve)
hvd <- heart.valve[!is.na(heart.valve$log.grad) & !is.na(heart.valve$log.lvmi), ]

set.seed(1)
fit1 <- mjoint(formLongFixed = log.lvmi ~ time + age,
    formLongRandom = ~ time | num,
    formSurv = Surv(fuyrs, status) ~ age,
    data = hvd,
    timeVar = "time",
    control = list(nMCscale = 2, burnin = 5)) # controls for illustration only
summary(fit1)

\dontrun{
# Fit a joint model with bivariate longitudinal outcomes

data(heart.valve)
hvd <- heart.valve[!is.na(heart.valve$log.grad) & !is.na(heart.valve$log.lvmi), ]

fit2 <- mjoint(
    formLongFixed = list("grad" = log.grad ~ time + sex + hs,
                         "lvmi" = log.lvmi ~ time + sex),
    formLongRandom = list("grad" = ~ 1 | num,
                          "lvmi" = ~ time | num),
    formSurv = Surv(fuyrs, status) ~ age,
    data = list(hvd, hvd),
    inits = list("gamma" = c(0.11, 1.51, 0.80)),
    timeVar = "time",
    verbose = TRUE)
summary(fit2)
}

\dontrun{
# Fit a univariate joint model and compare to the joineR package

data(pbc2)
pbc2$log.b <- log(pbc2$serBilir)

# joineRML package
fit.joineRML <- mjoint(
    formLongFixed = list("log.bil" = log.b ~ year),
    formLongRandom = list("log.bil" = ~ 1 | id),
    formSurv = Surv(years, status2) ~ age,
    data = pbc2,
    timeVar = "year")
summary(fit.joineRML)

# joineR package
pbc.surv <- UniqueVariables(pbc2, var.col = c("years", "status2"),
                            id.col = "id")
pbc.long <- pbc2[, c("id", "year", "log.b")]
pbc.cov <- UniqueVariables(pbc2, "age", id.col = "id")
pbc.jd <- jointdata(longitudinal = pbc.long, baseline = pbc.cov,
                    survival = pbc.surv, id.col = "id", time.col = "year")
fit.joineR <- joint(data = pbc.jd,
    long.formula = log.b ~ 1 + year,
    surv.formula = Surv(years, status2) ~ age,
    model = "int")
summary(fit.joineR)
}
}
\references{
Henderson R, Diggle PJ, Dobson A. Joint modelling of longitudinal
measurements and event time data. \emph{Biostatistics.} 2000; \strong{1(4)}:
465-480.

Hickey GL, Philipson P, Jorgensen A, Kolamunnage-Dona R. Joint modelling of
time-to-event and multivariate longitudinal outcomes: recent developments and
issues. \emph{BMC Med Res Methodol.} 2016; \strong{16(1)}: 117.

Lin H, McCulloch CE, Mayne ST. Maximum likelihood estimation in the joint
analysis of time-to-event and multiple longitudinal variables. \emph{Stat
Med.} 2002; \strong{21}: 2369-2382.

McLachlan GJ, Krishnan T. \emph{The EM Algorithm and Extensions.} Second
Edition. Wiley-Interscience; 2008.

Ripatti S, Larsen K, Palmgren J. Maximum likelihood inference for
multivariate frailty models using an automated Monte Carlo EM algorithm.
\emph{Lifetime Data Anal.} 2002; \strong{8}: 349-360.

Wei GC, Tanner MA. A Monte Carlo implementation of the EM algorithm and the
poor man's data augmentation algorithms. \emph{J Am Stat Assoc.} 1990;
\strong{85(411)}: 699-704.

Wulfsohn MS, Tsiatis AA. A joint model for survival and longitudinal data
measured with error. \emph{Biometrics.} 1997; \strong{53(1)}: 330-339.
}
\seealso{
\code{\link{mjoint.object}}, \code{\link{bootSE}},
  \code{\link{plot.mjoint}}, \code{\link{summary.mjoint}},
  \code{\link{getVarCov.mjoint}}, \code{\link{simData}}.
}
\author{
Graeme L. Hickey (\email{graeme.hickey@liverpool.ac.uk})
}
\keyword{methods}
\keyword{multivariate}
\keyword{survival}
