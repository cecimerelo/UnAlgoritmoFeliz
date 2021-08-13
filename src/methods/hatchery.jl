#=
In the hatchery we will divide the poblation in classes according to the step
sizes set on the configuration file
=#
using .IndividualPackagesModule

function hatchery(population_model, population)
    percentages = [percentage for (caste, percentage) in population_model.config_parameters.castes_percentages]
    @assert(sum(percentages) == 100, "The percentages should have sum 100")
    @info "Dividing the population in castes"
    caste_number_of_elements = Dict()
    castes = Dict()

    for (caste, percentage) in population_model.config_parameters.castes_percentages
        elements_in_caste = floor(Int,(percentage * length(population)) / 100)
        @info "$(caste) -> $(percentage)%, elements in caste -> $(elements_in_caste)"
        caste_number_of_elements[caste] = elements_in_caste
    end

    for (caste, number_of_elements) in caste_number_of_elements
        individuals_in_caste = sample(population, number_of_elements; replace=true)
        castes[caste] = individuals_in_caste
        delete_element_from_array(population, individuals_in_caste)
    end

    return castes
end
