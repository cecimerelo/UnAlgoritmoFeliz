#=
utils:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-06
=#

module utilsModule

using JSON
using DataFrames

using Pkg

using CSV

using ..IndividualModule

const population_size = "POPULATION_SIZE"
const max_evaluations = "MAX_EVALUATIONS"
const max_generations = "MAX_GENERATIONS"
const alpha_percentage = "ALPHA_PERCENTAGE"
const beta_percentage = "BETA_PERCENTAGE"
const gamma_percentage = "GAMMA_PERCENTAGE"
const delta_percentage = "DELTA_PERCENTAGE"
const epsilon_percentage = "EPSILON_PERCENTAGE"
const step_size = "STEP_SIZE"

function from_file_to_entity_individual(file_path::String, individual::DataType;
    type=String::DataType, has_header=false::Bool, delimiter=' '::Char)

    df = read_data_file(file_path, type=type, has_header=has_header, delimiter=delimiter)
    points = convert_data_to_individual(df, individual)

    return points
end

function read_data_file(file_path::String; type=nothing::DataType,
    has_header=false::Bool, delimiter=' '::Char)

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

function convert_data_to_individual(data::DataFrames.DataFrame, gene_type::Type{FeaturesArray})
    genes = gene_type[]
    number_of_rows = size(data, 1)

    @info "Converting data to $(number_of_rows) individual"
    for row in eachrow(data)
        gene = gene_type(row, -1)
        push!(genes, gene)
    end

    return Individual(genes, 0)
end

function convert_data_to_individual(data::DataFrames.DataFrame, gene_type::Type{Coordinates})
    genes = Coordinates[]
    number_of_rows = size(data, 1)

    @info "Converting data to $(number_of_rows) individual"
    for row in eachrow(data)
        gene = Coordinates(row[2:end], row[1])
        push!(genes, gene)
    end

    return Individual(genes, 0)
end


function read_parameters_file(file_path::String)
    config_parameters = JSON.parsefile(file_path)

    ConfigurationParametersEntity(config_parameters[population_size],
        config_parameters[max_evaluations], config_parameters[max_generations],
        config_parameters[alpha_percentage], config_parameters[beta_percentage],
        config_parameters[gamma_percentage], config_parameters[delta_percentage],
        config_parameters[epsilon_percentage], config_parameters[step_size])
end

end
