include("../../methods/hatchery.jl")
include("../../brave_new_algorithm.jl")

using .IndividualPackagesModule
using StatsBase
using Test

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
        @test population_in_castes_sum == length(population)
    end

    @testset "Test when percentages sum 100" begin
        config_file_path = "./data/Config Files/config_file_2_test.json"
        @test_throws AssertionError("The percentages should have sum 100") run_hatchery(config_file_path)
    end

end

function run_hatchery(config_file_path)
    config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
    fitness_function = BlackBoxOptimizationBenchmarking.F1
    population_model = PopulationModel(config_parameters_entity, fitness_function)
    population = [
        fertilising_room(population_model)
        for _ in 1:population_model.config_parameters.population_size
    ]

    castes = hatchery(population_model, population)
end
