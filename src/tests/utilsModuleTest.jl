#=
utilsModule:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-07
=#
using DataFrames
using CSV

include("../../src/utilsModule.jl")
using .utilsModule

include("../individual/IndividualModule.jl")
using .IndividualModule

using Test

@testset "Utils Module" begin
    @testset "Test method when called then correct element in array returned" begin
        data = CSV.File("./src/tests/data/set_test.csv") |> DataFrame
        individual = utilsModule.convert_data_to_individual(data, IndividualModule.FeaturesArray)
        @test typeof(individual) == IndividualModule.Individual
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

    @testset "Test from_file_to_entity_individual when called then individual is returned" begin
        file_path = "./src/data/iris_set.csv"
        individual = utilsModule.from_file_to_entity_individual(file_path, IndividualModule.FeaturesArray, type=Float16, delimiter=',')

        @test typeof(individual) == IndividualModule.Individual
        @test typeof(individual.genes[1]) == IndividualModule.FeaturesArray
    end

end
