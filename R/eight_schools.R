## Eight Schools: no-pooling vs hierarchical Bayesian models
## Data and model: Gelman et al., Bayesian Data Analysis, Chapter 5
##
## Run from the repository root:  Rscript R/eight_schools.R

library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

# ---- Data -------------------------------------------------------------------
schools <- read.csv("data/schools.csv", stringsAsFactors = FALSE)
str(schools)

data_stan <- list(
  N              = nrow(schools),   # number of schools
  treatment      = schools$effect,  # estimated treatment effect per school
  standard_error = schools$se       # standard error of each estimate
)

# ---- 1. Non-hierarchical (no pooling) model ---------------------------------
model_schools <- stan(
  file   = "stan/schools_no_pooling.stan",
  data   = data_stan,
  iter   = 1000,
  warmup = 500,
  chains = 4
)
print(model_schools)

# Convergence checks (shinystan is optional and interactive)
traceplot(model_schools, inc_warmup = FALSE)
# shinystan::launch_shinystan(model_schools)

plot(model_schools)

# ---- 2. Hierarchical (partial pooling, non-centered) model ------------------
model_multilevel <- stan(
  file   = "stan/schools_hierarchical.stan",
  data   = data_stan,
  iter   = 1000,
  warmup = 500,
  chains = 4
)
print(model_multilevel)

traceplot(model_multilevel, inc_warmup = FALSE)
plot(model_multilevel)
