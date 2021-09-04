using .BraveNewAlgorithm

include("../../utils.jl")
include("../../operators/crossover.jl")
include("../../operators/mutation.jl")
include("../../methods/fertilising_room.jl")

using Test
using BlackBoxOptimizationBenchmarking

config_file_path = "./src/test/Config Files/config_file_1_test.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1
range = (-5.12, 5.12)
minimum_comparator = comparator(element, fitness_function) = element >= fitness_function.f_opt
fitness_function = FitnessFunction(BlackBoxOptimizationBenchmarking.F1, 0)
population_model = PopulationModel(config_parameters_entity, fitness_function, range, minimum_comparator)
embryos = [
    fertilising_room(population_model)
    for _ in 1:population_model.config_parameters.population_size
]

parents = (
    Individual(embryos[1].chromosome, embryos[1].f_value, ALPHA()),
    Individual(embryos[2].chromosome, embryos[2].f_value, ALPHA())
)

offspring = crossover_operator(parents, config_parameters_entity)

@testset "Test mutation_operator when called then chromosome returned" begin
    mutated_offspring = mutation_operator(offspring, config_parameters_entity, ALPHA())

    @test typeof(mutated_offspring) == Array{Float64,1}
    @test eltype(mutated_offspring) == Float64
end