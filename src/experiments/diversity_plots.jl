using Gadfly
using Cairo
using Fontconfig

outcomes = readdir("data/Outcomes")

layers = []
penColors   = distinguishable_colors( length(outcomes)+1 )

for (i, file_name) in enumerate(outcomes)
    if occursin("config_file_5", file_name)
        files_complete_path = "./data/Outcomes/$(file_name)"
        outcome_df = CSV.File(files_complete_path) |> DataFrame
        @show outcome_df
        layer = Gadfly.layer(
                    outcome_df,
                    x="Generations",
                    y="F_Values",
                    Geom.line,
                    Theme(default_color=penColors[i+1])
                )
        push!(layers, layer)
    end
end

p = Gadfly.plot(layers...)
img = PNG("./data/Plots/config_file_5_Rastrigin.png", 6inch, 4inch)
draw(img, p);

best_f_value = CSV.File("./data/Outcomes/config_file_5_Rastrigin_17:01:01.csv") |> DataFrame

p = vstack( 
    Gadfly.plot(best_f_value, x="Generations", y="F_Values", Geom.line, Guide.ylabel("Fitness Value", orientation=:vertical)),
    Gadfly.plot(best_f_value, x="Generations", y="Edit_distance", Geom.line, Guide.ylabel("Edit distance", orientation=:vertical)),
    Gadfly.plot(best_f_value, x="Generations", y="Entropy", Geom.line, Guide.ylabel("Entropy", orientation=:vertical)),
)

img = PNG("./data/Plots/config_file_5_Rastrigin_best_f_value.png", 6inch, 6inch)
draw(img, p)


worst_f_value = CSV.File("./data/Outcomes/config_file_5_Rastrigin_16:45:19.csv") |> DataFrame

p = vstack( 
    Gadfly.plot(worst_f_value, x="Generations", y="F_Values", Geom.line, Guide.ylabel("Fitness Value", orientation=:vertical)),
    Gadfly.plot(worst_f_value, x="Generations", y="Edit_distance", Geom.line, Guide.ylabel("Edit distance", orientation=:vertical)),
    Gadfly.plot(worst_f_value, x="Generations", y="Entropy", Geom.line, Guide.ylabel("Entropy", orientation=:vertical)),
)
img = PNG("./data/Plots/config_file_5_Rastrigin_worst_f_value.png", 6inch, 6inch)
draw(img, p)
