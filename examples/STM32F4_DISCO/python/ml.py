import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import LabelEncoder

data = pd.read_csv("data.csv")

crop_enc =  LabelEncoder()
model = LinearRegression(fit_intercept=True)
y = crop_enc.fit_transform(data['crop'])
X = data['val']

model.fit(X.reshape(-1, 1), y)

crop_enc.inverse_transform(model.predict(int(input("Enter the test predction value - "))))