include("./from_genes_to_embryo.jl")


function fertilising_room(population_model::PopulationModel)
    chromosome = rand(population_model.range[1]:population_model.range[2], 
                        population_model.config_parameters.population_size)
    embryo = from_genes_to_embryo(chromosome, population_model)
    return embryo
end
