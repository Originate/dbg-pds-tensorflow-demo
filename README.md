# Using Tensorflow to the Deutsche Börse Public Dataset For Stockmarket Price Prediction

## Introduction

We use neural networks applied to stock market data from the Deutsche Börse Public Dataset to make predictions about future price movement. Specifically, we a prediction on the direction of the next minute's price change using information from the previous ten minutes. We use this to power a highly simplified trading strategy to show the scale of potential returns.

This is intended as a demonstrate of the applications on this data set.

## The Deutsche Börse Public Dataset

The Deutsche Börse Public Dataset (PDS) project provides minute-by-minute statistics over trading data from the XETRA and EUREX engines.

We focus on XETRA only. It is comprised of a variety of equities, funds and derivative securities. The PDS contains details for on a per security level, detailing trading activity by minute including the high, low, first and last prices within the time period.

## Getting Started

Ensure you have Docker installed before completing the following steps.

1. Run `./build.sh` in the main repo folder to build the Docker image.
2. Run `./run-notebook.sh` to receive the notebook URL. Copy/paste this into your browser to access the notebook.
3. Start with the notebooks in order. Notebook 02- prepared the data for the other notebooks.

Additionally, you should run step 1 (`./build.sh`) after each pull where the Dockerfile has been updated to rebuild your local version against the latest update.


## References

TBC
