
using Gadfly
using CSV
using DataFrames
using Cairo
using Fontconfig
using StatsPlots 
using Distributions  


files_complete_path = "./data/Outcomes/mutation_exploration.csv"
summary_df = CSV.File(files_complete_path) |> DataFrame

config_1 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_13", :]
config_2 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_16", :]
config_3 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_17", :]
config_4 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_18", :]
config_5 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_19", :]
config_6 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_20", :]
config_7 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_21", :]
config_8 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_22", :]
config_9 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_23", :]


config_1 = summary_df[summary_df[:CONFIG_FILE_PATH] .== "config_file_15", :]

median(config_2["BEST_ELEMENT"])
median(config_5["F_EVALUATIONS"])

c = std(config_5["BEST_ELEMENT"])
d = std(config_5["F_EVALUATIONS"])