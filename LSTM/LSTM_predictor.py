"""
Trains an LSTM model to predict future prices.

Please contact the author(s) of this library if you have any questions.
Authors:
    Yiling Zhu (yiling10@seas.upenn.edu)
    Minyi Hu (huminyi@seas.upenn.edu)
    Qi Yu (yuqij@seas.upenn.edu)
"""

import numpy as np
from keras.layers import LSTM
from keras.layers import Dense
from keras.models import Sequential


class LSTM_predictor():

  def __init__(self):
    """
    Constructor for LSTM_predictor.
    """

  def train(
      self, x_train: np.ndarray, y_train: np.ndarray, verbose: bool = False
  ) -> Sequential:
    """
    Trains the model.

    Args:
        x_train (np.ndarray): training data
        y_train (np.ndarray): training labels
        verbose (bool, optional): verbose option. Defaults to False.

    Returns:
        Sequential: LSTM model.
    """
    # Prints data shape.
    if verbose:
      print(f"Size of the training data is {x_train.shape}")

    # Defines the LSTM model.
    model = Sequential()
    model.add(
        LSTM(128, return_sequences=True, input_shape=(x_train.shape[1], 1))
    )
    model.add(LSTM(64, return_sequences=False))
    model.add(Dense(25))
    model.add(Dense(1))

    # Defines optimizer and loss.
    model.compile(optimizer='adam', loss='mean_squared_error')

    # Traines the model.
    if verbose:
      model.fit(x_train, y_train, batch_size=1, epochs=1)
    else:
      model.fit(x_train, y_train, batch_size=1, epochs=1, verbose=0)

    self.model = model

    return model

  def predict(
      self, scaler, offset: float, x_test: np.ndarray,
      y_test: np.ndarray = None, verbose: bool = False
  ) -> np.ndarray:
    """
    Makes prediction based on trained model.

    Args:
        scaler: MinMaxScaler
        offset: offset value
        x_test (np.ndarray): test data
        y_test (np.ndarray, optional): test labels. Defaults to None.
        verbose (bool, optional): verbose option. Defaults to False.

    Returns:
        predictions (np.ndarray): predicted data
        rmse (float): rmse value
    """
    if verbose:
      predictions = self.model.predict(x_test)
    else:
      predictions = self.model.predict(x_test, verbose=0)

    predictions = scaler.inverse_transform(predictions)

    offset = predictions[0, 0] - offset
    predictions -= offset

    if y_test is not None:
      rmse = np.sqrt(np.mean(((predictions - y_test)**2)))
    else:
      rmse = None
    return predictions, rmse

  def predict_multiple(
      self, scaler, x_test: np.ndarray, N_days: int, verbose: bool = False
  ) -> np.ndarray:
    """
    Makes prediction based on trained model for multiple future trading days.

    Args:
        scaler: MinMaxScaler
        x_test (np.ndarray): test data
        N_days (int): number of future days
        verbose (bool, optional): verbose option. Defaults to False.

    Returns:
        predictions_multiple (np.ndarray): predicted price
    """
    assert len(x_test.shape) == 3, 'x_test must be a 3D vector.'
    assert x_test.shape[0] == 1, 'Dimension 0 of x_test must be 1.'

    predictions_multiple = np.zeros((N_days, 1))

    for i in range(N_days):
      # Predicts day i's price.
      predictions, _ = self.predict(scaler, x_test, verbose=verbose)

      # Append results.
      predictions_multiple[i, :] = predictions

      # Slides testing data.
      x_test = x_test[:, 1:, :]
      x_test = np.concatenate((x_test, predictions.reshape(1, 1, 1)), axis=1)

    return predictions_multiple
