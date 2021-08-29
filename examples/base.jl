using Pkg
Pkg.activate(".")

include("../src/brave_new_algorithm_module.jl")
using .BraveNewAlgorithmModule

include("../src/utils.jl")
include("../src/brave_new_algorithm.jl")

using BlackBoxOptimizationBenchmarking


config_file_path = "./data/config_file_1.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1

@info "Config file -> $(config_file_path), Fitness Funcion -> $(fitness_function), Range -> [-5.12, 5.12], f_opt -> $(fitness_function.f_opt)"
range = (-5.12, 5.12)

minimum_comparator = comparator(element, fitness_function) = element >= fitness_function.f_opt

population_model = PopulationModel(config_parameters_entity, fitness_function, range, minimum_comparator)
poblation = brave_new_algorithm(population_model)
