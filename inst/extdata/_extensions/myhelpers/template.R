#################################################################
#
# Title
# Author: Philipp Kleer
# Web: https://bpkleer.github.io
# Last change:
#
#################################################################

# Start Environment ---------
library(renv)
# Initialize a new renv project (creates renv.lock and renv library folder)
renv::init()

# Packages -----------
library(tidyverse)

# Graphics settings ------


# Local functions ------


# Loading Data ---------


# Manipulating Data --------


# Analysis ------

# Build Renv snapshot ---------
# Save the snapshot of the current project environment
# This updates the renv.lock file with package versions
renv::snapshot()

# At any point, you can restore the environment using:
# renv::restore()

# Save session information for reproducibility
session_info <- sessionInfo()
saveRDS(session_info, file = 'sessionInfo.rds')

# To deactivate the renv environment temporarily
# renv::deactivate()
