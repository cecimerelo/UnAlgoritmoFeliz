function build_random_individual(individual::ClassificationProblem)
    genes = deepcopy(individual.genes)
    new_individual = from_genes_to_individual(genes, typeof(individual))
    empty_cluster = cluster_without_points(
                        new_individual.points_divided_in_clusters,
                        individual.k
                    )

    if  empty_cluster > 0
        @warn "Fixing empty cluster"
        fix_clusters(new_individual.points_divided_in_clusters,
            empty_cluster, individual.k
        )
    end

    return new_individual
end

function build_random_individual(individual::DistancesProblem)
    genes = deepcopy(individual.genes)
    new_individual = from_genes_to_individual(genes, typeof(individual))

    return new_individual
end
