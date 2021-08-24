using .BraveNewAlgorithm

include("../utils.jl")

using Test

@testset "Utils Module Test" begin
    @testset "Test read_parameters_file when called then ConfigurationParametersEntity returned" begin
        config_file_path = "./src/test/Config Files/config_file_1_test.json"
        config_entity = read_parameters_file(config_file_path)

        @test typeof(config_entity) == ConfigurationParametersEntity
        @test typeof(config_entity.castes_percentages) == Dict{String, Int64}
    end
end
