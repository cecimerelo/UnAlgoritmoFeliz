include("../../individual/IndividualModule.jl")
using .IndividualModule

include("../../utilsModule.jl")
using .utilsModule

include("../../methods/from_genes_to_individual.jl")

using Test

@testset "Test from_genes_to_individual method " begin
    @testset "Test from_genes_to_individual method for Classification problems" begin
        file_path = "./src/test/data/set_test.csv"
        genes = utilsModule.from_file_to_genes(file_path, FeaturesArray,
                                                    Float16;
                                                    delimiter=',')
        individual = from_genes_to_individual(genes, ClassificationProblem)

        @test typeof(individual) == ClassificationProblem
        @test typeof(individual.genes[1]) == FeaturesArray
    end

    @testset "Test from_genes_to_individual method for Distances problems" begin
        file_path = "./src/test/data/coordinates_test.csv"
        genes = utilsModule.from_file_to_genes(file_path, Coordinates,
                                                    Int128;
                                                    delimiter=' ', has_header=true)
        individual = from_genes_to_individual(genes, DistancesProblem)

        @test typeof(individual) == DistancesProblem
        @test typeof(individual.genes[1]) == Coordinates
    end
end
