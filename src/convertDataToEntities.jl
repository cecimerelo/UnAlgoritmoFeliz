using Pkg

# comment out Pkg.add() lines for speed once already added
# Pkg.add("CSV")
# Pkg.add("DataFrames")

include("CustomTypes.jl")

include("individual/IndividualModule.jl")
using .IndividualModule

include("utilsModule.jl")
using .utilsModule

file_path = "./src/data/iris_set.csv"
individual = utilsModule.from_file_to_entity_individual(file_path, FeaturesArray, type=Float16, delimiter=',')

file_path = "./src/data/royal_road.txt"
extracted_points = utilsModule.from_file_to_entity_individual(file_path, FeaturesArray, type=String)

file_path = "./src/data/a280.tsp"
extracted_points = utilsModule.from_file_to_entity_individual(file_path, Coordinates, type=Int16, has_header=true)
