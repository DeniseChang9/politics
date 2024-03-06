#### Preamble ####
# Purpose: Models... 
# Author: Rohan Alexander 
# Date: 5 March 2024 
# Contact: dede.chang@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(arrow)
library(rstanarm)
library(tidyverse)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.csv")

set.seed(853)

ces2020_reduced <- 
  ces2020 |> 
  slice_sample(n = 1000)

### Model data ####
first_model <-
  stan_glm(
    formula = voted_for ~ gender + education,
    data = analysis_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)