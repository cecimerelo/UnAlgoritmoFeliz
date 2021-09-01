using BlackBoxOptimizationBenchmarking

struct ConfigurationParametersEntity
    chromosome_size::Int
    population_size::Int
    max_generations::Int
    castes_percentages::Dict{String, Int}
    mutation_rate::Dict{String, Int}
end

struct PopulationModel
    config_parameters::ConfigurationParametersEntity
    fitness_function::BBOBFunction
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
