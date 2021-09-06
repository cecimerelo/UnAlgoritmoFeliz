using Pkg
Pkg.activate(".")

include("../src/BraveNewAlgorithm.jl")
using .BraveNewAlgorithm

include("../src/utils.jl")
include("../src/brave_new_algorithm.jl")

using BlackBoxOptimizationBenchmarking


config_file = ARGS[1]
fitness_function = FitnessFunction(BlackBoxOptimizationBenchmarking.F5, 0)
population_model = build_population_model(config_file, fitness_function)

result = @timed brave_new_algorithm(population_model)
last_generation, population = result[1][1], result[1][2]

outcome_file_name = write_results_to_file(config_file, fitness_function, population)
# build_results_plot(population, config_file, fitness_function)
write_entry_to_summary(
    fitness_function.calls_counter,
    result[2],
    outcome_file_name, 
    fitness_function.fitness_function, 
    config_file, 
    last_generation,
    population["F_Values"][last_generation]
)