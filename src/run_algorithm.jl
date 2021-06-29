using Pkg

# comment out Pkg.add() lines for speed once already added
# Pkg.add("DataFrames")
# Pkg.add("Compat")
# Pkg.add("Turf")
# Pkg.add("Shuffle")

include("individual/IndividualModule.jl")
using .IndividualModule

include("utilsModule.jl")
include("SetUpData.jl")
include("brave_new_algorithm.jl")

config_file_path = "./src/data/Config Files/config_file_1.json"
data_file_path = "./src/data/iris_set.csv"

initial_individual = prepare_individual(
    ClassificationProblem, data_file_path, FeaturesArray, Float16;
    k=3
)

run_algorithm(config_file_path, data_file_path, initial_individual)

###########
# For TSP

config_file_path = "./src/data/Config Files/config_file_1.json"
data_file_path = "./src/data/a280.tsp"

initial_individual = prepare_individual(
    DistancesProblem, data_file_path, Coordinates, Int128;
    delimiter=" ", has_header=true
)

run_algorithm(config_file_path, data_file_path, initial_individual)
