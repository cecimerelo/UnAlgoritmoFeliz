include("evaluate_chromosome.jl")


function from_genes_to_individual(chromosome, population_model::PopulationModel)
    f =  evaluate_chromosome(chromosome, population_model.fitness_function)

    return Individual(chromosome, f)
end
