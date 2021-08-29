using Pkg
Pkg.activate(".")

include("../src/brave_new_algorithm_module.jl")
using .BraveNewAlgorithmModule

include("../src/utils.jl")
include("../src/brave_new_algorithm.jl")

using BlackBoxOptimizationBenchmarking
using CSV
using StatsPlots
using Cairo
using Fontconfig
using Gadfly


config_file = "config_file_1"
config_file_path = "./data/Config Files/$(config_file).json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1

@info "Config file -> $(config_file_path), Fitness Funcion -> $(fitness_function), Range -> [-5.12, 5.12], f_opt -> $(fitness_function.f_opt)"
range = (-5.12, 5.12)
minimum_comparator = comparator(element, fitness_function) = element >= fitness_function.f_opt
population_model = PopulationModel(config_parameters_entity, fitness_function, range, minimum_comparator)
last_generation, population = brave_new_algorithm(population_model)

outcome_file_name = "$(config_file)_$(fitness_function)"
outcome_path = "./data/Outcomes/$(outcome_file_name)"
CSV.write("$(outcome_path).csv", population)

p = Gadfly.plot(population, x=:Generations, y=:F_Values, Geom.line);
img = PNG("$(outcome_file_name).png", 6inch, 4inch)
draw(img, p)

write_entry_to_summary(
    fitness_function, config_file,
    outcome_file_name, last_generation, population[1][last_generation]
)

