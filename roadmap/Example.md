As we said in the Roadmap, we want to carry out until we are able to show a successful strategy.

It's a long way, but to ensure we make progress we start simply. We use a stage-wise architecture rather than an end-to-end.

In the stagewise architecture, we develop the components separately and then we connect them together in a pipeline.
In an end-to-end architecture, one can optimize all components simultaneously. In the stagewise architecture,
each component is optimized without changing the parameters of other components.

There are two components that are strictly necessary:

- Predictor
- Strategy

The predictor takes as input the history of the time series returns a score. This score does not have to be up or down
or buy or sell, but has to be able to help make a successful strategy. In the past, i.e. before machine learning,
people used what they call indictors or oscilators. Those have the same interface as our predictor. For us,
indicators and oscilators are features. We want to have a lot of them with different parameter settings and
ask a machine learning algorithm to make the best combination of them.

The strategy will incorporate a number of our predictive scores. We will tune thresholds for the various scores
and when certain conditions on the scores are satisfied, we will enter or exit a position.

The predictor has a number of parts itself. First, we need to decide what to optimize for. Here are some options:

- predict the average price 30 minutes ahead
- predict the average price 60 minutes ahead
- predict the difference of the prices, i.e. crossover moving average but in the future.
- predict the value of an indicator statistic
- predict the distribution, as modelled by mean, variance or mixture
- when it comes to the distribution, there are a number of ways: fit to a fixed mean and variance, or estimate mean, variance and fit the generated points using maximum likelihood.
- predict the difference between endprice (or some smoothed version of it) and the max/min price in the future for a limited horizon such as the end of day. Such statistic is useful
for informing trading strategies. 

The second part of the predictor is feature engineering. An idea about useful features can be derived by studing the intuition behind indicators and oscilators.
If we use a linear model, we have to generate non linear features. Those features are useful to detect change of direction. The idea
is that the stock market is cyclic. For example, the intuition behind the RSI indicator is that a stock will go up until overbought, then it will change trend.
Similary, one statistic that we develop use the relationship between min, max and endprice. If endprice is close to the max price, we conlude the price
will go up. However, if we continue in this way we would reach a singular point, where end price equal max price. At this point, the direction may need to change.
There is a similar logic in some technical analysis where people draw lines and if they cross, its a special point.
One way to acomplish non-linear features is via thresholding. Another option is to use a decision tree on top of linear features. 

Regarding feature engineering, one needs to decide about the length of the history we use for prediction. One could imaging using even days worth of history.
This type of history could be useful, but needs to be appropriately summarized via summary statistics reflecting the distribution or change of distribution
in the days before.

Another point to be taken into account is discontinuities in the time series, such as between closing on the previous day and opening the next day. During
such discontinuities new information could have entered the system change change the course of the stock. 


Other components:
- preprocessing
- evaluation
- debugging support
- testing and in particular making sure we don't leak information from the future into the past

# Example

We give an example of such an architecture.

We try to predict the mean price two hours ahead. More speficially we predict

```
(mean price in the future m minutes - mean price in the past n minutes)/(mean price in the last s minutes)
```

The advantage of this statistic is that it is simple and smooth and also somewhat informative for strategies. In the future we will use a number of those
computed (m, m - 1, m -2 , ...) etc. minutes ahead.

1. For features we compute rolling means/min/max of the price the past 10, 20, ..., 240 minutes. 
2. We compute then other statistics which are differences of step 1.
3. We make sure the features in 2. are either naturally normalized (centered at 0 and between -1 and 1), or we normalize them by dividing by a mean price in the past m minutes.
4. We also compute shifted versions by 1, 2, ..., 10 minutes. 
5. We make sure all the features are centered at 0 and between -1 and 1 by normalizing them via z-score normalization if necessary. For some features this may not be required.


# Explanation of the results

We compute a score which is centered at 0 and between -1 and 1 most of the time. This means, given the current "average" price in the last 10 minutes is the "average" price in the next 2 hours going to go up or down
We truncate our score by keeping the predictions above let's say 0.4 and below -0.4. Those numbers are tuned on the data by taking percentiles.
If we set the threshold too high, it actually did not work because those were associated with change of trend. So it should be set lower but not too low.
The idea is that the score will change from lower than 0.4 to higher than 0.4. That could be a useful buy signal. If we wait too long, let's say for the score to become 0.6, then we could be
near the peak. So such calibration is very important. Is the non-linear nature of the stock price signal. If the price is too high, it might be too late to act. Of course, one should
also consider the time horizon. That's why we have a prediction 2 hours in the future, 4 hours in the future and so on. In the future we could explore the differences between such predictors.


 



 
