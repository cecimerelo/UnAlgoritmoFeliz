function from_genes_to_embryo(chromosome, population_model::PopulationModel)
    f =  population_model.fitness_function.fitness_function(chromosome)
    population_model.fitness_function.calls_counter = population_model.fitness_function.calls_counter + 1
    return Embryo(chromosome, f)
end
