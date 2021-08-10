include("utilsModule.jl")
using .utilsModule

using ..IndividualPackagesModule

include("methods/from_genes_to_individual.jl")


function run_algorithm(population_model::PopulationModel)
    poblation = [fecundation_room(population_model)
                    for _ in 1:population_model.config_parameters.population_size]
    return poblation

end

function fecundation_room(population_model::PopulationModel)
    chromosome = rand(population_model.config_parameters.chromosome_size,
                        population_model.config_parameters.dimensions)
    individual = from_genes_to_individual(chromosome, population_model)
end
