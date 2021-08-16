function delete_element_from_array(array, elements)
    for element in elements
        deleteat!(array, findall(x->x==element,array))
    end
end

function best_element_of_population(population)
    return partialsort(population, 1, by = t -> t.f_value, lt=isless)
end
