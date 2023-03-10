```@meta
CurrentModule = ForestPlot
```

# ForestPlot

Documentation for [ForestPlot](https://github.com/PharmCat/ForestPlot.jl).

ForestPlot is a simple package to draw forest plots for mata-analysis study.

```@setup fpexample
ENV["GKSwstype"] = "nul"
```

# Examples

```@example fpexample
using ForestPlot

p = forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
    metric = [1.0, 1.2, 0.7, 1.3], source = ["A", "B", "C", "D"],
    summary = Dict(:ci =>[0.8, 1.1], :est => 0.95, :markershape => :rtriangle), logscale = false)

png(p, "plot1.png")
```

![](plot1.png)

```@example fpexample

p = forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
    metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3], source = ["A", "B", "C", "D", "E", "F", "G"],
    sourcelabel = "Study:", metriclabel = "Estimate", 
    summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
    logscale = true, printci = true, title = ["" "Title"], size = (800, 400))

png(p, "plot2.png")
```

![](plot2.png)

```@example fpexample

p = forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
    metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3],
    summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
    logscale = true, title = "Title")

png(p, "plot3.png")
```

![](plot3.png)

```@example fpexample

p = forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
    metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3], source = ["A", "B", "C", "D", "E", "F", "G"],
    cimszwts = [1.0, 2.0, 3.0, 2.5, 4.0, 4.0, 0.5],
    sourcelabel = "Study:", metriclabel = "Estimate", 
    summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
    logscale = false, title = ["" "Title"], size = (800, 400))

png(p, "plot4.png")
```

![](plot4.png)



```@index
```

```@autodocs
Modules = [ForestPlot]
```
