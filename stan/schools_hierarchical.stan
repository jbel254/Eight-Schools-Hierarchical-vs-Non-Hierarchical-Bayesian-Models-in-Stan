data {
  int<lower=0> N;
  vector[N] treatment;
  vector<lower=0>[N] standard_error;
}
parameters {
  real alpha;               // population mean effect
  real<lower=0> beta;       // between-school SD
  vector[N] eta;            // standardized school offsets
}
transformed parameters {
  vector[N] mu = alpha + beta * eta;   // school-level effects
}
model {
  alpha ~ normal(0, 20);
  beta ~ cauchy(0, 5);    // half-normal because of the lower bound
  eta   ~ std_normal();
  treatment ~ normal(mu, standard_error);
}
