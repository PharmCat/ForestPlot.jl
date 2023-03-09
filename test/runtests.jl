using ForestPlot
using Test

@testset "ForestPlot.jl" begin
    @test_nowarn ForestPlot.forestplot([[0.2, 1.2], [0.8, 1.4], [0.6, 0.8], [1.2, 1.6]], 
    metric = [1.0, 1.2, 0.7, 1.3], source = ["12345678901234567890", "B", "C", "D"], 
    sourcelabel = "Study:", metriclabel = "Estimate")

    @test_nowarn ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
    metric = [1.0, 1.2, 0.7, 1.3], source = ["A", "B", "C", "D"], 
    sourcelabel = "Study:", metriclabel = "Estimate", 
    summary= Dict(:ci => [0.75,1.15], :est => 0.9), logscale = false)

    @test_nowarn ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
    metric = [1.0, 1.2, 0.7, 1.3], source = ["A", "B", "C", "D"],
    summary = Dict(:ci =>[0.8, 1.1], :est => 0.95, :markershape => :rtriangle), logscale = false)

    @test_nowarn ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6]], 
    metric = [1.0, 1.2, 0.7, 1.3], source = ["12345678901234567890", "B", "C", "D"],
     sourcelabel = "Study:", metriclabel = "Estimate", 
     summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
     logscale = true, printci = true)

     @test_nowarn ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
    metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3], source = ["A", "B", "C", "D", "E", "F", "G"],
     sourcelabel = "Study:", metriclabel = "Estimate", 
     summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
     logscale = true, printci = true, title = ["" "Title"], size = (800, 400))

     @test_nowarn ForestPlot.forestplot([[0.2,1.2], [0.8,1.4], [0.6, 0.8], [1.2, 1.6], [0.3, 0.7], [1.2, 1.5], [1.2, 1.3]], 
    metric = [1.0, 1.2, 0.7, 1.3, 0.5, 1.2, 1.3],
     sourcelabel = "Study:", metriclabel = "Estimate", 
     summary= Dict(:ci => [0.75,1.15], :est => 0.9), 
     logscale = true, printci = true, title = "Title")

end
