#=
utilsModule:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-07
=#

include("../../common/utilsModule.jl")
using .utilsModule

using Test

@testset "Utils Module" begin
    @testset "Test method when called then an entity is created" begin
        config_parameters_entity = utilsModule.ConfigurationParametersEntity(70, 10000, 15, 20, 20, 20, 20, 20, 2)
        @test utilsModule.read_parameters_file("./src/tests/data/config_file_1.json") == config_parameters_entity
    end

    @testset "Test method when called then correct element in array returned" begin
        data = CSV.File("./src/tests/data/set_test.csv") |> DataFrame
        extraxted_points = utilsModule.convert_data_to_points(data)
        @test eltype(extraxted_points) == utilsModule.Point
    end

    @testset "Test read data file when called with a *.txt file then convert it to DataFrame" begin
        file_path = "./src/data/royal_road.txt"
        data = utilsModule.read_data_file(file_path, type=String)
        @test typeof(data) == DataFrame
    end

    @testset "Test read data file when called with a *.* file then convert it to DataFrame" begin
        file_path = "./src/data/a280.tsp"
        data = utilsModule.read_data_file(file_path, type=Int32, has_header=true)
        @test typeof(data) == DataFrame
    end
end
