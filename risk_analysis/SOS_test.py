import numpy as np
from risk_analysis import RiskAnalysisSOS

np.random.seed(8)

# Create an array of random stock prices.
N = 61  # number of trading days
price = 60. + 20. * np.random.rand(N,)

# Computes the daily return rates.
ret = np.zeros(N - 1,)
for i in range(N - 1):
  ret[i] = (price[i + 1] - price[i]) / price[i + 1]

Analyzer = RiskAnalysisSOS(daily_return=ret)
worst_prob, _ = Analyzer.analyze(
    r_min=-0.3, risk=True, emp_bd=True, est_prob=True, verbose=True
)
print('--> Worst-case probability =', worst_prob)
