using BlackBoxOptimizationBenchmarking

struct ConfigurationParametersEntity
    chromosome_size::Int
    population_size::Int
    max_generations::Int
    castes_percentages::Dict{String, Int}
    mutation_rate::Dict{String, Int}
end

mutable struct FitnessFunction
    fitness_function::BBOBFunction
    calls_counter::Int64
end

struct PopulationModel
    config_parameters::ConfigurationParametersEntity
    fitness_function::FitnessFunction
    range::Tuple{Float64,Float64}
    comparator::Function
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
