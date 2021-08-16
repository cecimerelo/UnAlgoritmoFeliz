include("../../methods/from_genes_to_embryo.jl")
using ..IndividualPackagesModule

using BlackBoxOptimizationBenchmarking
using Test


@testset "Test from_genes_to_individual method when called the individual created" begin
    config_file_path = "./src/data/Config Files/config_file_1.json"
    chromosome = rand(10,2)
    config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
    fitness_function = BlackBoxOptimizationBenchmarking.F1
    population_model = PopulationModel(config_parameters_entity, fitness_function)

    individual = from_genes_to_embryo(chromosome, population_model)

    @test typeof(individual) == Individual
    @test individual.f_value != 0
end
