module ForestPlot

using Plots


export forestplot

"""
    forestplot(ci; sourcelabel = "Source:", metriclabel = "OR", cilabel = "CI95%", 
    source = nothing, metric = nothing, printci = false,
    summary = nothing, logscale = true, cimsz = -1, cimszwts = nothing, size = (600, 400), ticksn = 5, kwargs...)

By default plot is logscaled.

* `ci` - vector (iterable) of confidence intervals bounds;
* `source` - vector of study names (String);
* `metric` - vector of metric estimates;
* `printci` - print confidence interval;
* `summary` - print summary object (Dict);
* `logscale` - if true CI will be transformed (`exp` function used);
* `cimsz` - CI marker size, `-1` or any value < 0 - auto;
* `cimszwts` - CI marker size weights (if `nothing` - `metric` will be used);
* `size` - size of plot;
* `ticksn` - number of ticks;
* metriclabel = "OR" - label for metrics values;
* cilabel = "CI95%"- label for intervals values 
* ps = 10 - font size in points;


# Example

```
using ForestPlot

forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
sourcelabel = "Study:", metriclabel = "Estimate",
metric = [1.0, 1.2, 0.7, 1.3], 
source = ["12345678901234567890", "B", "C", "D"])
```

# Summary object

Summary is a Dict() with keywords:

* :ci
* :est
* :vline (true/false or vlues for vertical lines)
* :markershape
* :markersize

# Example 1

```
forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
metric = [1.0, 1.2, 0.7, 1.3], source = ["A", "B", "C", "D"],
summary = Dict(:ci =>[0.8, 1.1], :est => 0.95, :markershape => :rtriangle), logscale = false)
```

# Example 2

```
forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3], source = ["A", "B", "C", "D", "E", "F", "G"],
sourcelabel = "Study:", metriclabel = "Estimate", 
summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
logscale = true, printci = true, title = ["" "Title"], size = (800, 400))
```

"""
function forestplot(ci; sourcelabel = "Source:", metriclabel = "OR", cilabel = "CI95%", 
    source = nothing, metric = nothing, printci = false, refline::Union{Real, Bool} = 1,
    summary = nothing, logscale = true, cimsz = -1, cimszwts = nothing, size = (600, 400), ticksn = 5, ps = 10, kwargs...)

    #size=(800,400)
    lines = length(ci) + 3
    if lines <= 6  lines = 8 end
    ylims = (0, lines)
    sty   = lines - 1
    

    if logscale 
        func = exp
    else
        func = identity
    end

    maxx = round((maximum(x -> x[2], ci) - 0.1)/2, digits = 1)*2 + 0.2
    minx = round((minimum(x -> x[1], ci) - 0.1)/2, digits = 1)*2 
    xlims = func.((minx, maxx))
    #ticks = collect(minx:0.2*floor((maxx - minx)/0.2/4):maxx)
    ticks =  collect(range(minx, maxx, length = ticksn))

    p = plot(size = size)

    for i = 1:length(ci)
        plot!(p, func.(ci[i]), fill(sty - i, 2), markershape = :vline, linecolor = :blue, markercolor = :blue)
    end

    if cimsz < 0 && (!isnothing(metric) || !isnothing(cimszwts)) 
        if isnothing(cimszwts) cimszwts = metric end
        minm = minimum(cimszwts)
        c = (maximum(cimszwts) - minm)/3 
        cimsz = @. (cimszwts - minm) / c + 3 
    end

    if !isnothing(metric)
        my = sty .- collect(1:length(metric))
        plot!(func.(metric), my, seriestype= :scatter, markershape = :rect, markercolor = :gray, markeralpha = 0.8, markersize = cimsz, legend = false)
    end

    # Print summary CI
    if !isnothing(summary) && haskey(summary, :ci) && haskey(summary, :est)
        if haskey(summary, :markershape)
            ms = summary[:markershape]
        else
            ms = :diamond
        end
        if haskey(summary, :markersize)
            msz = summary[:markersize]
        else
            msz = 5
        end
        plot!(p, func.(summary[:ci]), fill(1, 2), markershape = :vline, linecolor = :red, markercolor = :red)
        plot!([func(summary[:est])], [1], seriestype= :scatter, markershape = ms, markercolor = :red, legend = false, markersize = msz)
    end
    if !isnothing(summary) && haskey(summary, :vline) && !(summary[:vline] === false) # Print Vlines
        if summary[:vline] === true && haskey(summary, :est) 
            plot!(p, func.([summary[:est], summary[:est]]),[0, sty], line = (:dash, 1.5), linealpha = 0.7, linecolor = :red)
        else 
            for v in summary[:vline]
                plot!(p, func.([v, v]),[0, sty], line = (:dash, 1.5), linealpha = 0.7, linecolor = :red)
            end
        end 
    end
    if !(refline === false)
        plot!(p, func.([refline, refline]),[0, sty]; linetype=:line, linealpha = 0.7,  linecolor = :black, line = (:dot, 1.5))
    end
    plot!(p; ylims = ylims, xlims = xlims, yshowaxis = false, ticks = (func.(ticks), round.(ticks, sigdigits=3)), kwargs...) # (@. round(func(ticks), digits=2), ticks))

    if !isnothing(source)
        tp = plot(showaxis = false, xlims=(0, 2.5), ylims = ylims, size = size)
        t = Plots.text(sourcelabel, halign = :left, family = "Palatino Bold", pointsize = ps)
        annotate!(tp, 0, sty, t)
        for i = 1:length(source)
            t = Plots.text(source[i], halign = :left, family = "Palatino", pointsize = ps)
            annotate!(tp, 0, sty - i, t)
        end

        if !isnothing(metric) 
            t = Plots.text(metriclabel, halign = :left, family = "Palatino Bold", pointsize = ps)
            annotate!(tp, 1.6, sty, t)
            for i = 1:length(metric)
                t = Plots.text(string(round(metric[i], digits = 3)), halign = :left, family = "Palatino", pointsize = ps)
                annotate!(tp, 1.8, sty - i, t)
            end
        end

        if printci
            t = Plots.text(cilabel, halign = :left, family = "Palatino Bold", pointsize = ps)
            annotate!(tp, 2.3, sty, t)
            for i = 1:length(ci)
                t = Plots.text(string("(",round(ci[i][1], sigdigits = 4), "-", round(ci[i][2], sigdigits = 4), ")"), halign = :left, family = "Palatino", pointsize = ps)
                annotate!(tp, 2.2, sty - i, t)
            end
        end

        l = @layout [a b{0.50w}]
        return plot(tp, p; layout = l, legend = false)
    else
        return plot!(p; kwargs...)
    end
end


end
