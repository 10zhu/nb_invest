"""
Risk analysis for stock investment decision making using sum of squares (SOS)
optimization. Computes the worst-case probability that the daily return falls
below a given threshold.

Please contact the author(s) of this library if you have any questions.
Authors:
    Yiling Zhu (yiling10@seas.upenn.edu)
    Minyi Hu (huminyi@seas.upenn.edu)
    Qi Yu (yuqij@seas.upenn.edu)
"""

import sympy as sp
import numpy as np
from typing import Tuple
from SumOfSquares import SOSProblem


class RiskAnalysisSOS():

  def __init__(self, daily_return: np.ndarray, r_bd_default: float = 0.4):
    """
    Constructor for RiskAnalysisSOS.

    Args:
        daily_return (np.ndarray): (N,) array of daily return (rates)
        r_bd_default (float, optional): Default value of r_bd. Defaults to 0.4.
    """
    self.daily_return = daily_return
    self._compute_moments()
    self.r_bd_default = r_bd_default

  def _compute_moments(self) -> None:
    """
    Computes empirical means of moments based on daily return data.
    """
    self.m1 = np.mean(self.daily_return)
    self.m2 = np.var(self.daily_return)

  def analyze(
      self, r_min: float, risk: bool = True, emp_bd: bool = False,
      est_prob: bool = True, verbose: bool = False
  ) -> Tuple[float, float]:
    """
    Computes the the worst-case probability that the daily return falls below
    r_min, the minimum acceptable return rate.

    Args:
        r_min (float): minimum acceptable return rate.
        risk (bool): True = analyze risk (worst-case return), False = analyze
          return (best-case return). Defaults to True.
        emp_bd (bool, optional): if to compute empirical bound of the support
          of daily returns. Defaults to False.
        est_prob (bool, optional): if set to True, then estimate the
          probability proportional to the degree of relaxation in r_min.
          Defaults to True.
        verbose (bool, optional): verbose setting. Defaults to False.

    Returns:
        float: worst-case probability that the daily return falls below r_min.
    """

    if risk:
      assert r_min < 0, 'r_min must be negative for worst-case analysis'
    else:
      assert r_min > 0, 'r_min must be positive for best-case analysis'

    self.r_min = r_min

    # Determine the support of daily returns.
    if emp_bd:
      if risk:
        self.r_bd = np.abs(np.min(self.daily_return))
      else:
        self.r_bd = np.abs(np.max(self.daily_return))
    else:
      self.r_bd = self.r_bd_default

    if verbose:
      if risk:
        print('\n*** Analyzing WORST-CASE return ***')
      else:
        print('\n*** Analyzing BEST-CASE return ***')
      print('Empirical mean m1 = ' + str(self.m1))
      print('Empirical variance m2 = ' + str(self.m2))
      print('Support bound r_bd = ' + str(self.r_bd))

    if risk:
      assert r_min > -self.r_bd, 'r_min must be greater than -r_bd = ' + str(
          -self.r_bd
      )
    else:
      assert r_min < self.r_bd, 'r_min must be less than r_bd = ' + str(
          self.r_bd
      )

    _max_retry = 10
    _retry_count = 0
    _r_min_scaling = 0.8
    flag = True
    while flag and _retry_count <= _max_retry:

      # Defines decision variables.
      x, gamma = sp.symbols('x gamma')
      q0, q1, q2 = sp.symbols('q0 q1 q2')
      r0, r1, r2 = sp.symbols('r0 r1 r2')
      s0, s1, s2 = sp.symbols('s0 s1 s2')

      # Defines polynomials.
      q = q0 + q1*x + q2 * x**2
      r = r0 + r1*x + r2 * x**2
      s = s0 + s1*x + s2 * x**2

      # Defines the SOS problem.
      prob = SOSProblem()

      # Maps sympy variables to picos variables.
      gamma_pic = prob.sym_to_var(gamma)
      q0_pic = prob.sym_to_var(q0)
      q1_pic = prob.sym_to_var(q1)
      q2_pic = prob.sym_to_var(q2)

      # Defines constraints.
      p1 = q - (self.r_bd**2 - x**2) * s
      if risk:
        p2 = q - 1 - (self.r_bd + x) * (r_min-x) * r
      else:
        p2 = q - 1 - (self.r_bd - x) * (x-r_min) * r

      prob.add_sos_constraint(p1, [x])
      prob.add_sos_constraint(p2, [x])
      prob.add_sos_constraint(r, [x])
      prob.add_sos_constraint(s, [x])

      prob.add_constraint(
          gamma_pic >= q0_pic + self.m1 * q1_pic + self.m2 * q2_pic
      )
      # The risk analysis is done for all distributions whose first 2 moments
      # are within x% of the empirical ones.
      # Here, we use the certainty-equivalent (CE) approach (i.e. x = 0).
      # Non-CE approaches would require robust LP + SOS, which is not yet
      # supported in Python.

      # Defines the objective function (minimize the worst-case probability).
      prob.set_objective('min', gamma_pic)

      # Sets the SDP solver.
      prob.options.solver = "cvxopt"

      # Attempt to solve the SOS problem.
      try:
        prob.solve()
        solution = prob.value
        flag = False

      except:
        solution = -1.

        # Relax r_min.
        r_min *= _r_min_scaling
        # if verbose:
        #   print('Relaxing r_min to', r_min)

      if est_prob and solution != -1 and _retry_count > 0:
        solution_old = solution
        solution = solution * (r_min / self.r_min)
        if verbose:
          print(
              'Estimating the probability based on r_min relaxation.'
              + ' The original probability is ' + str(solution_old)
          )

      _retry_count += 1

    return solution, r_min
