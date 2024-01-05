\name{create_raincloud}
\alias{create_raincloud}
\title{Create a simple raincloud plot for a categorial variable on a metric variable}
\description{
This function creates a simple raincloud of a single categorial variable on a metric variable. It utilizes \code{beyonce} for coloring, \code{ggdist} and \code{gghalves} for additional plotting.
}
\usage{
create_raincloud(
  df,
  groupvar,
  metricvar
  )
}
\arguments{
  \item{df}{Data frame}
  \item{groupvar}{Categorical variable}
  \item{metricvar}{Metric variable}
}
\examples{
# create_raincloud(
#  df,
#  groupvar,
#  metricvar
#  )
}
