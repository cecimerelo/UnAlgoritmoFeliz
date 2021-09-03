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
    Guide.title("Variación del fitness, tamaño de población")
)

img = PNG("./data/Plots/Rastrigin_box_plots_p_size.png", 7inch, 7inch)
draw(img, p);