using JSON
using Gadfly
using CSV
using StatsPlots
using Cairo
using Fontconfig
using Dates

const chromosome_size = "CHROMOSOME_SIZE"
const population_size = "POPULATION_SIZE"
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
        config_parameters[max_generations], castes_percentages, castes_mr)
end

function write_entry_to_summary(
        fitness_function,
        config_file, 
        last_generation, 
        best_element, 
    )
    outcome_file_name = "$(config_file)_$(fitness_function)"
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

function build_population_model(config_file, fitness_function)
    range = (-5, 5)
    config_file_path = "./data/Config Files/$(config_file).json"
    config_parameters_entity = read_parameters_file(config_file_path)
    minimum_comparator = comparator(element, fitness_function) = element >= fitness_function.f_opt
    @info "Config file -> $(config_file_path), Fitness Funcion -> $(fitness_function), Range -> $(range), f_opt -> $(fitness_function.f_opt)"
    return PopulationModel(config_parameters_entity, fitness_function, range, minimum_comparator)
end

function write_results_to_file(config_file, fitness_function, population)
    outcome_file_name = "$(config_file)_$(fitness_function)"
    outcome_path = "./data/Outcomes/$(outcome_file_name)"
    time = Dates.format(now(), "HH:MM")
    CSV.write("$(outcome_path)_$(time).csv", population)
end

function build_results_plot(population, config_file, fitness_function)
    outcome_file_name = "$(config_file)_$(fitness_function)"
    p = Gadfly.plot(
        population, 
        x=:Generations, y=:F_Values, 
        Geom.line, Guide.title(outcome_file_name), 
        Guide.manual_color_key("Legend", ["Fitness values"])
    );
    img = PNG("./data/Plots/$(outcome_file_name)_$(time).png", 6inch, 4inch)
    draw(img, p);
end

function calculate_entropy(points)
    
end