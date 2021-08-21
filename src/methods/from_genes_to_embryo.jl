include("evaluate_chromosome.jl")


function from_genes_to_embryo(chromosome, population_model::PopulationModel)
    f =  evaluate_chromosome(chromosome, population_model.fitness_function)

    return Embryo(chromosome, f)
end
