include("../../methods/hatchery.jl")
include("../../brave_new_algorithm.jl")

using .IndividualPackagesModule
using StatsBase
using Test

POPULATION_SIZE_MISMATCHED = "The population divided in castes does not match the length of the initial population"

function run_hatchery(config_file_path)
    config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
    fitness_function = BlackBoxOptimizationBenchmarking.F1
    population_model = PopulationModel(config_parameters_entity, fitness_function)
    population = [
        fertilising_room(population_model)
        for _ in 1:population_model.config_parameters.population_size
    ]
    castes = hatchery(population_model, population)
    return castes
end

@testset "Test hatchery when called then returns population divided in castes" begin
    @testset "Test when percentages sum 100" begin
        config_file_path = "./data/Config Files/config_file_1_test.json"
        castes = run_hatchery(config_file_path)
        castes_keys = keys(castes)

        @test "ALPHA" in castes_keys
        @test "BETA" in castes_keys
        @test "GAMMA" in castes_keys
        @test "DELTA" in castes_keys
        @test "EPSILON" in castes_keys

        population_in_castes = [length(caste_population) for (caste, caste_population) in castes]
        population_in_castes_sum = sum(population_in_castes)
        config_parameters_entity = utilsModule.read_parameters_file(config_file_path)

        @test population_in_castes_sum == config_parameters_entity.population_size
    end

    @testset "Test when percentages sum 100" begin
        config_file_path = "./data/Config Files/config_file_2_test.json"
        @test_throws AssertionError("The percentages should have sum 100") run_hatchery(config_file_path)
    end

    @testset "Test population size is asserted correctly" begin
        config_file_path = "./data/Config Files/config_file_1_test.json"
        config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
        fitness_function = BlackBoxOptimizationBenchmarking.F1
        population_model = PopulationModel(config_parameters_entity, fitness_function)
        population = [
            fertilising_room(population_model)
            for _ in 1:population_model.config_parameters.population_size
        ]
        castes = Dict("ALPHA" => [population[1], population[2]])
        @test_throws AssertionError(POPULATION_SIZE_MISMATCHED) assert_population_divided_in_castes_match_initial_population_size(castes, 10)
    end
end
