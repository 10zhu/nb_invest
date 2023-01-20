import keras
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

from LSTM.util import process_data
from LSTM.LSTM_predictor import LSTM_predictor
from risk_analysis.risk_analysis import RiskAnalysisSOS

company_name = 'META'  #{GOOG, META, TSLA, AMZN}, {CNY, INR}

index_risk = 0.38  # smaller = less capable of taking risks
index_ret = 0.66  # smaller = care less about having high returns

num_stock = 50

target_prob_risk = 0.5 * index_risk
target_prob_ret = 0.5 * (1-index_ret)

r_min_risk_dict = {
    'GOOG': -0.10 * index_risk,
    'META': -0.32 * index_risk,
    'TSLA': -0.13 * index_risk,
    'AMZN': -0.07 * index_risk,
    'CNY': -0.030 * index_risk,
    'INR': -0.35 * index_risk
}
r_min_ret_dict = {
    'GOOG': 0.07 * index_ret,
    'META': 0.09 * index_ret,
    'TSLA': 0.07 * index_ret,
    'AMZN': 0.10 * index_ret,
    'CNY': 0.070 * index_ret,
    'INR': 0.06 * index_ret
}

# Obtains the training data.
x_train, y_train, scaler, _, dataset = process_data(company_name=company_name)

# Initializes the price predictor.
predictor = LSTM_predictor()

# Trains the model.
# model = predictor.train(x_train, y_train, verbose=True)
# model.save('LSTM/saved_model/' + company_name)

# Loads the model.
predictor.model = keras.models.load_model('LSTM/saved_model/' + company_name)

# Creates the test dataset.
x_test = x_train[-7:, :, :]  # Make dimension 0 to be 1.

# Makes predictions.
price_today = dataset[-1, 0]
price_pred, _ = predictor.predict(scaler, price_today, x_test)

# Concatenates testing data and predicted data.
price_history = dataset[-60:, :]
price_overall = np.concatenate((price_history, price_pred), axis=0)

# Visualizes the price data.
sns.set_style('whitegrid')
plt.style.use('fivethirtyeight')
plt.figure(figsize=(16, 6))
plt.title('Historic and predicted price data of ' + company_name)
plt.xlabel('Day', fontsize=18)
plt.ylabel('Close Price USD ($)', fontsize=18)
plt.plot(range(-59, 1), price_history)
plt.plot(range(0, 7), price_pred)
plt.legend(['Historic', 'Predicted'], loc='lower right')
plt.tight_layout()
plt.savefig('LSTM/saved_figs/' + company_name + '.png')
plt.show()

# Analyzes the risk.
N = price_overall.shape[0]

# Computes the daily return rates.
ret = np.zeros(N - 1,)
for i in range(N - 1):
  ret[i] = (price_overall[i + 1] - price_overall[i]) / price_overall[i + 1]

Analyzer = RiskAnalysisSOS(daily_return=ret)

print('\n###### Company: ', company_name, '######')

r_min_risk = r_min_risk_dict[company_name]
worst_prob_risk, _ = Analyzer.analyze(
    r_min=r_min_risk, risk=True, emp_bd=True, est_prob=True, verbose=True
)
print(
    '--> We calculated that the probability the daily return goes BELOW',
    round(r_min_risk * 100, 2), '% is upper bounded by',
    str(round(worst_prob_risk, 2)) + ', where the threshold on daily return',
    'is predicted based on your questionnaire.',
    'We also predicted based on the questionnaire that your maximum',
    'acceptable probability is',
    str(round(target_prob_risk, 2)) + '.',
    'Based on the return threshold, your worst-case loss is $',
    round(r_min_risk * price_today * num_stock, 2)
)

r_min_ret = r_min_ret_dict[company_name]
worst_prob_ret, _ = Analyzer.analyze(
    r_min=r_min_ret, risk=False, emp_bd=True, est_prob=True, verbose=True
)
print(
    '--> We calculated that the probability the daily return goes ABOVE',
    round(r_min_ret * 100, 2), '% is upper bounded by',
    str(round(worst_prob_ret, 2)) + ', where the threshold on daily return',
    'is predicted based on your questionnaire.',
    'We also predicted based on the questionnaire that your minimum',
    'acceptable probability is',
    str(round(target_prob_ret, 2)) + '.',
    'Based on the return threshold, your best-case return is $',
    round(r_min_ret * price_today * num_stock, 2)
)
