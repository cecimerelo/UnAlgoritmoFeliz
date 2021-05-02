include("methods/from_genes_to_individual.jl")

using ..utilsModule
using ..IndividualModule


function prepare_individual(
            individual_type, data_file_path, gene_type, element_type;
            k=0, delimiter=',', has_header=false
    )
    genes = utilsModule.from_file_to_genes(
        data_file_path, gene_type, element_type;
        delimiter=delimiter, has_header=has_header
    )
    individual = from_genes_to_individual(genes, individual_type)
    return individual
end
