#=
In the hatchery we will divide the poblation in classes according to the step
sizes set on the configuration file
=#
using .IndividualPackagesModule

function hatchery(population_model, population)
    percentages = [percentage for (caste, percentage) in population_model.config_parameters.castes_percentages]
    @assert(sum(percentages) == 100, "The percentages should have sum 100")
    @info "Dividing the population in castes"

    population_length = length(population)

    population_for_each_caste= get_number_of_population_for_each_caste(population_model)
    population_in_castes = divide_population_in_castes(population, population_for_each_caste)

    assert_population_divided_in_castes_match_initial_population_size(population_in_castes, population_length)
    return population_in_castes
end

function get_number_of_population_for_each_caste(population_model)
    population_for_each_caste = Dict()
    config_parameters = population_model.config_parameters

    for (caste, percentage) in config_parameters.castes_percentages
        elements_in_caste = floor(Int,(percentage * config_parameters.population_size) / 100)
        @info "$(caste) -> $(percentage)%, elements in caste -> $(elements_in_caste)"
        population_for_each_caste[caste] = elements_in_caste
    end

    return population_for_each_caste
end

function divide_population_in_castes(population, population_for_each_caste)
    population_in_castes = Dict()

    for (caste, number_of_elements) in population_for_each_caste
        individuals_in_caste = sample(population, number_of_elements; replace=true)
        population_in_castes[caste] = individuals_in_caste
        delete_element_from_array(population, individuals_in_caste)
    end

    return population_in_castes
end

function assert_population_divided_in_castes_match_initial_population_size(castes, population_length)
    population_in_castes = [length(caste_population) for (caste, caste_population) in castes]
    population_in_castes_sum = sum(population_in_castes)

    @assert(population_in_castes_sum == population_length,
            "The population divided in castes does not match the length of the initial population")
end
