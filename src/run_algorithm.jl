#using Pkg
# comment out Pkg.add() lines for speed once already added
# Pkg.add("DataFrames")
# Pkg.add("Compat")
# Pkg.add("Turf")
# Pkg.add("Shuffle")
# Pkg.add("StatsBase")
# Pkg.add("Mocking")
# Pkg.add("Parameters")
# Pkg.add("Distributions")
# Pkg.add("StaticLint")
# Pkg.add("SimpleMock")

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
