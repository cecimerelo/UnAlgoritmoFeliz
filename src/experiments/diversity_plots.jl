using Pkg
Pkg.activate(".")

using Gadfly
using Cairo
using Fontconfig
using Colors
using CSV
using DataFrames

outcomes = readdir("data/Outcomes")

layers = []
penColors   = distinguishable_colors( length(outcomes)+1 )

for (i, file_name) in enumerate(outcomes)
    if occursin("config_file_5_Rastrigin_20", file_name)
        files_complete_path = "./data/Outcomes/$(file_name)"
        outcome_df = CSV.File(files_complete_path) |> DataFrame
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

p = Gadfly.plot(layers..., Theme(major_label_font_size=12pt,minor_label_font_size=12pt))
img = PNG("./data/Plots/config_file_5_Rastrigin.png", 7inch, 5inch)
draw(img, p);

best_f_value = CSV.File("./data/Outcomes/config_file_5_Rastrigin_17:01:01.csv") |> DataFrame

p = vstack( 
    Gadfly.plot(best_f_value, x="Generations", y="F_Values", Geom.line, Guide.ylabel("Fitness Value", orientation=:vertical), Theme(major_label_font_size=12pt,minor_label_font_size=12pt)),
    Gadfly.plot(best_f_value, x="Generations", y="Edit_distance", Geom.line, Guide.ylabel("Edit distance", orientation=:vertical), Theme(major_label_font_size=12pt,minor_label_font_size=12pt)),
    Gadfly.plot(best_f_value, x="Generations", y="Entropy", Geom.line, Guide.ylabel("Entropy", orientation=:vertical), Theme(major_label_font_size=12pt,minor_label_font_size=12pt)),
)

img = PNG("./data/Plots/config_file_5_Rastrigin_best_f_value.png", 6inch, 6inch)
draw(img, p)


worst_f_value = CSV.File("./data/Outcomes/config_file_5_Rastrigin_16:45:19.csv") |> DataFrame

p = vstack( 
    Gadfly.plot(worst_f_value, x="Generations", y="F_Values", Geom.line, Guide.ylabel("Fitness Value", orientation=:vertical), Theme(major_label_font_size=12pt,minor_label_font_size=12pt)),
    Gadfly.plot(worst_f_value, x="Generations", y="Edit_distance", Geom.line, Guide.ylabel("Edit distance", orientation=:vertical), Theme(major_label_font_size=12pt,minor_label_font_size=12pt)),
    Gadfly.plot(worst_f_value, x="Generations", y="Entropy", Geom.line, Guide.ylabel("Entropy", orientation=:vertical), Theme(major_label_font_size=12pt,minor_label_font_size=12pt)),
)
img = PNG("./data/Plots/config_file_5_Rastrigin_worst_f_value.png", 6inch, 6inch)
draw(img, p)
