using Random
using StatsBase

function selector_operator(caste::ALPHA, caste_population)
    @info "Building pool operator for $(caste.name) caste"
    reproduction_pool =  build_reproduction_pool(caste_population)
    return pairwise(reproduction_pool)
end


function selector_operator(caste::BETA, caste_population, alpha_reproduction_pool)
    @info "Building pool operator for $(caste.name) caste"
    beta_reproduction_pool =  build_reproduction_pool(caste_population)
    alpha_reproduction_pool = from_array_of_tuples_to_array(alpha_reproduction_pool)

    @assert(length(alpha_reproduction_pool) <= length(beta_reproduction_pool),
            "Alpha population should be <= Beta population"
        )

    reproductible_beta = sample(beta_reproduction_pool, length(alpha_reproduction_pool), replace=false)

    selected = Vector{Tuple}()
    for alpha_individual in alpha_reproduction_pool
        beta_individual = rand(reproductible_beta)
        delete_element_from_array(reproductible_beta, [beta_individual])
        tuple = (alpha_individual, beta_individual)
        push!(selected, tuple)
    end

    return selected
end

function selector_operator(caste, caste_population)
    @info "Lower caste, selection not applied"
end

function build_reproduction_pool(caste_population)
    caste_population = shuffle(caste_population)
    winners =
        [
            binary_tournament(caste_population) for _ in 1:2
        ]
    return vcat(winners[1], winners[2])
end

function binary_tournament(caste_population)
    reproduction_pool = Vector{Individual}()
    copy_of = deepcopy(caste_population)
    for (x,y) in pairwise(copy_of)
        if x.f_value > y.f_value
            push!(reproduction_pool, y)
        elseif x.f_value < y.f_value
            push!(reproduction_pool, x)
        else
            individual = rand([x,y])
            push!(reproduction_pool, individual)
        end
    end
    return reproduction_pool
end
