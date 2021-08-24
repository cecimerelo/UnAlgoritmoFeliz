include("../src/brave_new_algorithm_module.jl")

include("test/methods/evaluate_chromosome_test.jl")
include("test/methods/evolution_test.jl")
include("test/methods/from_genes_to_embryo_test.jl")
include("test/methods/hatchery_test.jl")

include("test/operators/crossover_test.jl")
include("test/operators/mutation_test.jl")
include("test/operators/selector_test.jl")

include("test/commons_test.jl")
include("test/utils_test.jl")
