using JSON

const chromosome_size = "CHROMOSOME_SIZE"
const population_size = "POPULATION_SIZE"
const max_evaluations = "MAX_EVALUATIONS"
const max_generations = "MAX_GENERATIONS"
const population_percentage = "POPULATION_PERCENTAGE"
const alpha = "ALPHA"
const beta = "BETA"
const gamma = "GAMMA"
const delta = "DELTA"
const epsilon = "EPSILON"
const mutation_rate = "MUTATION_RATE"

function read_parameters_file(file_path::String)
    @info "Reading parameters file"
    config_parameters = JSON.parsefile(file_path)

    castes_percentages =
        Dict{String,Int}(
            alpha   => config_parameters[population_percentage][alpha],
            beta    => config_parameters[population_percentage][beta],
            gamma   => config_parameters[population_percentage][gamma],
            delta   => config_parameters[population_percentage][delta],
            epsilon => config_parameters[population_percentage][epsilon]
        )

    castes_mr =
        Dict{String,Int}(
            alpha   => config_parameters[mutation_rate][alpha],
            beta    => config_parameters[mutation_rate][beta],
            gamma   => config_parameters[mutation_rate][gamma],
            delta   => config_parameters[mutation_rate][delta],
            epsilon => config_parameters[mutation_rate][epsilon]
        )

    return ConfigurationParametersEntity(
        config_parameters[chromosome_size], config_parameters[population_size], 
        config_parameters[max_evaluations], config_parameters[max_generations], 
        castes_percentages, castes_mr)
end

function write_entry_to_summary(
        fitness_function,
        config_file, 
        outcome_file_name, 
        last_generation, 
        best_element, 
    )
    
    summary_path = "./data/Outcomes/summary.csv"
    summary_df = CSV.File(summary_path) |> DataFrame
    df_line = DataFrame(
        FUNCTION = "$(fitness_function)", 
        CONFIG_FILE_PATH = config_file,
        OUTCOME_FILE = outcome_file_name,
        GENERATION = last_generation,
        BEST_ELEMENT = best_element,
        F_OPT = fitness_function.f_opt
    )

    append!(summary_df, df_line)
    CSV.write(summary_path, summary_df)
end