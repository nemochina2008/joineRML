#' Mayo Clinic primary biliary cirrhosis data
#'
#' @description This data is from the Mayo Clinic trial in primary biliary
#'   cirrhosis (PBC) of the liver conducted between 1974 and 1984. A total of
#'   424 PBC patients, referred to Mayo Clinic during that ten-year interval met
#'   eligibility criteria for the randomized placebo controlled trial of the
#'   drug D-penicillamine, but only the first 312 cases in the data set
#'   participated in the randomized trial. Therefore, the data here are for the
#'   312 patients with largely complete data.
#'
#' @usage data(pbc2)
#' @format A data frame with 1945 observations on the following 20 variables:
#'   \describe{
#'
#'   \item{\code{id}}{patients identifier; in total there are 312 patients.}
#'
#'   \item{\code{years}}{number of years between registration and the earlier of
#'   death, transplantation, or study analysis time.}
#'
#'   \item{\code{status}}{a factor with levels \code{alive}, \code{transplanted}
#'   and \code{dead}.}
#'
#'   \item{\code{drug}}{a factor with levels \code{placebo} and
#'   \code{D-penicil}.}
#'
#'   \item{\code{age}}{at registration in years.}
#'
#'   \item{\code{sex}}{a factor with levels \code{male} and \code{female}.}
#'
#'   \item{\code{year}}{number of years between enrollment and this visit date,
#'   remaining values on the line of data refer to this visit.}
#'
#'   \item{\code{ascites}}{a factor with levels \code{No} and \code{Yes}.}
#'
#'   \item{\code{hepatomegaly}}{a factor with levels \code{No} and \code{Yes}.}
#'
#'   \item{\code{spiders}}{a factor with levels \code{No} and \code{Yes}.}
#'
#'   \item{\code{edema}}{a factor with levels \code{No edema} (i.e. no edema and
#'   no diuretic therapy for edema), \code{edema no diuretics} (i.e. edema
#'   present without diuretics, or edema resolved by diuretics), and
#'   \code{edema despite diuretics} (i.e. edema despite diuretic therapy).}
#'
#'   \item{\code{serBilir}}{serum bilirubin in mg/dl.}
#'
#'   \item{\code{serChol}}{serum cholesterol in mg/dl.}
#'
#'   \item{\code{albumin}}{albumin in mg/dl.}
#'
#'   \item{\code{alkaline}}{alkaline phosphatase in U/liter.}
#'
#'   \item{\code{SGOT}}{SGOT in U/ml.}
#'
#'   \item{\code{platelets}}{platelets per cubic ml/1000.}
#'
#'   \item{\code{prothrombin}}{prothrombin time in seconds.}
#'
#'   \item{\code{histologic}}{histologic stage of disease.}
#'
#'   \item{\code{status2}}{a numeric vector with the value 1 denoting if the
#'   patient was dead, and 0 if the patient was alive or transplanted.}
#'
#'   }
#' @keywords datasets
#' @seealso \code{\link{heart.valve}}, \code{\link{renal}},
#'   \code{\link{epileptic.qol}}.
#' @source \code{\link[JM]{pbc2}} and \code{\link[survival]{pbc}}.
#' @references
#'
#' Fleming T, Harrington D. \emph{Counting Processes and Survival Analysis}.
#' 1991; New York: Wiley.
#'
#' Therneau T, Grambsch P. \emph{Modeling Survival Data: Extending the Cox
#' Model}. 2000; New York: Springer-Verlag.
"pbc2"
