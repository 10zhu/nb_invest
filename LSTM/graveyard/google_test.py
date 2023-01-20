import numpy as np
import seaborn as sns
import yfinance as yf
import datetime as dt
import matplotlib.pyplot as plt
from pandas_datareader import data as pdr
from sklearn.preprocessing import MinMaxScaler

from LSTM_predictor import LSTM_predictor

sns.set_style('whitegrid')
plt.style.use('fivethirtyeight')
yf.pdr_override()
end = dt.datetime.now()
start = dt.datetime(2012, 1, 1)
df = pdr.get_data_yahoo('goog', start, end)
print(df.head)

# DF with just close prices
data = df.filter(['Close'])

# pandas DataFrames converted into NumPy arrays
dataset = data.values

# Total rows.
lenOfTrain = int(np.ceil(len(dataset) * .95))

# Normalizes data.
scaler = MinMaxScaler(feature_range=(0, 1))
scaled_data = scaler.fit_transform(dataset)

# Creates data arrays.
trainData = scaled_data[0:int(lenOfTrain), :]
x_train = []
y_train = []
for i in range(60, len(trainData)):
  x_train.append(trainData[i - 60:i, 0])
  y_train.append(trainData[i, 0])
  # print out part of the arrays
  if i == 60:
    print(x_train)
    print(y_train)

# Converts the data to numpy.
x_train, y_train = np.array(x_train), np.array(y_train)

# Changes the data shape.
x_train = np.reshape(x_train, (x_train.shape[0], x_train.shape[1], 1))

# Trains the model.
predictor = LSTM_predictor()
model = predictor.train(x_train, y_train, verbose=True)

# Creates the test dataset.
testData = scaled_data[lenOfTrain - 60:, :]
X_test = []
y_test = dataset[lenOfTrain:, :]
for i in range(60, len(testData)):
  X_test.append(testData[i - 60:i, 0])
X_test = np.array(X_test)
X_test = np.reshape(X_test, (X_test.shape[0], X_test.shape[1], 1))

# Makes predictions.
predictions, rmse = predictor.predict(scaler, X_test, y_test)

# Plots the results.
train = data[:lenOfTrain]
valid = data[lenOfTrain:]
valid['Predictions'] = predictions

# Visualizes the data.
plt.figure(figsize=(16, 6))
plt.title('Model')
plt.xlabel('Date', fontsize=18)
plt.ylabel('Close Price USD ($)', fontsize=18)
plt.plot(train['Close'])
plt.plot(valid[['Close', 'Predictions']])
plt.legend(['Train', 'Val', 'Predictions'], loc='lower right')
plt.show()

# Saves the model.
model.save('LSTM/saved_model/Google')
