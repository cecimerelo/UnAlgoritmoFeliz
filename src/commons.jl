delete_element_from_array(array, elements) = for element in elements
        deleteat!(array, findfirst(x->x == element,array))
    end

best_element_of_population(population) = partialsort(population, 1, by = t -> t.f_value, lt = isless)

function pairwise(iterable)
    tuples = Vector{Tuple}()
    while !isempty(iterable)
        pair = []
        for _ in 1:2
            random_individual = rand(iterable)
            delete_element_from_array(iterable, [random_individual])
            push!(pair, random_individual)
        end
        tuple = (pair...,)
        push!(tuples, tuple)
    end
    return tuples
end

function from_array_of_tuples_to_array(array_of_tuples)
    new_array = Vector{Individual}()
    for tuple in array_of_tuples
        un_tupled = collect(tuple)
        new_array = vcat(new_array,un_tupled
        )
    end
    return new_array
end
