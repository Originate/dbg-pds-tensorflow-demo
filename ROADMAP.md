# Reacting on Feedback

After getting feedback about the project both internally at Originate and externally, we have found out that:

- stock market professionals are skeptical of how machine learning methods are applied to the stock market
- stock market professionals want rigerous proof of performance in their terms, not just prediction accuracy

Let us know what you would like to see by submitting a Github issue.

# From Machine Learning to Strategy Learning

To address the first issue we plan to develop trading strategies including such that are automatically tuned.
We found out that while machine learning itself is applicable to stock price prediction, prediction alone is not enough.
One needs to incorporate the machine learning prediction scores in a trading strategy. Often machine learning blogs 
and academic papers related to stock prediction stop short of showing results via a back test, and thus the skeptisism.

# Demonstration on Quantopian

While having access to minute-by-minute data enables offline exploration of various methods, those methods cannot be reliably tested
offline. Professionals require rigerous proofs of algorithm performance via:

- backtesting
- paper testing

We will address those issue be allowing the developed methods to work on [Quantopian](https://www.quantopian.com/).

## Domain-specific language for trading strategy specification

```python

position = Position()
s.add_position(position)

gain_threshold = 0.0008
loss_threshold = 0.001

s.add_rule('buy when our predictor score is high',
    When(position.is_empty()).and_when(score1 >= 0.0001). \
      and_when(score2 >= 0.0001). \
      and_when(score3 >= 0.0001). \
      and_when(score2 >= score3 + 0.00005). \
      action(buy).into(position)
)

s.add_rule(
    'liquidate position when we have enough gain and its going down (for long pos)',
    When(position.is_long()). \
        and_when(expected_gain(end_price, position) >= gain_threshold). \
        and_when(score2 <= 0.0). \
        action(liquidate).into(position)
)


s.add_rule(
    'liquidate position under stop-loss rule',
    When(position.is_active()).and_when(expected_loss(end_price, position) >= loss_threshold).action(liquidate).into(position)
)
```

The scores `score1`, `score2`, `score3` are based on the 30 and 60 min rolling means of the prices.

![Prediction & Strategy](diagrams/basic-strategy.png)

For example applying the strategy above to data for the stock 'RWE' on 2017-07-03 results in the following actions:

- Position 1
  - buy at 08:49:00
  - sell at 13:17:00
- Position 2
  - buy at 09:46:00
  - sell at 14:00:00

## Optimization of strategies

As seen above the specification of the strategy depends on a number of constants. Those need to be tuned on actual data.
We enable this by defining the constants as special type of variables that can be optimized by the back-tester.

```python
gain_threshold = OptVariable(0.00001, 0.01)
loss_threshold = OptVariable(0.00001, 0.01)
# and in general replacing all majic constants by OptVariable with a range
```

In the example above, we had to manually derive the three variables `score`, but ideally this should be automated.

A natural extension of the approach is the so called end-to-end architecture in machine learning, where we can attempt to 
optimize the whole system, i.e. from the strategy to the machine learning method to feature synthesis.

## Domain-specific language for feature extraction and normalization

```python
raw = SF.raw_signal('EndPrice')
s5=raw.rolling_window(dir="past", steps=5, shift=0, NAs='Ignore').mean()
s10=raw.rolling_window(dir="past", steps=10, shift=0, NAs='Ignore').mean()
s20=raw.rolling_window(dir="past", steps=20, shift=0, NAs='Ignore').mean()
s30=raw.rolling_window(dir="past", steps=30, shift=0, NAs='Ignore').mean()
s40=raw.rolling_window(dir="past", steps=40, shift=0, NAs='Ignore').mean()
s60=raw.rolling_window(dir="past", steps=60, shift=0, NAs='Ignore').mean()
s120=raw.rolling_window(dir="past", steps=120, shift=0, NAs='Ignore').mean()

all=MF.feature_group([s5, s10, s20, s30, s40, s60, s120])

all_normalized=all.normalize_with(s30)
```

## Special situations

There are a number of special situations in the stock market:

- end of day, start of day
- trade suspension during the day
- weekends





