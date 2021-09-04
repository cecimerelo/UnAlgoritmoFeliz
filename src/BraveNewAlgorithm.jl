module BraveNewAlgorithm
export 
        Caste, 
        ALPHA, 
        BETA, 
        GAMMA, 
        DELTA, 
        EPSILON, 
        ConfigurationParametersEntity,
        FitnessFunction, 
        PopulationModel, 
        Embryo, 
        Individual
    
    export best_element_of_population

    include("individual/castes.jl")
    include("individual/population_model.jl")
    include("brave_new_algorithm.jl")
end # module
