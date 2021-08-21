function evolution(population_in_castes, population_model)
    @info "Population evolving"

    alpha_reproduction_pool = selector_operator(ALPHA(), population_in_castes[ALPHA()])
    beta_reproduction_pool = selector_operator(BETA(), population_in_castes[BETA()], alpha_reproduction_pool)
end