using .BraveNewAlgorithm

include("../../utils.jl")
include("../../operators/crossover.jl")
include("../../operators/mutation.jl")

using Test
using BlackBoxOptimizationBenchmarking

config_file_path = "./data/Config Files/config_file_1_test.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1
population_model = PopulationModel(config_parameters_entity, fitness_function)

embryos = [
    BraveNewAlgorithm.fertilising_room(population_model)
    for _ in 1:population_model.config_parameters.population_size
]

parents = (
    Individual(embryos[1].chromosome, embryos[1].f_value, ALPHA()),
    Individual(embryos[2].chromosome, embryos[2].f_value, ALPHA())
)

offspring = crossover_operator(parents, config_parameters_entity)

@testset "Test mutation_operator when called then chromosome returned" begin
    mutated_offspring = mutation_operator(offspring, config_parameters_entity, ALPHA())

    @test typeof(mutated_offspring) == Array{Float64,2}
    @test eltype(mutated_offspring) == Float64
end