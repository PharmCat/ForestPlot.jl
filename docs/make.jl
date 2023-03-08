using ForestPlot
using Documenter

DocMeta.setdocmeta!(ForestPlot, :DocTestSetup, :(using ForestPlot); recursive=true)

makedocs(;
    modules=[ForestPlot],
    authors="Vladimir Arnautov",
    repo="https://github.com/PharmCat/ForestPlot.jl/blob/{commit}{path}#{line}",
    sitename="ForestPlot.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://PharmCat.github.io/ForestPlot.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/PharmCat/ForestPlot.jl",
    devbranch="main",
)
