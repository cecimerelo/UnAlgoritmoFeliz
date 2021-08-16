using .utilsModule
using .IndividualPackagesModule

include("methods/from_genes_to_embryo.jl")
include("commons.jl")
include("methods/hatchery.jl")

function run_algorithm(population_model::PopulationModel)
    embryos = [
        fertilising_room(population_model)
        for _ in 1:population_model.config_parameters.population_size
    ]

    best_element = best_element_of_population(embryos)

    generation = 0
    generations_with_the_same_best_element = 0
    number_of_evaluations = 0
    #while generations_with_the_same_best_element <= population_model.config_parameters.max_generations ||
    number_of_evaluations <= population_model.config_parameters.max_evaluations
    @info "Generation -> $(generation)"
    @info "Generations with the same best element -> $(generations_with_the_same_best_element)"
    population_in_castes = hatchery(population_model, embryos)
    new_population = evolution(population_in_castes)
    #end
    return population_in_castes
end

function fertilising_room(population_model::PopulationModel)
    chromosome = rand(population_model.config_parameters.chromosome_size,
                        population_model.config_parameters.dimensions)
    embryo = from_genes_to_embryo(chromosome, population_model)
    return embryo
end
