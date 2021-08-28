include("../operators/selector.jl")
include("../operators/crossover.jl")
include("../operators/mutation.jl")
include("../methods/local_search.jl")


function evolution(population_in_castes, population_model)
    @info "Population evolving"
    alpha_reproduction_pool = selector_operator(ALPHA(), population_in_castes[ALPHA()])
    beta_reproduction_pool = selector_operator(BETA(), population_in_castes[BETA()], alpha_reproduction_pool)

    new_alpha_individuals = [
        create_new_individual(
            alpha_parents, population_model.config_parameters, ALPHA()
        ) 
        for alpha_parents in alpha_reproduction_pool for _ in 1:2
    ]    
    new_beta_individuals = [
        create_new_individual(
            alpha_beta_parents, population_model.config_parameters, BETA()
        ) 
        for alpha_beta_parents in beta_reproduction_pool for _ in 1:2
    ]

    lower_castes_mutated = [
        mutation_operator(individual.chromosome, population_model.config_parameters, caste) 
        for caste in [GAMMA(), DELTA(), EPSILON()]
        for individual in population_in_castes[caste]
    ]
    
    return vcat(new_alpha_individuals, new_beta_individuals, lower_castes_mutated)
end

function create_new_individual(parents, config_parameters, caste)
    offspring = crossover_operator(parents, config_parameters)
    offspring_mutated = mutation_operator(offspring, config_parameters, caste)
    new_individual = local_search(offspring_mutated, population_model, caste)
    
    return new_individual
end
