using .BraveNewAlgorithmModule
using BlackBoxOptimizationBenchmarking

include("../../utils.jl")
include("../../operators/crossover.jl")

using Test

config_file_path = "./src/test/Config Files/config_file_1_test.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1
population_model = PopulationModel(config_parameters_entity, fitness_function)

embryos = [
    BraveNewAlgorithmModule.fertilising_room(population_model)
    for _ in 1:population_model.config_parameters.population_size
]

parents = (
    Individual(embryos[1].chromosome, embryos[1].f_value, ALPHA()),
    Individual(embryos[2].chromosome, embryos[2].f_value, ALPHA())
)

@testset "Test crossover_operator when called the new chromosome returned" begin
    offspring = crossover_operator(parents, population_model.config_parameters)

    @test typeof(offspring) == Array{Float64,1}
    @test eltype(offspring) == Float64
end
