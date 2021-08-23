include("BraveNewAlgorithm.jl")
using .BraveNewAlgorithm

using StaticLint
using BlackBoxOptimizationBenchmarking

include("utils.jl")
include("brave_new_algorithm.jl")

config_file_path = "./data/Config Files/config_file_1.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1

@info "Config file -> $(config_file_path), Fitness Funcion -> $(fitness_function)"
population_model = PopulationModel(config_parameters_entity, fitness_function)

poblation = brave_new_algorithm(population_model)
