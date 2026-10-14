//8 Schools data
data {
  int<lower=0> N; //The number of schools
  vector[N] treatment; //Response variable
  vector[N] standard_error;  //The standard error
}

// The parameters accepted by the model.
parameters {
  array[N] real mu;
}


model {
  treatment ~ normal(mu, standard_error);
}

