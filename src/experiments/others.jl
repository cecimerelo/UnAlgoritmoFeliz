using CSV
using DataFrames
using Gadfly
using Cairo
using Fontconfig

outcomes = [
    "config_file_9_Rastrigin_12:22:13.csv",
    "config_file_10_Rastrigin_12:47:23.csv"
]

layers = []

for (i, file_name) in enumerate(outcomes)
    files_complete_path = "./data/Outcomes/$(file_name)"
    outcome_df = CSV.File(files_complete_path) |> DataFrame

    if occursin("config_file_9", file_name)
        outcome_df.Población = "Tamaño: 500"

    elseif occursin("config_file_10", file_name)
        outcome_df.Población = "Tamaño: 1000"
    end

    @show outcome_df
    layer = Gadfly.layer(
                outcome_df,
                x="Generations",
                y="Edit_distance",
                Geom.line,
                color = :Población
            )
    push!(layers, layer)
end

p = Gadfly.plot(layers..., Guide.ylabel("Fitness"), Guide.xlabel("Generación"))
img = PNG("./data/Plots/population_size_variation_diversity.png", 10inch, 6inch)
draw(img, p);