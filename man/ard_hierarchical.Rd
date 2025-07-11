% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ard_hierarchical.R
\name{ard_hierarchical}
\alias{ard_hierarchical}
\alias{ard_hierarchical_count}
\alias{ard_hierarchical.data.frame}
\alias{ard_hierarchical_count.data.frame}
\title{Hierarchical ARD Statistics}
\usage{
ard_hierarchical(data, ...)

ard_hierarchical_count(data, ...)

\method{ard_hierarchical}{data.frame}(
  data,
  variables,
  by = dplyr::group_vars(data),
  statistic = everything() ~ c("n", "N", "p"),
  denominator = NULL,
  fmt_fun = NULL,
  stat_label = everything() ~ default_stat_labels(),
  id = NULL,
  fmt_fn = deprecated(),
  ...
)

\method{ard_hierarchical_count}{data.frame}(
  data,
  variables,
  by = dplyr::group_vars(data),
  fmt_fun = NULL,
  stat_label = everything() ~ default_stat_labels(),
  fmt_fn = deprecated(),
  ...
)
}
\arguments{
\item{data}{(\code{data.frame})\cr
a data frame}

\item{...}{Arguments passed to methods.}

\item{variables}{(\code{\link[dplyr:dplyr_tidy_select]{tidy-select}})\cr
variables to perform the nested/hierarchical tabulations within.}

\item{by}{(\code{\link[dplyr:dplyr_tidy_select]{tidy-select}})\cr
variables to perform tabulations by. All combinations of the variables
specified here appear in results. Default is \code{dplyr::group_vars(data)}.}

\item{statistic}{(\code{\link[=syntax]{formula-list-selector}})\cr
a named list, a list of formulas,
or a single formula where the list element one or more of  \code{c("n", "N", "p", "n_cum", "p_cum")}
(on the RHS of a formula).}

\item{denominator}{(\code{data.frame}, \code{integer})\cr
used to define the denominator and enhance the output.
The argument is required for \code{ard_hierarchical()} and optional
for \code{ard_hierarchical_count()}.
\itemize{
\item the univariate tabulations of the \code{by} variables are calculated with \code{denominator},
when a data frame is passed, e.g. tabulation of the treatment assignment
counts that may appear in the header of a table.
\item the \code{denominator} argument must be specified when \code{id} is used to
calculate the event rates.
}}

\item{fmt_fun}{(\code{\link[=syntax]{formula-list-selector}})\cr
a named list, a list of formulas,
or a single formula where the list element is a named list of functions
(or the RHS of a formula),
e.g. \verb{list(mpg = list(mean = \\(x) round(x, digits = 2) |> as.character()))}.}

\item{stat_label}{(\code{\link[=syntax]{formula-list-selector}})\cr
a named list, a list of formulas, or a single formula where
the list element is either a named list or a list of formulas defining the
statistic labels, e.g. \code{everything() ~ list(n = "n", p = "pct")} or
\code{everything() ~ list(n ~ "n", p ~ "pct")}.}

\item{id}{(\code{\link[dplyr:dplyr_tidy_select]{tidy-select}})\cr
an optional argument used to assert there are no duplicates within
the \code{c(id, variables)} columns.}

\item{fmt_fn}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}}
}
\value{
an ARD data frame of class 'card'
}
\description{
\emph{Functions \code{ard_hierarchical()} and \code{ard_hierarchical_count()} are primarily helper
functions for \code{\link[=ard_stack_hierarchical]{ard_stack_hierarchical()}} and \code{\link[=ard_stack_hierarchical_count]{ard_stack_hierarchical_count()}},
meaning that it will be rare a user needs to call
\code{ard_hierarchical()}/\code{ard_hierarchical_count()} directly.}

Performs hierarchical or nested tabulations, e.g. tabulates AE terms
nested within AE system organ class.
\itemize{
\item \code{ard_hierarchical()} includes summaries for the last variable listed
in the \code{variables} argument, nested within the other variables included.
\item \code{ard_hierarchical_count()} includes summaries for \emph{all} variables
listed in the \code{variables} argument each summary nested within the preceding
variables, e.g. \code{variables=c(AESOC, AEDECOD)} summarizes \code{AEDECOD} nested
in \code{AESOC}, and also summarizes the counts of \code{AESOC}.
}
}
\examples{
ard_hierarchical(
  data = ADAE |>
    dplyr::slice_tail(n = 1L, by = c(USUBJID, TRTA, AESOC, AEDECOD)),
  variables = c(AESOC, AEDECOD),
  by = TRTA,
  id = USUBJID,
  denominator = ADSL
)

ard_hierarchical_count(
  data = ADAE,
  variables = c(AESOC, AEDECOD),
  by = TRTA
)
}
