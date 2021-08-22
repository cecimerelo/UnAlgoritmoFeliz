include("methods/from_genes_to_embryo.jl")
include("methods/hatchery.jl")
include("methods/evolution.jl")
include("commons.jl")

function brave_new_algorithm(population_model::PopulationModel)
    embryos = [
        fertilising_room(population_model)
        for _ in 1:population_model.config_parameters.population_size
    ]

    best_element = best_element_of_population(embryos)

    generation = 0
    generations_with_the_same_best_element = 0
    
    while generations_with_the_same_best_element <= population_model.config_parameters.max_generations
        @info "Generation -> $(generation)"
        @info "Generations with the same best element -> $(generations_with_the_same_best_element)"
        
        population_in_castes = hatchery(population_model, embryos)
        new_chromosomes = evolution(population_in_castes, population_model)
        new_embryos_population = [from_genes_to_embryo(chromosome, population_model) for chromosome in new_chromosomes]
        new_best_element = best_element_of_population(new_embryos_population)

        if new_best_element.f_value > best_element.f_value
            generations_with_the_same_best_element = generations_with_the_same_best_element + 1
            @warn "Generations with the same best element -> $(generations_with_the_same_best_element)"
        else
            generations_with_the_same_best_element = 0
            best_element = new_best_element
        end

        embryos = new_embryos_population
        generation = generation + 1
    end
    
    return embryos
end

function fertilising_room(population_model::PopulationModel)
    chromosome = rand(population_model.config_parameters.chromosome_size,
                        population_model.config_parameters.dimensions)
    embryo = from_genes_to_embryo(chromosome, population_model)
    return embryo
end
