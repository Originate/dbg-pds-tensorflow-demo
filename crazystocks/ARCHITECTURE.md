# Goals

The goal is to produce a small toolkit and library for evaluating stock market strategies based on predictive approaches.

By predictive approaches, we mean machine learning on quantities related to the stock market. The quantities may include prices, volumes, expected gains/losses under some action.

By stragegies, we mean simple rule based strategies which use the predictions of the machine learning models
and may apply simple techniques as thresholding, stop-loss rules, time of day and so on.

The same code should be able to run on:

- the analyst's laptop using the DBG public dataset
- the quantopian.com website

# Stretch goals

Ideally, we should be able to demonstrate consistent gains on the models/strategies across multiple stocks
and also on quantopian.com. The strategies should be robust to slippage and costs.

# Non-goals

We don't aim to apply the most sophisticated modeling approaches (e.g. LSTM, multi-headed Attention Mechanism, very deep neural networks) at the intial stage. We use two basic models Linear Regression and Boosted Decision Trees together
with informative features.

Our focus is on robustness and usability of code. We want to enable ease of experimentation and ease of validation on quantopian.com. 

# Toolkit

![Toolkit Architecture](tools.png)

The toolkit consists of the following commands

## Data Downloader

- Input: a date range and local directory
- Output: downloaded DBG dataset

## Data Preprocessor

- Input: a local directory and a date range
- Output: preprocessed dataset suitable for machine learning

## Model Learner

- Input: objectives such as:
   - percent change T minutes ahead
   - volatility prediction
   - prediction of gains under some simple rules

- Output: a learned model


## Model Predictor

- Input: a test set and a single or multiple models
- Output: an extended test set containing the predicted scores

## Strategy Tuner

- Input: the ouput of model predictor and the name of a strategy
- Output: the parameters of a strategy

## Strategy Runner

- Input: strategy name, a parameter file from Strategy Tuner, and a dataset from Model Predictor
- Output: evaluation of a strategy

## Quantopian Model Bundler

- Input: strategy name, a parameter file from Strategy Tuner
- Output: a single file which contains all the model parameters and python code which can be run on quantopian.com

## Standalone (DBG) Model Bundler

- Input: strategy name, a parameter file from Strategy Tuner
- Output: a service to which data can be served on a minute by minute basis and which returns buy/sell decisions

# Libraries

We will build some of the above commands on two libraries

- Domain Specific Language (DSL) for stock timeseries
- Domain Specific Language (DSL) for strategies

## DSL for stock timeseries

As analysts we want to easily be able to express hypotheses. We opt to create a DSL similar to Pandas. 
You can find about the design in the [DSL for stock timeseries](DSL_stock_timeseries.md) document. 

## DSL for strategies

We want to easily be able to express the disjunction (or) of rules such as:

```
if we don't have any position and \
  a predictive score >= threshold and \
  time of day <= 14:00h then
  buy stock X
```

The DSL can have some variables such as thresholds, time of day, etc. as placeholders.
The values of those placeholders will be optimized.

You can find more from the [DSL for strategies](DSL_strategies.md) document. 

