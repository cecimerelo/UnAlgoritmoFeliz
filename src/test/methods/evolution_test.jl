using SimpleMock
using .BraveNewAlgorithm
include("../../methods/evolution.jl")
include("../../operators/selector.jl")
include("../../operators/crossover.jl")

config_file_path = "./data/Config Files/config_file_1_test.json"
config_parameters_entity = read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1
population_model = PopulationModel(config_parameters_entity, fitness_function)
embryos = [
    BraveNewAlgorithm.fertilising_room(population_model)
    for _ in 1:population_model.config_parameters.population_size
]

population_in_castes = hatchery(population_model, embryos)

mock(selector_operator) do operator
    @assert operator isa Mock
    evolution(population_in_castes, population_model)
    @assert ncalls(operator) == 2
end


mock(crossover_operator) do operator
    @assert operator isa Mock
    evolution(population_in_castes, population_model)
    @assert called(operator)
end