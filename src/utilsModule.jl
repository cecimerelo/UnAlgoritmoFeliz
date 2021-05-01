#=
utils:
- Julia version:
- Author: cecimerelo
- Date: 2021-03-06
=#

module utilsModule

include("CustomTypes.jl")
using .CustomTypes

include("methods/build_genes.jl")

using JSON
using DataFrames
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

function from_file_to_genes(
    data_file_path, gene_type, element_type;
    delimiter=' ', has_header=false,
)

    df = read_data_file(
        data_file_path,
        type=element_type, has_header=has_header, delimiter=delimiter
    )

    genes = build_genes(df, gene_type)

    return genes
end

function read_data_file(
    file_path::String;
    type=nothing::DataType, has_header=false::Bool, delimiter=' '::Char
)

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
    @info "Reading parameters file"
    config_parameters = JSON.parsefile(file_path)

    ConfigurationParametersEntity(config_parameters[population_size],
        config_parameters[max_evaluations], config_parameters[max_generations],
        config_parameters[alpha_percentage], config_parameters[beta_percentage],
        config_parameters[gamma_percentage], config_parameters[delta_percentage],
        config_parameters[epsilon_percentage], config_parameters[step_size])
end

end
