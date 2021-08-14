using BlackBoxOptimizationBenchmarking


function evaluate_chromosome(chromosome::Array, fitness_function :: BBOBFunction)
    fitness = 0

    for gene in chromosome
        fitness = fitness + fitness_function(gene)
    end

    return fitness
end
