using Test

include("../../individual/IndividualModule.jl")
using .IndividualModule

include("../../methods/build_random_individual.jl")

@testset "Test build_random_individual method " begin

  @testset "Test build_random_individual when called then ClassificationProblem individual is returned " begin
    points_divided_in_clusters = Dict(
      2 => Any[FeaturesArray(Float16[6.1, 2.8, 4.7, 1.2], 2), FeaturesArray(Float16[7.2, 3.0, 5.8, 1.6], 2)],
      3 => Any[FeaturesArray(Float16[4.6, 3.2, 1.4, 0.2], 3), FeaturesArray(Float16[6.4, 2.9, 4.3, 1.3], 3)],
      1 => Any[FeaturesArray(Float16[5.8, 2.7, 4.1, 1.0], 1), FeaturesArray(Float16[6.8, 3.2, 5.9, 2.3], 1)]
      )
    centroids = [
      [5.840369591346154, 3.0634765625]
      [5.956724877450981, 3.1118642769607843]
      [5.723404255319149, 2.991439494680851]
    ]

    genes = [
      FeaturesArray(Float16[6.1, 2.8, 4.7, 1.2], 2), FeaturesArray(Float16[7.2, 3.0, 5.8, 1.6], 2),
      FeaturesArray(Float16[4.6, 3.2, 1.4, 0.2], 3), FeaturesArray(Float16[6.4, 2.9, 4.3, 1.3], 3),
      FeaturesArray(Float16[5.8, 2.7, 4.1, 1.0], 1), FeaturesArray(Float16[6.8, 3.2, 5.9, 2.3], 1)
    ]

    individual = ClassificationProblem(points_divided_in_clusters, centroids, genes, -1, 3)
    random_individual = build_random_individual(individual)

    @test typeof(random_individual) == ClassificationProblem
    @test random_individual.centroids[1] != individual.centroids[1]
  end

  @testset "Test build_random_individual when called then DistancesProblem individual is returned " begin
    genes = [
      Coordinates(Int128[288, 149], 1), Coordinates(Int128[288, 129], 2),
      Coordinates(Int128[270, 133], 3), Coordinates(Int128[256, 141], 4)
    ]

    route = [
      Coordinates(Int128[270, 133], 3), Coordinates(Int128[256, 141], 4),
      Coordinates(Int128[288, 149], 1), Coordinates(Int128[288, 129], 2)
    ]

    individual = DistancesProblem(genes, -1, route)
    random_individual = build_random_individual(individual)

    @test typeof(random_individual) == DistancesProblem
  end

end
