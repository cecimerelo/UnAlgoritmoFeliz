using .BraveNewAlgorithm

using Test
using BlackBoxOptimizationBenchmarking

include("../commons.jl")

@testset "Test best_element_of_poblation when called then individual with smallest f value" begin
    config_file_path = "./data/Config Files/config_file_1_test.json"
    config_parameters_entity = read_parameters_file(config_file_path)
    fitness_function = BlackBoxOptimizationBenchmarking.F1
    population_model = PopulationModel(config_parameters_entity, fitness_function)
    population = [
        BraveNewAlgorithm.fertilising_room(population_model)
        for _ in 1:population_model.config_parameters.population_size
    ]

    best_element = best_element_of_population(population)

    all_f_values = [individual.f_value for individual in population]
    expected = minimum(all_f_values)

    @test expected == best_element.f_value
end