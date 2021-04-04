#=
ConfigEntity:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-06
=#

module CustomTypes

export ConfigurationParametersEntity, Point
struct ConfigurationParametersEntity
    population_size::Int
    max_evaluations::Int
    max_generations::Int
    alpha::Int
    beta::Int
    gamma::Int
    delta::Int
    epsilon::Int
    step_size::Int
end

struct Point
    features::Array
    label::Integer
end

struct Individual
    list_of_points::Point[]
    f_value::Float32
end

end
