# ForestPlot [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://PharmCat.github.io/ForestPlot.jl/stable/) [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://PharmCat.github.io/ForestPlot.jl/dev/) [![Build Status](https://github.com/PharmCat/ForestPlot.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/PharmCat/ForestPlot.jl/actions/workflows/CI.yml?query=branch%3Amain) [![Coverage](https://codecov.io/gh/PharmCat/ForestPlot.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/PharmCat/ForestPlot.jl)


A simple package to draw forest plots for meta-analysis study.

## Install 

```
Pkg.add(url="https://github.com/PharmCat/ForestPlot.jl.git")
```

## Docs

```
    forestplot(ci; sourcelabel = "Source:", metriclabel = "OR", cilabel = "CI95%", 
    source = nothing, metric = nothing, printci = false,
    summary = nothing, logscale = true, kwargs...)
```

By default plot is logscaled.

* `ci` - vector (iterable) of confidence intervals bounds;
* `source` - vector of study names (String);
* `metric` - vector of metric estimates;
* `printci` - print confidence interval;
* `summary` - print summary object (Dict);
* `logscale` - if true CI will be transformed (`exp` function used).

#### Example

```
using ForestPlot

forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
sourcelabel = "Study:", metriclabel = "Estimate",
metric = [1.0, 1.2, 0.7, 1.3], 
source = ["12345678901234567890", "B", "C", "D"])
```

#### Summary object

Summary is a Dict() with keywords:

* :ci
* :est
* :vline
* :markershape
* :markersize

#### Example 1

```
forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
metric = [1.0, 1.2, 0.7, 1.3], source = ["A", "B", "C", "D"],
summary = Dict(:ci =>[0.8, 1.1], :est => 0.95, :markershape => :rtriangle), logscale = false)
```

#### Example 2

```
ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
    metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3], source = ["A", "B", "C", "D", "E", "F", "G"],
     sourcelabel = "Study:", metriclabel = "Estimate", 
     summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
     logscale = true, printci = true, title = ["" "Title"], size = (800, 400))
```

<img src=""  width="50%" height="50%">


#### Example 3 (no source)

```
ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
    metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3],
     sourcelabel = "Study:", metriclabel = "Estimate", 
     summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
     logscale = true, printci = true, title = "Title")
```

<img src=""  width="50%" height="50%">