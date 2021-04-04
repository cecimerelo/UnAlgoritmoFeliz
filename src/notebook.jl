#=
notebook:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-01
=#

using Pkg

# comment out Pkg.add() lines for speed once already added
Pkg.add("CSV")
Pkg.add("DataFrames")

using CSV
using DataFrames

include("../common/CustomTypes.jl")
include("../common/utilsModule.jl")
using .utilsModule

include("../useCases/braveNewWorldModule.jl")
using .BraveNewWorldModule


DATA = utilsModule.read_data_file("./src/data/iris_set.csv", delimiter=',') |> DataFrame
K = 3

# config_file_path = "src/data/Config Files/config_file_$(n).json"
config_file_path = "src/data/Config Files/config_file_1.json"
config_parameters_entity = utilsModule.read_parameters_file(config_file_path)

un_mundo_feliz = BraveNewWorldModule.run(DATA, K, config_parameters_entity, 1)
