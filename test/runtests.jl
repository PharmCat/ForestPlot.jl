using ForestPlot
using Test

@testset "ForestPlot.jl" begin
    ForestPlot.forestplot([[0.2, 1.2], [0.8, 1.4], [0.6, 0.8], [1.2, 1.6]], 
    metric = [1.0, 1.2, 0.7, 1.3], source = ["12345678901234567890", "B", "C", "D"], 
    sourcelabel = "Study:", metriclabel = "Estimate")
end
