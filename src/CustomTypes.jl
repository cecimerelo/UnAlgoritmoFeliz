#=
ConfigEntity:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-06
=#

module CustomTypes

export ConfigurationParametersEntity, Point, Individual
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
end
