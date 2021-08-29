include("methods/from_genes_to_embryo.jl")
include("methods/hatchery.jl")
include("methods/evolution.jl")
include("methods/fertilising_room.jl")
include("commons.jl")

using DataFrames

function brave_new_algorithm(population_model::PopulationModel)
    generations_array = Array{Int,1}()
    best_f_values = Array{Float64,1}()

    @info """
    Creating embryos, 
                Chromosome Size -> $(population_model.config_parameters.chromosome_size)
    """
    embryos = [
        fertilising_room(population_model)
        for _ in 1:population_model.config_parameters.population_size
    ]
    best_element = best_element_of_population(embryos)

    generation = 0
    generations_with_the_same_best_element = 0
    while population_model.comparator(best_element.f_value, population_model.fitness_function) && 
        generations_with_the_same_best_element <= population_model.config_parameters.max_generations
        
        @info "Generation -> $(generation), Best f_value -> $(best_element.f_value)"
        @info "Generations with the same best element -> $(generations_with_the_same_best_element)"
        
        population_in_castes = hatchery(population_model, embryos)
        new_chromosomes = evolution(population_in_castes, population_model)
        new_embryos_population = [from_genes_to_embryo(chromosome, population_model) for chromosome in new_chromosomes]
        new_best_element = best_element_of_population(new_embryos_population)

        if new_best_element.f_value > best_element.f_value
            generations_with_the_same_best_element = generations_with_the_same_best_element + 1
            @warn "Best element has not changed"
        else
            generations_with_the_same_best_element = 0
            best_element = new_best_element
        end
        push!(generations_array, generation)
        push!(best_f_values, best_element.f_value)

        embryos = new_embryos_population
        generation = generation + 1
    end
    
    dict_population = Dict("Generations" => generations_array, :"F Values" => best_f_values)
    return generation, DataFrame(dict_population)
end
