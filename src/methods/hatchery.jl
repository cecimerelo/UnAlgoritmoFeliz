#=
In the hatchery we will divide the poblation in classes according to the step
sizes set on the configuration file
=#
using .IndividualPackagesModule
using StatsBase

function hatchery(population_model, embryos)
    percentages = [percentage for (caste, percentage) in population_model.config_parameters.castes_percentages]
    @assert(sum(percentages) == 100, "The percentages should have sum 100")
    @info "Dividing the embryios in castes"

    embryos_length = length(embryos)

    embryos_for_each_caste= get_number_of_embryos_for_each_caste(population_model)
    population_in_castes = divide_embryos_in_castes(embryos, embryos_for_each_caste)

    assert_population_divided_in_castes_match_initial_population_size(population_in_castes, embryos_length)
    return population_in_castes
end

function get_number_of_embryos_for_each_caste(population_model)
    embryos_for_each_caste = Dict()
    config_parameters = population_model.config_parameters

    for (caste, percentage) in config_parameters.castes_percentages
        elements_in_caste = floor(Int,(percentage * config_parameters.population_size) / 100)
        @info "$(caste) -> $(percentage)%, elements in caste -> $(elements_in_caste)"
        embryos_for_each_caste[caste] = elements_in_caste
    end

    return embryos_for_each_caste
end

function divide_embryos_in_castes(embryos, embryos_for_each_caste)
    population_in_castes = Dict()

    for (caste, number_of_elements) in embryos_for_each_caste
        individuals_in_caste = sample(embryos, number_of_elements; replace=true)
        population_in_castes[caste] = individuals_in_caste
        delete_element_from_array(embryos, individuals_in_caste)
    end

    return population_in_castes
end

function assert_population_divided_in_castes_match_initial_population_size(castes, embryos_length)
    population_in_castes = [length(caste_population) for (caste, caste_population) in castes]
    population_in_castes_sum = sum(population_in_castes)

    @assert(population_in_castes_sum == embryos_length,
            "The population divided in castes does not match the length of the initial population")
end
