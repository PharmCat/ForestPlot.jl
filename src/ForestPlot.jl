module ForestPlot

using Plots


export forestplot

"""
    forestplot(ci::Vector; sourcelabel = "Source:", metriclabel = "OR", cilabel = "CI95%", 
    source = nothing, metric = nothing, printci = false,
    summary = nothing, kwargs...)

By default plot is logscaled.

* `ci` - vector of confidence intervals bounds;
* `source` - vector of study names (String);
* `metric` - vector of metric estimates;
* `printci` - print confidence interval;
* `summary` - print summary object (Dict);



# Example

```
using ForestPlot

ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
sourcelabel = "Study:", metriclabel = "Estimate",
metric = [1.0, 1.2, 0.7, 1.3], 
source = ["12345678901234567890", "B", "C", "D"])
```

# Summary object

Summary is a Dict() with keywords:

* :ci
* :est
* :vline
* :markershape
* :markersize

# Example

```
ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
metric = [1.0, 1.2, 0.7, 1.3], source = ["A", "B", "C", "D"],
summary = Dict(:ci = (0.8, 1.1), :est = 0.95, :markershape = :diamond))
```

"""
function forestplot(ci::Vector; sourcelabel = "Source:", metriclabel = "OR", cilabel = "CI95%", 
    source = nothing, metric = nothing, printci = false,
    summary = nothing, kwargs...)

    if length(ci) < 10 
        ylims = (0, 11)
        sty   = 10
    else
        sty   = 10
    end

    maxx = round((maximum(x -> x[2], ci) - 0.1)/2, digits = 1)*2 + 0.2
    minx = round((minimum(x -> x[1], ci) - 0.1)/2, digits = 1)*2 
    xlims = exp.((minx, maxx))
    ticks = collect(minx:0.2*floor((maxx - minx)/0.2/4):maxx)

    p = plot()

    for i = 1:length(ci)
        plot!(p, exp.(ci[i]), fill(sty - i, 2), markershape = :vline, linecolor = :blue, markercolor = :blue)
    end
    if !isnothing(metric)
        my = sty .- collect(1:length(metric))
        plot!(exp.(metric), my, seriestype= :scatter, markershape = :rect, legend = false, markersize = 3)
    end

    if !isnothing(summary)
    end

    plot!(p, exp.([1, 1]),[0, 10.5]; linetype=:line, linealpha = 0.8, linecolor = :black)
    plot!(p; ylims = ylims, xlims = xlims, yshowaxis = false, ticks = (exp.(ticks), ticks))
    plot!(kwargs...)

    if !isnothing(source)
        tp = plot(showaxis = false, xlims=(0, 2.5), ylims = (0, 12))
        t = Plots.text(sourcelabel, halign = :left, family = "Palatino Bold")
        annotate!(tp, 0, sty + 1, t)
        for i = 1:length(source)
            if length(source[i]) > 15
                s = source[i][1:12]*"..."
            else
                s = source[i]
            end 
            t = Plots.text(s, halign = :left, family = "Palatino")
            annotate!(tp, 0, sty + 1 - i, t)
        end

        if !isnothing(metric) 
            t = Plots.text(metriclabel, halign = :left, family = "Palatino Bold")
            annotate!(tp, 2, sty + 1, t)
            for i = 1:length(metric)
                t = Plots.text(string(round(metric[i], digits = 3)), halign = :left, family = "Palatino")
                annotate!(tp, 2, sty + 1 - i, t)
            end
        end

        l = @layout [a b{0.50w}]
        return plot(tp, p, layout = l, legend = false)
    end
    p
end


end
