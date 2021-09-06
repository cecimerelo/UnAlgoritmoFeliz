using Gadfly
using CSV
using DataFrames
using Cairo
using Fontconfig

# files_complete_path = "./data/Outcomes/draft_summary.csv"
# summary_df = CSV.File(files_complete_path) |> DataFrame

# Gadfly.plot(
#     summary_df,
#     x="CONFIG_FILE_PATH",
#     y="BEST_ELEMENT",
#     Geom.boxplot,
#     Guide.xlabel("Fichero de Configuración"),
#     Guide.ylabel("Valor del Fitness"),
# )

# img = PNG("./data/Plots/Rastrigin_box_plots_chrom_dim.png", 7inch, 7inch)
# draw(img, p);


# outcomes = [
#     "config_file_10_Rastrigin_18:15:50.csv",
#     "config_file_11_Rastrigin_18:33:34.csv",
#     "config_file_12_Rastrigin_19:11:12.csv",
#     "config_file_13_Rastrigin_19:18:29.csv",
#     "config_file_14_Rastrigin_20:12:33.csv"
# ]

# outcomes = [
#     "config_file_1_Rastrigin_18:09:10.csv",
#     "config_file_2_Rastrigin_18:34:18.csv",
#     "config_file_3_Rastrigin_19:05:36.csv",
#     "config_file_4_Rastrigin_19:40:10.csv",
#     "config_file_5_Rastrigin_20:25:21.csv",
#     "config_file_6_Rastrigin_20:49:17.csv"
# ]

# outcomes = [
#     "config_file_1_Rastrigin_18:09:10.csv",
#     "config_file_7_Rastrigin_11:22:48.csv",
#     "config_file_8_Rastrigin_12:00:14.csv",
#     "config_file_9_Rastrigin_12:22:13.csv",
#     "config_file_10_Rastrigin_18:15:50.csv"
# ]

# outcomes = [
#     # "config_file_15_Rastrigin_17:09:09.csv",
#     # "config_file_16_Rastrigin_17:39:24.csv",
#     "config_file_17_Rastrigin_19:04:04.csv",
#     "config_file_18_Rastrigin_08:54:26.csv",
#     "config_file_19_Rastrigin_09:13:50.csv",
#     # "config_file_20_Rastrigin_09:38:24.csv",
#     "config_file_21_Rastrigin_09:55:41.csv",
#     "config_file_22_Rastrigin_10:36:44.csv"
# ]

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
                x="config_file",
                y="F_Values",
                Geom.point,
                color = :config_file
            )
    push!(layers, layer)
end

p = Gadfly.plot(
    layers...,
    Guide.ylabel("Valor del fitness"),
    Guide.xlabel("Fichero de configuración"),
    Theme(major_label_font_size=13pt,minor_label_font_size=13pt)
)

img = PNG("./data/Plots/box_blot_mutation_rate.png", 9inch, 6inch)
draw(img, p);