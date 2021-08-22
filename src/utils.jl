using JSON

const chromosome_size = "CHROMOSOME_SIZE"
const dimensions = "DIMENSIONS"
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
        Dict(
            alpha   => config_parameters[population_percentage][alpha],
            beta    => config_parameters[population_percentage][beta],
            gamma   => config_parameters[population_percentage][gamma],
            delta   => config_parameters[population_percentage][delta],
            epsilon => config_parameters[population_percentage][epsilon]
        )

    casts_mr =
        Dict(
            alpha   => config_parameters[mutation_rate][alpha],
            beta    => config_parameters[mutation_rate][beta],
            gamma   => config_parameters[mutation_rate][gamma],
            delta   => config_parameters[mutation_rate][delta],
            epsilon => config_parameters[mutation_rate][epsilon]
        )

    return ConfigurationParametersEntity(config_parameters[chromosome_size],
        config_parameters[dimensions], config_parameters[population_size],
        config_parameters[max_evaluations], config_parameters[max_generations],
        castes_percentages, casts_mr)
end
