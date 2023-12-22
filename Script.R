rm(list = ls())

# Initialise parameters


S0 = 1000      # initial stock price
K = 1000       # strike price
T = 10         # time to maturity in years
H = 1500       # up-and-out barrier price/value
r = 0.01      # annual risk-free rate
vol = 0.2     # volatility (%)

N = 100       # number of time steps
M = 100      # number of simulations


# Set seed for reproducibility
set.seed(689)


#------------------------#
# Slow Solution - Steps  #
#------------------------#
# Initialize variables

dt <- T/N
nudt <- (r - 0.5 * vol^2) * dt
volsdt <- vol * sqrt(dt)
erdt <- exp(r * dt)

# Standard Error Placeholders
sum_CT <- 0
sum_CT2 <- 0

# Monte Carlo Method
for (i in 1:M) {
  # Barrier Crossed Flag
  BARRIER <- FALSE
  St <- S0
  
  for (j in 1:N) {
    epsilon <- rnorm(1)
    Stn <- St * exp(nudt + volsdt * epsilon)
    St <- Stn
    
    if (St >= H) {
      BARRIER <- TRUE
      break
    }
  }
  
  if (BARRIER) {
    CT <- 0
  } else {
    CT <- max(0, K - St)
  }
  
  sum_CT <- sum_CT + CT
  sum_CT2 <- sum_CT2 + CT^2
}

# Compute Expectation and SE
C0 <- exp(-r * T) * sum_CT/M
sigma <- sqrt((sum_CT2 - sum_CT^2/M) * exp(-2 * r * T) / (M - 1))
SE <- sigma / sqrt(M)

cat("Call value is $", round(C0, 2), " with SE +/- ", round(SE, 3), "\n")


#-----------------------------#
# Vectorized Implementation   #
#-----------------------------#

# Set seed for reproducibility
set.seed(689)

# Precompute constants
dt <- T/N
nudt <- (r - 0.5 * vol^2) * dt
volsdt <- vol * sqrt(dt)
erdt <- exp(r * dt)

# Monte Carlo Method
Z <- matrix(rnorm(N * M), nrow = N, ncol = M)
delta_St <- nudt + volsdt * Z
ST <- matrix(S0, nrow = N + 1, ncol = M)
for (i in 2:(N + 1)) {
  ST[i,] <- ST[i - 1,] * exp(delta_St[i - 1,])
}

# Apply Barrier Condition to ST matrix
mask <- apply(ST, 2, function(x) any(x >= H))
ST[, mask] <- 0

CT <- pmax(0, K - ST[N + 1, ST[N + 1,] != 0])
C0 <- exp(-r * T) * sum(CT) / M

sigma <- sqrt(sum((exp(-r * T) * CT - C0)^2) / (M - 1))
SE <- sigma / sqrt(M)

cat("Call value is $", round(C0, 2), " with SE +/- ", round(SE, 3), "\n")

