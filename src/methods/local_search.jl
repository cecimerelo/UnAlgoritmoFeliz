include("fertilising_room.jl")
include("from_genes_to_embryo.jl")
include("../operators/mutation.jl")

function local_search(offspring, population_model, caste::GAMMA)
    embryo = from_genes_to_embryo(offspring, population_model)
    f_value = embryo.f_value
    final_chromosome = offspring
    local_search_iterations = 0
    improved = true

    while improved
        mutated_offspring = mutation_operator(final_chromosome, population_model.config_parameters, caste)
        new_embryo = from_genes_to_embryo(mutated_offspring, population_model)
        
        if new_embryo.f_value >= f_value || new_embryo.f_value <= population_model.fitness_function.fitness_function.f_opt
            improved = false
            break
        end

        f_value = new_embryo.f_value
        final_chromosome = mutated_offspring
        local_search_iterations = local_search_iterations + 1
    end

    return final_chromosome

end

function local_search(offspring, population_model, caste)
    return offspring
end