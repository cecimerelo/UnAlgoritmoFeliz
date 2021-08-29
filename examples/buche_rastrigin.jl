using Pkg
Pkg.activate(".")

include("../src/brave_new_algorithm_module.jl")
using .BraveNewAlgorithmModule

include("../src/utils.jl")
include("../src/brave_new_algorithm.jl")

using BlackBoxOptimizationBenchmarking


config_file = ARGS[1]
fitness_function = BlackBoxOptimizationBenchmarking.F4
population_model = build_population_model(config_file, fitness_function)

last_generation, population = brave_new_algorithm(population_model)

write_results_to_file(config_file, fitness_function, population)
build_results_plot(population, config_file, fitness_function)
write_entry_to_summary(
    fitness_function, config_file, last_generation, population[1][last_generation]
)