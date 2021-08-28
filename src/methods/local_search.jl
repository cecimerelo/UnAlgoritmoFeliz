include("fertilising_room.jl")

function local_search(offspring, population_model, caste::GAMMA)
    @warn "Applying local search"
    new_embryo = Embryo([],0.0)
    improved = false
    old_embryo = from_genes_to_embryo(offspring, population_model)

    while !improved
        new_embryo = fertilising_room(population_model)

        if new_embryo.f_value < old_embryo.f_value 
            improved = true
        end
    end

    return new_embryo.chromosome

end

function local_search(offspring, population_model, caste)
    return offspring
end