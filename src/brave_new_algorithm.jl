include("utilsModule.jl")
using .utilsModule

include("commons.jl")
include("methods/from_genes_to_individual.jl")
include("methods/build_random_individual.jl")

using ..IndividualModule


function run_algorithm(
    config_file_path::String, data_file_path::String, individual::Individual
)
    config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
    poblation = fecundation_room(individual, config_parameters_entity.population_size)
    # TODO: get best element of poblation
    best_element = best_element_of_poblation(poblation)
end


function fecundation_room(individual::Individual, population_size::Int)
    @info "Building random Individuals in the fecundation room"
    poblation = Individual[build_random_individual(individual) for x in 1:population_size]
end
