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

@testset "Utils Module Test" begin
    @testset "Test method when called then correct element in array returned" begin
        file_path = "./src/test/data/set_test.csv"
        genes = utilsModule.from_file_to_genes(file_path, FeaturesArray,
                                                    Float16;
                                                    delimiter=',')
        @test eltype(genes) == FeaturesArray
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
