include("../../methods/evaluate_chromosome.jl")

using BlackBoxOptimizationBenchmarking
using Test

@testset "Test evaluate_individual method " begin
    chromosome = rand(2, 10)
    f_value = evaluate_chromosome(chromosome, BlackBoxOptimizationBenchmarking.F1)
    @test typeof(f_value) == Float64
end
