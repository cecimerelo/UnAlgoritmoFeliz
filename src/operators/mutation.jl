function mutation_operator(offspring, config_parameters, caste)
    mutated_offspring = Array{Float64,1}()
    mutation_rate_for_caste = config_parameters.mutation_rate[caste.name]
    genes_to_mutate = floor(Int, mutation_rate_for_caste * length(offspring) / 100)
    indexes_to_mutate = rand(1:length(offspring), genes_to_mutate)
    
    for (index, gene) in enumerate(offspring)
        if index in indexes_to_mutate
            new_gene = rand()
            push!(mutated_offspring, new_gene)
        else
            push!(mutated_offspring, gene)
        end
    end

    return reshape(mutated_offspring, (config_parameters.chromosome_size, config_parameters.dimensions))
end