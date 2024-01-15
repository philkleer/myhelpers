\name{create_raincloud_facet}
\alias{create_raincloud_facet}
\title{Create a simple raincloud plot for a categorial variable on a metric variable grouped by a third variable}
\description{
This function creates a simple raincloud of a single categorial variable on a metric variable grouped by a third variable. It utilizes \code{beyonce} for coloring, \code{ggdist} and \code{gghalves} for additional plotting.
}
\usage{
create_raincloud_facet(
  df,
  metricvar,
  groupvar,
  facetvar
  )
}
\arguments{
  \item{df}{Data frame}
  \item{metricvar}{Metric variable}
  \item{groupvar}{Categorical variable}
  \item{facetvar}{A second categorical variable for facets}
}
\examples{
#create_raincloud_facet(
#  df,
#  metricvar,
#  groupvar,
#  facetvar
#  )
}
