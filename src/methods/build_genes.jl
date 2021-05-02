using DataFrames
using ..IndividualModule

function build_genes(data::DataFrames.DataFrame, gene_type::Type{FeaturesArray})

    genes = FeaturesArray[]
    number_of_rows = size(data, 1)

    @info "Converting data to $(number_of_rows) individual"
    for row in eachrow(data)
        gene = gene_type(row, -1)
        push!(genes, gene)
    end

    return genes
end


function build_genes(data::DataFrames.DataFrame, gene_type::Type{Coordinates})

    genes = Coordinates[]
    number_of_rows = size(data, 1)

    @info "Converting data to $(number_of_rows) individual"
    for row in eachrow(data)
        gene = Coordinates(row[2:end], row[1])
        push!(genes, gene)
    end

    return genes
end
