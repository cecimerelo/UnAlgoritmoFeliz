using .BraveNewAlgorithm

include("../../methods/from_genes_to_embryo.jl")
include("../../utils.jl")

using BlackBoxOptimizationBenchmarking
using Test


@testset "Test from_genes_to_individual method when called the individual created" begin
    config_file_path = "./src/test/Config Files/config_file_1_test.json"
    chromosome = rand(10,2)
    config_parameters_entity = read_parameters_file(config_file_path)
    fitness_function = BlackBoxOptimizationBenchmarking.F1
    population_model = PopulationModel(config_parameters_entity, fitness_function)

    individual = from_genes_to_embryo(chromosome, population_model)

    @test typeof(individual) == Embryo
    @test individual.f_value != 0
end
