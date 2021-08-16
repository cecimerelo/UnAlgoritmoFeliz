module IndividualPackagesModule

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
    
include("individual/castes.jl")
include("individual/population_model.jl")

end
