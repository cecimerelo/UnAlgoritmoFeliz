include("../../methods/evolution.jl")


config_file_path = "./data/Config Files/config_file_1_test.json"
config_parameters_entity = utilsModule.read_parameters_file(config_file_path)
fitness_function = BlackBoxOptimizationBenchmarking.F1
population_model = PopulationModel(config_parameters_entity, fitness_function)
embryos = [
    fertilising_room(population_model)
    for _ in 1:population_model.config_parameters.population_size
]

a = get_number_of_embryos_for_each_caste(population_model)
b = divide_embryos_in_castes(embryos, a)
evolutioned = evolution(population, population_model)
