function crossover_operator(parents, config_parameters_entity)
    chromosome_length = length(parents[1].chromosome)
    start_of_the_segment = rand(1:chromosome_length)
    segment_length = rand(1:chromosome_length)

    end_of_segment = start_of_the_segment + segment_length - 1
    indexes_to_take_from_parent = [mod(index, chromosome_length) + 1 for index in start_of_the_segment:end_of_segment]

    best_parent = sort([parents...], by=t -> t.f_value)[1]
    offspring = Array{Float64,1}()
    for (index, gene) in enumerate(best_parent.chromosome)
        if index in indexes_to_take_from_parent
            insert!(offspring, index, gene)
        else
            chosen_parent = rand(1:2)
            insert!(offspring, index, parents[chosen_parent].chromosome[index])
        end
    end
    
    return offspring
end