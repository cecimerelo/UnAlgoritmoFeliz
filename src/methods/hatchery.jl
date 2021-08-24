#=
In the hatchery we will divide the poblation in classes according to the step
sizes set on the configuration file
=#
using StatsBase

function hatchery(population_model, embryos)
    percentages =
        [
            percentage for (caste, percentage) in
            population_model.config_parameters.castes_percentages
        ]
    @assert(sum(percentages) == 100, "The percentages should have sum 100")
    @info "Dividing the embryos in castes"

    embryos_length = length(embryos)

    sort!(embryos, by=t -> t.f_value)
    embryos_for_each_caste = get_number_of_embryos_for_each_caste(embryos, population_model)
    population_in_castes = divide_embryos_in_castes(embryos, embryos_for_each_caste)

    assert_population_divided_in_castes_match_initial_population_size(population_in_castes, embryos_length)
    return population_in_castes
end

function get_number_of_embryos_for_each_caste(embryos, population_model)
    embryos_for_each_caste = Dict{String, Int}()
    config_parameters = population_model.config_parameters

    for (caste, percentage) in config_parameters.castes_percentages
        elements_in_caste = round(Int, (percentage * length(embryos)) / 100)
        @info "$(caste) -> $(percentage)%, elements in caste -> $(elements_in_caste)"
        embryos_for_each_caste[caste] = elements_in_caste
    end

    castes_length = [elements_in_caste for (caste, elements_in_caste) in embryos_for_each_caste]
    if(sum(castes_length) != length(embryos))
        embryos_for_each_caste[EPSILON().name] = embryos_for_each_caste[EPSILON().name] + (length(embryos) - sum(castes_length))
    end

    return embryos_for_each_caste
end

function divide_embryos_in_castes(embryos, embryos_for_each_caste)
    population_in_castes = Dict{Caste, Vector{Individual}}()
    CASTES = [ALPHA(), BETA(), GAMMA(), DELTA(), EPSILON()]

    caste_counter = 1
    for caste in CASTES
        caste_population = embryos_for_each_caste[caste.name]
        embryos_in_caste = embryos[caste_counter:caste_population + caste_counter - 1]
        individuals_in_caste = build_individuals_for_caste(embryos_in_caste, caste)
        population_in_castes[caste] = individuals_in_caste

        caste_counter = caste_counter + caste_population
    end

    return population_in_castes
end

function build_individuals_for_caste(embryos_in_caste, caste)
    return [
        Individual(embryo.chromosome, embryo.f_value, caste)
        for embryo in embryos_in_caste
    ]
end

function assert_population_divided_in_castes_match_initial_population_size(population_in_castes, embryos_length)
    castes_length = [length(population) for (caste, population) in population_in_castes]
    total_length = sum(castes_length)
    @assert(total_length == embryos_length,
            "The population divided in castes does not match the length of the initial population")
end
