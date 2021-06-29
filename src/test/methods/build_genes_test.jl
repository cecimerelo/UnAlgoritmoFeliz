using CSV
using DataFrames
using Test

include("../../individual/IndividualModule.jl")
using .IndividualModule

include("../../methods/build_genes.jl")

@testset "build_genes Method Test" begin

    @testset "Test build_genes when called then genes are returned" begin
        data_path = "./src/test/data/set_test.csv"
        df = CSV.File(data_path) |> DataFrame
        genes = build_genes(df, FeaturesArray)

        @test eltype(genes) == FeaturesArray
    end

    @testset "Test build_genes when called with coordinates then genes are returned" begin
        data_path = "./src/test/data/coordinates_test.csv"
        df = CSV.File(data_path) |> DataFrame
        genes = build_genes(df, Coordinates)

        @test eltype(genes) == Coordinates
    end

end
