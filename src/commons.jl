using Turf

function build_dict_of_clusters(k)
    dict_of_clusters = Dict()

    for i in 1:k
        dict_of_clusters[i] = []
    end

    return dict_of_clusters
end

function calculate_centroids(points_divided_in_clusters)
    centroids = []
    centroid_coordinates = []

    for k in keys(points_divided_in_clusters)
        points = points_divided_in_clusters[k]
        features_list = [point.features for point in points]
        line =  LineString(features_list)
        centroid_coordinates = centroid(line).coordinates
        push!(centroids, centroid_coordinates)
    end

    return centroids
end

function cluster_without_points(points_divided_in_clusters, k)
    for (cluster, points_in_cluster) in points_divided_in_clusters
        if isempty(points_in_cluster)
            return cluster
        end
    end

    return 0
end

function fix_clusters(points_divided_in_clusters, empty_cluster, k)
    cluster_options = Int8[cluster for cluster in 1:k]
    delete_element_from_array(cluster_options, empty_cluster)

    random_cluster = rand(cluster_options)
    random_point = rand(points_divided_in_clusters[random_cluster])
    delete_element_from_array(points_divided_in_clusters[random_cluster], random_point)

    random_point.label = empty_cluster
    push!(points_divided_in_clusters[empty_cluster], random_point)
end

function delete_element_from_array(array, elements)
    for element in elements
        deleteat!(array, findall(x->x==element,array))
    end
end

function best_element_of_population(population)
    return partialsort(population, 1, by = t -> t.f_value, lt=isless)
end
