include("../commons.jl")

include("../individual/IndividualModule.jl")
using .IndividualModule

using Test

@testset "Methods in commons test" begin
    @testset "Test build_dict_of_clusters when called then dict is returned" begin
        dict_of_clusters = build_dict_of_clusters(3)

        @test eltype(dict_of_clusters) == Pair{Any, Any}
        @test typeof(dict_of_clusters) == Dict{Any, Any}
    end

    @testset "Test calculate_centroids when called then centroids are build" begin
        points_divided_in_clusters = Dict(
            2 => Any[FeaturesArray(Float16[5.5, 2.5, 4.0, 1.3], 2),
            FeaturesArray(Float16[6.8, 3.2, 5.9, 2.3], 2)],
            3 => Any[FeaturesArray(Float16[6.1, 2.8, 4.7, 1.2], 3),
            FeaturesArray(Float16[7.2, 3.0, 5.8, 1.6], 3)],
            1 => Any[FeaturesArray(Float16[4.6, 3.2, 1.4, 0.2], 1),
            FeaturesArray(Float16[6.4, 2.9, 4.3, 1.3], 1)]
        )

        centroids = calculate_centroids(points_divided_in_clusters)

        @test length(centroids) == 3
    end

    @testset "Test cluster_without_points when called then empty cluster is returned" begin
        points_divided_in_clusters = Dict(
            2 => Any[],
            3 => Any[FeaturesArray(Float16[6.1, 2.8, 4.7, 1.2], 3),
            FeaturesArray(Float16[7.2, 3.0, 5.8, 1.6], 3)],
            1 => Any[FeaturesArray(Float16[4.6, 3.2, 1.4, 0.2], 1),
            FeaturesArray(Float16[6.4, 2.9, 4.3, 1.3], 1)]
        )

        empty_cluster = cluster_without_points(points_divided_in_clusters, 3)

        @test empty_cluster >= 0
    end

    @testset "Test cluster_without_points when called then no empty cluster is returned" begin
        points_divided_in_clusters = Dict(
            2 => Any[FeaturesArray(Float16[5.5, 2.5, 4.0, 1.3], 2),
            FeaturesArray(Float16[6.8, 3.2, 5.9, 2.3], 2)],
            3 => Any[FeaturesArray(Float16[6.1, 2.8, 4.7, 1.2], 3),
            FeaturesArray(Float16[7.2, 3.0, 5.8, 1.6], 3)],
            1 => Any[FeaturesArray(Float16[4.6, 3.2, 1.4, 0.2], 1),
            FeaturesArray(Float16[6.4, 2.9, 4.3, 1.3], 1)]
        )
        empty_cluster = cluster_without_points(points_divided_in_clusters, 3)

        @test empty_cluster == 0
    end

    @testset "Test fix_clusters when called then dict of clusters is fixed" begin
        points_divided_in_clusters = Dict(
            2 => Any[],
            3 => Any[FeaturesArray(Float16[6.1, 2.8, 4.7, 1.2], 3),
            FeaturesArray(Float16[7.2, 3.0, 5.8, 1.6], 3)],
            1 => Any[FeaturesArray(Float16[4.6, 3.2, 1.4, 0.2], 1),
            FeaturesArray(Float16[6.4, 2.9, 4.3, 1.3], 1)]
        )
        fix_clusters(points_divided_in_clusters, 2, 3)

        @test isempty(points_divided_in_clusters[2]) == false
    end

    @testset "Test best_element_of_poblation when called then individual with smallest f value" begin
        config_file_path = "./src/test/Config Files/config_file_1.json"
        config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
        fitness_function = BlackBoxOptimizationBenchmarking.F1
        population_model = PopulationModel(config_parameters_entity, fitness_function)
        poblation = run_algorithm(population_model)

        best_element = best_element_of_poblation(poblation)

        all_f_values = [individual.f_value for individual in poblation]
        expected = minimum(all_f_values)

        @test expected == best_element.f_value
    end

end
