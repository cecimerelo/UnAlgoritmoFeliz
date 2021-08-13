#=
In the hatchery we will divide the poblation in classes according to the step
sizes set on the configuration file
=#
using .IndividualPackagesModule

function hatchery(population_model, population)
    percentages = [percentage for (caste, percentage) in population_model.config_parameters.castes_percentages]
    @assert(sum(percentages) == 100, "The percentages should have sum 100")
    @info "Dividing the population in castes"
    castes = Dict()

    for (caste, percentage) in population_model.config_parameters.castes_percentages
        @info "$(caste) -> $(percentage)%"
        elements_in_caste = floor(Int,(percentage * length(population)) / 100)
        individuals_in_caste = sample(population, elements_in_caste; replace=true)
        castes[caste] = individuals_in_caste
        delete_element_from_array(population, individuals_in_caste)
    end

    return castes
end
