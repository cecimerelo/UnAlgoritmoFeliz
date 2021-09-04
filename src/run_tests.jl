using Pkg
Pkg.activate(".")

include("../src/BraveNewAlgorithmModule.jl")

include("test/methods/evolution_test.jl")
include("test/methods/from_genes_to_embryo_test.jl")
include("test/methods/hatchery_test.jl")
include("test/methods/fertilising_room_test.jl")
include("test/methods/local_search_test.jl")

include("test/operators/crossover_test.jl")
include("test/operators/mutation_test.jl")
include("test/operators/selector_test.jl")

include("test/commons_test.jl")
include("test/utils_test.jl")
