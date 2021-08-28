function from_genes_to_embryo(chromosome, population_model::PopulationModel)
    f =  population_model.fitness_function(chromosome)
    return Embryo(chromosome, f)
end
