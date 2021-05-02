using Test

include("../../common/utilsModule.jl")
using .utilsModule

include("../../useCases/braveNewWorldModule.jl")
using .BraveNewWorldModule

@testset "Brave New World Module" begin
    config_parameters = utilsModule.read_parameters_file("./src/tests/common/data/config_file_1.json")

end

config_parameters = utilsModule.read_parameters_file("./src/tests/data/config_file_1.json")
file_path = "./src/data/royal_road.txt"
data = utilsModule.read_data_file(file_path, type=String)


points = utilsModule.convert_data_to_points(data)


Juno.@enter BraveNewWorldModule.fertilization_room(points, config_parameters.population_size)
