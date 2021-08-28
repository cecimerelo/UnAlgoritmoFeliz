using .BraveNewAlgorithmModule

using Test
using BlackBoxOptimizationBenchmarking

include("../../methods/fertilising_room.jl")
include("../../methods/local_search.jl")
include("../../methods/from_genes_to_embryo.jl")
include("../../utils.jl")


config_file_path = "./src/test/Config Files/config_file_1_test.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1
range = (-5.12, 5.12)
population_model = PopulationModel(config_parameters_entity, fitness_function, range)
embryo = fertilising_room(population_model)
new_chromosome = local_search(embryo.chromosome, population_model, GAMMA())

@testset "Test local_search when called for GAMMA then improved chromosome returned" begin
    new_chromosome = local_search(embryo.chromosome, population_model, GAMMA())
    @test typeof(new_chromosome) == Array{Float64,1}

    new_embryo = from_genes_to_embryo(new_chromosome, population_model)
    @test new_embryo.f_value <= embryo.f_value
end

@testset "Test local_search when called for not GAMMA then same chromosome returned" begin
    new_chromosome = local_search(embryo.chromosome, population_model, ALPHA())
    @test new_chromosome == embryo.chromosome
end