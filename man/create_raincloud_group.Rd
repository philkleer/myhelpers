\name{create_raincloud_group}
\alias{create_raincloud_group}
\title{Create a simple raincloud plot for a categorial variable on a metric variable}
\description{
This function creates a simple raincloud of a single categorial variable on a metric variable. It utilizes \code{beyonce} for coloring, \code{ggdist} and \code{gghalves} for additional plotting.
}
\usage{
create_raincloud_group(
  df,
  metricvar,
  groupvar
  )
}
\arguments{
  \item{df}{Data frame}
  \item{metricvar}{Metric variable}
  \item{groupvar}{Categorical variable}
}
\examples{
# create_raincloud_group(
#  df,
#  metricvar,
#  groupvar
#  )
}
