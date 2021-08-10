using Pkg

# comment out Pkg.add() lines for speed once already added
# Pkg.add("DataFrames")
# Pkg.add("Compat")
# Pkg.add("Turf")
# Pkg.add("Shuffle")

using BlackBoxOptimizationBenchmarking

include("individual_packages_module.jl")
using .IndividualPackagesModule

include("brave_new_algorithm.jl")
include("utilsModule.jl")

config_file_path = "./src/data/Config Files/config_file_1.json"
config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1

@info "Config file -> $(config_file_path), Fitness Funcion -> $(fitness_function)"
population_model = PopulationModel(config_parameters_entity, fitness_function)

run_algorithm(population_model)
