using Pkg
Pkg.activate(".")

include("../BraveNewAlgorithm.jl")
using .BraveNewAlgorithm
using GeneticAlgorithms
using BlackBoxOptimizationBenchmarking
using Gadfly
using Cairo
using Fontconfig
using DataFrames

include("equalityga.jl")
include("../utils.jl")

config_file = "config_file_5"
fitness_function = FitnessFunction(BlackBoxOptimizationBenchmarking.F3, 0)
population_model = build_population_model(config_file, fitness_function)

model = runga(equalityga; initial_pop_size=population_model.config_parameters.population_size)
population_model = population(model) # the the latest population when the GA exited

partialsort(population_model, 1, by=t -> t.fitness, lt=isless)

fitnes_values = [p.fitness for p in population_model]
other = [100 for p in population_model]

df = DataFrame(Dict(
    "population_size" => "Test run", 
    "F_Values" => fitnes_values,
))

p = Gadfly.plot(
    df, x="population_size", 
    y="F_Values", Geom.boxplot,
    Theme(major_label_font_size=12pt,minor_label_font_size=12pt)
)

img = PNG("./data/Plots/comparation.png", 3inch, 3inch)
draw(img, p);