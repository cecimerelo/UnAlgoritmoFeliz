using BlackBoxOptimizationBenchmarking

function evaluate_individual(genes::Array{FeaturesArray,1}, f::BBOBFunction)
    fitness = 0

    for gene in genes
        fitness = fitness + f(genes[1].features)
    end

    return fitness
end
