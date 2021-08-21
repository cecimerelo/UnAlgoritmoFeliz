module BraveNewAlgorithm
    export 
        Caste, 
        ALPHA, 
        BETA, 
        GAMMA, 
        DELTA, 
        EPSILON, 
        ConfigurationParametersEntity, 
        PopulationModel, 
        Embryo, 
        Individual
    
    export best_element_of_population

    include("individual/castes.jl")
    include("individual/population_model.jl")

    #include("commons.jl")
    include("brave_new_algorithm.jl")

    #include("utils.jl")
end