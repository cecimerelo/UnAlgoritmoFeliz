using .BraveNewAlgorithm

include("../../commons.jl")
include("../../operators/crossover.jl")

using Test

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

offspring = crossover_operator(parents, population_model.config_parameters)