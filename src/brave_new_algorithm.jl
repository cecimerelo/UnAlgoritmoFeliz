using .utilsModule
using .IndividualPackagesModule

include("methods/from_genes_to_individual.jl")
include("commons.jl")


function run_algorithm(population_model::PopulationModel)
    population = [
        fertilising_room(population_model)
        for _ in 1:population_model.config_parameters.population_size
    ]

    best_element = best_element_of_population(population)

    generation = 0
    generations_with_the_same_best_element = 0
    number_of_evaluations = 0
    #while generations_with_the_same_best_element <= population_model.config_parameters.max_generations ||
    number_of_evaluations <= population_model.config_parameters.max_evaluations
    @info "Generation -> $(generation)"
    @info "Generations with the same best element -> $(generations_with_the_same_best_element)"
    castes = hatchery(population_model, population)
    #end
    return population
end

function fertilising_room(population_model::PopulationModel)
    chromosome = rand(population_model.config_parameters.chromosome_size,
                        population_model.config_parameters.dimensions)
    individual = from_genes_to_individual(chromosome, population_model)
end
