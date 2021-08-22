using BlackBoxOptimizationBenchmarking

struct ConfigurationParametersEntity
    chromosome_size::Int
    dimensions::Int
    population_size::Int
    max_evaluations::Int
    max_generations::Int
    castes_percentages::Dict{String, Int}
    mutation_rate::Dict{String, Int}
end

struct PopulationModel
    config_parameters::ConfigurationParametersEntity
    fitness_function::BBOBFunction
end

struct Embryo
    chromosome::Array
    f_value::Number
end

struct Individual
    chromosome::Array
    f_value::Number
    caste::Caste
end
