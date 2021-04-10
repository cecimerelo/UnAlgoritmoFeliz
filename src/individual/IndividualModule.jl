module IndividualModule

export Individual, FeaturesArray, BinaryArray, Coordinates

struct Individual
    genes::Array
    f::Number
end

struct FeaturesArray
    features::Array
    label::Number
end

struct Coordinates
    coordinates::Array
    index:: Number
end

end  # module
