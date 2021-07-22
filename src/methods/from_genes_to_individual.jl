include("../commons.jl")
include("evaluate_individual.jl")

using Shuffle

function from_genes_to_individual(
    genes, fitness_function, individual_type::Type{ClassificationProblem};
    k=3
)
    points_divided_in_clusters = build_dict_of_clusters(k)
    genes_copy = deepcopy(genes)
    cluster_options = Int8[cluster for cluster in 1:k]

    for point in genes_copy
        point.label = rand(collect(cluster_options))
        push!(points_divided_in_clusters[point.label], point)
    end

    centroids = calculate_centroids(points_divided_in_clusters)
    # TODO : add an f
    f = evaluate_individual(genes)

    return ClassificationProblem(
        points_divided_in_clusters, centroids, genes, f, k
    )
end


function from_genes_to_individual(genes, individual_type::Type{DistancesProblem})
    genes_copy = deepcopy(genes)
    genes_copy = shuffle!(genes_copy)

    # TODO : add an f
    f =  evaluate_individual(genes)

    return DistancesProblem(genes, f, genes_copy)
end
