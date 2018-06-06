# Stock Price Movement Prediction Using The Deutsche Börse Public Dataset & Machine Learning

## Introduction

We use neural networks applied to stock market data from the Deutsche Börse Public Dataset (PDS) to make predictions about future price movements for each stock.

Specifically, we make a prediction on the direction of the next minute's price change using information from the previous ten minutes. We use this to power a simplified trading strategy to show potential returns.

This is intended as a demonstrate of the applications on this data set.

## The Deutsche Börse Public Dataset

The [Deutsche Börse PDS project](https://github.com/Deutsche-Boerse/dbg-pds) provides minute-by-minute statistics over trading data from the [XETRA](http://www.xetra.com/) and [EUREX](http://www.eurexchange.com/exchange-en/) engines.

We focus on XETRA only. It is comprised of a variety of equities, funds and derivative securities. The PDS contains details for on a per security level, detailing trading activity by minute including the high, low, first and last prices within the time period.

## Getting Started

Ensure you have Docker installed before completing the following steps.

1. Run `./build.sh` in the main repo folder to build the Docker image.
2. Run `./run-notebook.sh` to receive the notebook URL. Copy/paste this into your browser to access the notebook.
3. Start with the notebooks in order. Notebook 02- prepared the data for the other notebooks.

Additionally, you should run step 1 (`./build.sh`) after each pull where the Dockerfile has been updated to rebuild your local version against the latest update.

## Project Structure

The work here is divided across three notebooks:

- [Notebook 1: Obtain, Clean & Understand Data](https://github.com/Originate/dbg-pds-tensorflow-demo/blob/master/notebooks/01-data-cleaning-single-stock.ipynb)
  - We obtain 1 day's worth of data to understand its structure and behaviour.
- [Notebook 2: Create Test Dataset](https://github.com/Originate/dbg-pds-tensorflow-demo/blob/master/notebooks/02-load-multiple-days-and-prepare-ds.ipynb)
  - Using the understanding from Notebook 1, we create the full test dataset.
- [Notebook 3: Applying A Neural Network](https://github.com/Originate/dbg-pds-tensorflow-demo/blob/master/notebooks/03-stock-price-prediction-machine-learning.ipynb)
  - We create and apply a neural network approach to the test dataset and the challenge of price movement prediction, and assess its performance.

## Additional notebooks
- [What prices are predictable](https://github.com/Originate/dbg-pds-tensorflow-demo/blob/master/notebooks/supporting/what-prices-to-predict.ipynb) 
  - We find out that it matters weather you predict an EndPrice, a MeanPrice or a MedianPrice in the next interval. We show how one can normalize the prices to improve the prediction.
- [Clustering Stocks](https://github.com/Originate/dbg-pds-tensorflow-demo/blob/master/notebooks/supporting/stock-clustering-via-price-correlations.ipynb) 
  - We cluster 100 stocks from the dataset using data from 60 days.
- [Simpler Linear Model](https://github.com/Originate/dbg-pds-tensorflow-demo/blob/master/notebooks/supporting/simple-linear-model.ipynb) 
  - We show a well-performing linear model with hand-engineered features on a single stock. We predict the average price of the next day for a single stock. This is intended to get started easily with the dataset and price modeling.
- [Large-scale linear model predicting 20 minutes ahead](https://github.com/Originate/dbg-pds-tensorflow-demo/blob/master/notebooks/supporting/adapted-03-stock-price-prediction-machine-learning-20-minutes-intervals.ipynb) 
  - We run a linear model on the 50 most liquid stocks with proper training and test sets. We predict the direction of the average price in the next 20 minutes.

## Documentation

General project documentation can be found in the wiki [here](https://github.com/Originate/dbg-pds-tensorflow-demo/wiki).

## Authors

- Stefan Savev (Originate)
- Rey Farhan (Originate)
