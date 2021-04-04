#=
utils:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-06
=#

module utilsModule

using JSON;
using DataFrames;
using DataFrames

using Pkg
Pkg.add("IndexedTables")
using IndexedTables
using CSV
using ..CustomTypes

const population_size = "POPULATION_SIZE"
const max_evaluations = "MAX_EVALUATIONS"
const max_generations = "MAX_GENERATIONS"
const alpha_percentage = "ALPHA_PERCENTAGE"
const beta_percentage = "BETA_PERCENTAGE"
const gamma_percentage = "GAMMA_PERCENTAGE"
const delta_percentage = "DELTA_PERCENTAGE"
const epsilon_percentage = "EPSILON_PERCENTAGE"
const step_size = "STEP_SIZE"

export read_parameters_file

function read_data_file(file_path::String; type=nothing, has_header=false::Bool,
    delimiter=' '::Char)

    @info "Reading data file $(file_path)"
    raw_str = read(file_path, String)
    io = IOBuffer(raw_str)
    df = CSV.File(io,
                   delim=delimiter,
                   type=type,
                   header=has_header,
                   ignorerepeated=true,
                   missingstring="NA") |> DataFrame

    return df
end

function read_parameters_file(file_path::String)
    config_parameters = JSON.parsefile(file_path)

    ConfigurationParametersEntity(config_parameters[population_size],
        config_parameters[max_evaluations], config_parameters[max_generations],
        config_parameters[alpha_percentage], config_parameters[beta_percentage],
        config_parameters[gamma_percentage], config_parameters[delta_percentage],
        config_parameters[epsilon_percentage], config_parameters[step_size])
end

function convert_data_to_points(data::DataFrame)
    number_of_rows = size(data, 1)

    @info "Converting data to $(number_of_rows) points"
    for row in eachrow(data)
        point = Point(row, -1)
        push!(points, point)
    end

    return points
end

function build_array_of_points(row)
end
