# Domain Specific Language (DSL) for stock timeseries

## Motivation

## Informal Semantics

### Time Variables

```
T = TimeVar(over=OfficialTradingMinutes,na_fill=...)
```

### Pandas-like DSL
```
T = TimeVar(...)
k = 20
interval = Interval(from=0, until=-k)
window_over_time = Over(T).RawSignal('EndPrice').RollingWindow(interval)
mean = window_over_time.Mean().Rename("mean")
std = window_over_time.Std().Rename("std")
normalized = mean/std
```

### Higher-level Features

#### Pointwise Arithmetic

```
const(0.7) 
0.8*f1
f1 + f2
f1 - f2
f1*f2
f1/f2
```


#### Arrays of features

```
interval = Interval(from=0, until=-k)

vector_at_t = Over(T).RawSignal('EndPrice').Range(interval)
```

#### Cluster centroids

```
clustering = KMeans(num_clusters=5)
interval = Interval(from=0, until=-k)
vector_at_t = Over(T).RawSignal('EndPrice').Range(interval)
# same as Range(...)
vector_at_t = Over(T).RawSignal('EndPrice').RollingWindow(interval).Vector()
clustered_feature = ClusteredFeature(clustering, vector_at_t)
# same as the above
vector_at_t = Over(T).RawSignal('EndPrice').RollingWindow(interval).ClusterCentroid(clustering)
```

#### Specialized features:

```
gains_on_long(max_gain=0.005, stop_loss=0.005, ...)
gains_on_short(max_gain=0.005, stop_loss=0.005, ...)
gains_sign(max_gain=0.005, stop_loss=0.005, ...)
```

#### Feature groups

```
TODO
```

## Implementation


## Adding Extensions


