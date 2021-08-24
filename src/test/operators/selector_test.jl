using .BraveNewAlgorithmModule

include("../../commons.jl")
include("../../operators/selector.jl")

using Test

config_file_path = "./src/test/Config Files/config_file_1_test.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1
population_model = PopulationModel(config_parameters_entity, fitness_function)
embryos = [
    BraveNewAlgorithmModule.fertilising_room(population_model)
    for _ in 1:population_model.config_parameters.population_size
]

castes = hatchery(population_model, embryos)

@testset "Test selector_operator when called then reproduction pool is returned" begin
    @testset "Test selector_operator for ALPHA caste" begin
        reproduction_pool = selector_operator(ALPHA(), castes[ALPHA()])

        @test eltype(reproduction_pool) == Tuple
        @test eltype(reproduction_pool[1]) == Individual

        total_length = [length(tuple) for tuple in reproduction_pool]
        sum_total_length = sum(total_length)
        @test sum_total_length == length(castes[ALPHA()])
    end

    @testset "Test selector_operator for BETA caste" begin
        reproduction_pool = selector_operator(ALPHA(), castes[ALPHA()])
        beta_reproduction_pool = selector_operator(BETA(), castes[BETA()], reproduction_pool)

        @test eltype(beta_reproduction_pool) == Tuple
        @test beta_reproduction_pool[1][1].caste == ALPHA()
        @test beta_reproduction_pool[1][2].caste == BETA()

        total_length = [length(tuple) for tuple in reproduction_pool]
        sum_total_length = sum(total_length)
        @test sum_total_length == length(castes[ALPHA()])
    end

    @testset "Test selector_operator for lower castes" begin
        @test_logs (:info,"Lower caste, selection not applied") selector_operator(GAMMA(), castes[GAMMA()])
        @test_logs (:info,"Lower caste, selection not applied") selector_operator(DELTA(), castes[DELTA()])
        @test_logs (:info,"Lower caste, selection not applied") selector_operator(EPSILON(), castes[EPSILON()])
    end

end
