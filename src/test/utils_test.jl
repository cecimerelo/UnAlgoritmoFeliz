using .BraveNewAlgorithm
using BlackBoxOptimizationBenchmarking

include("../utils.jl")
include("../methods/fertilising_room.jl")

using Test

@testset "Utils Module Test" begin
    @testset "Test read_parameters_file when called then ConfigurationParametersEntity returned" begin
        config_file_path = "./src/test/Config Files/config_file_1_test.json"
        config_entity = read_parameters_file(config_file_path)

        @test typeof(config_entity) == ConfigurationParametersEntity
        @test typeof(config_entity.castes_percentages) == Dict{String, Int64}
    end
end

config_file = "./src/test/Config Files/config_file_1_test.json"
fitness_function = BlackBoxOptimizationBenchmarking.F2
range = (-5, 5)
config_file_path = "./data/Config Files/$(config_file).json"
config_parameters_entity = read_parameters_file(config_file)
minimum_comparator = comparator(element, fitness_function) = element >= fitness_function.f_opt
fitness_function = FitnessFunction(BlackBoxOptimizationBenchmarking.F1, 0)
population_model = PopulationModel(config_parameters_entity, fitness_function, range, minimum_comparator)

embryos = [
    fertilising_room(population_model)
    for _ in 1:population_model.config_parameters.population_size
]

all_chromosomes = [embryo.chromosome for embryo in embryos]
best_element = best_element_of_population(embryos)
@testset "Test calculate_edit_distance when called then Float returned" begin 
    distance = calculate_edit_distance(
                all_chromosomes, 
                best_element.chromosome, 
                population_model.config_parameters.population_size
            )

    @test typeof(distance) == Float64
end