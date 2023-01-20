"""
Utility functions.

Please contact the author(s) of this library if you have any questions.
Authors:
    Yiling Zhu (yiling10@seas.upenn.edu)
    Minyi Hu (huminyi@seas.upenn.edu)
    Qi Yu (yuqij@seas.upenn.edu)
"""

import numpy as np
import datetime as dt
import yfinance as yf
from pandas_datareader import data as pdr
from sklearn.preprocessing import MinMaxScaler


def process_data(company_name: str):
  yf.pdr_override()
  end = dt.datetime.now()
  start = dt.datetime(2012, 1, 1)
  df = pdr.get_data_yahoo(company_name, start, end)

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

  # Converts the data to numpy.
  x_train, y_train = np.array(x_train), np.array(y_train)

  # Changes the data shape.
  x_train = np.reshape(x_train, (x_train.shape[0], x_train.shape[1], 1))

  return x_train, y_train, scaler, scaled_data, dataset
