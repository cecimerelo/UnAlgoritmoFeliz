module IndividualModule

export Individual, FeaturesArray, Coordinates, ClassificationProblem, DistancesProblem

mutable struct FeaturesArray
    features::Array
    label::Int8
end

mutable struct Coordinates
    coordinates::Array
    index::Int8
end

abstract type Individual end

mutable struct ClassificationProblem <: Individual
    points_divided_in_clusters::Dict
    centroids::Array
    genes::Array{FeaturesArray,1}
    f::Number
    k::Int8
end

mutable struct DistancesProblem <: Individual
    genes::Coordinates
    f::Number
end

end  # module
