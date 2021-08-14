#=
utilsModule:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-07
=#

using .utilsModule
using .IndividualPackagesModule

using Test

@testset "Utils Module Test" begin
    @testset "Test read_parameters_file when called then ConfigurationParametersEntity returned" begin
        config_file_path = "./data/Config Files/config_file_1_test.json"
        config_entity = utilsModule.read_parameters_file(config_file_path)

        @test typeof(config_entity) == ConfigurationParametersEntity
        @test typeof(config_entity.castes_percentages) == Dict{String, Int64}
    end
end
