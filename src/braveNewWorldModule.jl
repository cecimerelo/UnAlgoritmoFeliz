module BraveNewWorldModule

using DataFrames
using ..CustomTypes
using ..utilsModule

function run_algorithm(data::DataFrame,
    config_parameters_entity::ConfigurationParametersEntity;
    k=0::Integer, ejecutions=0::Int64)

    points = utilsModule.convert_data_to_points(data)
    initial_poblation = fertilization_room(points, config_parameters_entity.population_size)

end

function fertilization_room(points::Array, population_size::Integer)
    poblation = Point[build_random_solution(points) for x in 1:population_size]
end

function build_random_solution(points::Point[])
    body
end

end
