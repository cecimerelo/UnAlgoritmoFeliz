module equalityga

import Base.isless

using GeneticAlgorithms, BlackBoxOptimizationBenchmarking

using Distributions
include("../brave_new_algorithm_module.jl")
using .BraveNewAlgorithmModule
include("../utils.jl")

config_file = "config_file_5"
fitness_function = FitnessFunction(BlackBoxOptimizationBenchmarking.F3, 0)
population_model = build_population_model(config_file, fitness_function)

mutable struct EqualityMonster <: Entity
    abcde::Array
    fitness

    EqualityMonster() = new(Array{Int, 5}[], nothing)
    EqualityMonster(abcde) = new(abcde, nothing)
end

function isless(lhs::EqualityMonster, rhs::EqualityMonster)
    return lhs.fitness < rhs.fitness
end

function create_entity(num)
    # for simplicity sake, let's limit the values for abcde to be integers in [-42, 42]
    genes = rand(Uniform(population_model.range[1],population_model.range[2]),
                    population_model.config_parameters.chromosome_size)
    EqualityMonster(genes)
end

function fitness(ent)
    return fitness_function.fitness_function(ent.abcde)
end

function crossover(group)
    child = EqualityMonster()

    # grab each element from a random parent
    num_parents = length(group)
    for i in 1:length(group[1].abcde)
        parent = (rand(Uint) % num_parents) + 1
        child.abcde[i] = group[parent].abcde[i]
    end

    child
end

function mutate(ent)
    # let's go crazy and mutate 20% of the time
    rand(Float64) < 0.8 && return

    rand_element = rand(Uint) % 5 + 1
    ent.abcde[rand_element] = rand(Int) % 43
end

end
