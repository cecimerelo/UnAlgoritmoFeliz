include("../operators/crossover.jl")
include("../operators/selector.jl")


function evolution(population_in_castes, population_model)
    @info "Population evolving"

    alpha_reproduction_pool = selector_operator(ALPHA(), population_in_castes[ALPHA()])
    beta_reproduction_pool = selector_operator(BETA(), population_in_castes[BETA()], alpha_reproduction_pool)

    new_alpha_individuals = [
        crossover_operator(alpha_parents,population_model.config_parameters) 
        for alpha_parents in alpha_reproduction_pool for _ in 1:2
    ]    
    new_beta_individuals = [
        crossover_operator(alpha_beta_parents, population_model.config_parameters) 
        for alpha_beta_parents in beta_reproduction_poolfor _ in 1:2
    ]
    
end
