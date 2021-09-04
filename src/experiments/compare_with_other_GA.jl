using Pkg
Pkg.activate(".")

include("../BraveNewAlgorithm.jl")
using .BraveNewAlgorithm
using GeneticAlgorithms
using BlackBoxOptimizationBenchmarking

include("equalityga.jl")
include("../utils.jl")

config_file = "config_file_5"
fitness_function = FitnessFunction(BlackBoxOptimizationBenchmarking.F3, 0)
population_model = build_population_model(config_file, fitness_function)

model = runga(equalityga; initial_pop_size = population_model.config_parameters.population_size)
population(model)