using BlackBoxOptimizationBenchmarking

struct ConfigurationParametersEntity
    chromosome_size::Int
    dimensions::Int
    population_size::Int
    max_evaluations::Int
    max_generations::Int
    castes_percentages::Dict
    step_size::Int
end

mutable struct PopulationModel
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
