using CSV
using DataFrames
using Gadfly
using Cairo
using Fontconfig

# outcomes = [
#     "config_file_4_Rastrigin_19:40:10.csv",
#     "config_file_7_Rastrigin_11:22:48.csv",
#     "config_file_8_Rastrigin_12:00:14.csv",
#     "config_file_9_Rastrigin_12:22:13.csv",
#     "config_file_10_Rastrigin_18:15:50.csv"
# ]

outcomes = [
    "config_file_13_Rastrigin_19:18:29.csv",    
    "config_file_17_Rastrigin_19:04:04.csv",
    "config_file_18_Rastrigin_08:54:26.csv",
    "config_file_19_Rastrigin_09:13:50.csv",
    "config_file_21_Rastrigin_09:55:41.csv",
    "config_file_22_Rastrigin_10:36:44.csv"
]

layers = []

for (i, file_name) in enumerate(outcomes)
    files_complete_path = "./data/Outcomes/$(file_name)"
    outcome_df = CSV.File(files_complete_path) |> DataFrame

    if occursin("config_file_13", file_name)
        outcome_df.config_file = "File 13"
    elseif occursin("config_file_17", file_name)
        outcome_df.config_file = "File 17"
    elseif occursin("config_file_18", file_name)
        outcome_df.config_file = "File 18"
    elseif occursin("config_file_19", file_name)
        outcome_df.config_file = "File 19"
    elseif occursin("config_file_21", file_name)
        outcome_df.config_file = "File 21"
    elseif occursin("config_file_22", file_name)
        outcome_df.config_file = "File 22"
    end

    layer = Gadfly.layer(
                outcome_df,
                x="Generations",
                y="F_Values",
                Geom.line,
                color = :config_file
            )
    push!(layers, layer)
end

p = Gadfly.plot(
    layers..., 
    Guide.ylabel("Valor del fitness"), 
    Guide.xlabel("Generación"),
    Theme(major_label_font_size=13pt,minor_label_font_size=13pt)
)
img = PNG("./data/Plots/mutation_rate_executions.png", 8inch, 5inch)
draw(img, p);