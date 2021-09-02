using Distributions
include("./from_genes_to_embryo.jl")


function fertilising_room(population_model::PopulationModel)
    genes = rand(Uniform(population_model.range[1],population_model.range[2]),
                        population_model.config_parameters.chromosome_size)
    embryo = from_genes_to_embryo(genes, population_model)
    return embryo
end
