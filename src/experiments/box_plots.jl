using Gadfly
using CSV
using DataFrames
using Cairo
using Fontconfig

files_complete_path = "./data/Outcomes/summary.csv"
summary_df = CSV.File(files_complete_path) |> DataFrame

p = Gadfly.plot(
    summary_df,
    x="CONFIG_FILE_PATH",
    y="BEST_ELEMENT",
    Geom.boxplot,
    Guide.xlabel("Fichero de Configuración"),
    Guide.ylabel("Valor del Fitness"),
    Guide.title("Variación del valor del fitness según la configuración")
)

img = PNG("./data/Plots/config_file_1-6_Rastrigin_box_plots.png", 7inch, 7inch)
draw(img, p);