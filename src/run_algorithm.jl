using Pkg

# comment out Pkg.add() lines for speed once already added
# Pkg.add("DataFrames")
# Pkg.add("Compat")
# Pkg.add("Turf")
# Pkg.add("Shuffle")
# Pkg.add("StatsBase")
# Pkg.add("Mocking")
# Pkg.add("Parameters")

using BlackBoxOptimizationBenchmarking
using .IndividualPackagesModule

config_file_path = "./src/data/Config Files/config_file_1.json"
config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1

@info "Config file -> $(config_file_path), Fitness Funcion -> $(fitness_function)"
population_model = PopulationModel(config_parameters_entity, fitness_function)

poblation = run_algorithm(population_model)
