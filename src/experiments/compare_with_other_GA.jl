# using Pkg
# Pkg.activate(".")

using GeneticAlgorithms

struct EqualityMonster <: GeneticAlgorithms.Entity
    abcde::Array
    fitness

    EqualityMonster() = new(Array(Int, 5), nothing)
    EqualityMonster(abcde) = new(abcde, nothing)
end

function create_entity(num)
    # for simplicity sake, let's limit the values for abcde to be integers in [-42, 42]
    EqualityMonster(rand(Int, 5) % 43)
end

function fitness(ent)
    # we want the expression `a + 2b + 3c + 4d + 5e - 42`
    # to be as close to 0 as possible
    score = ent.abcde[1] +
            2 * ent.abcde[2] +
            3 * ent.abcde[3] +
            4 * ent.abcde[4] +
            5 * ent.abcde[5]

    abs(score - 42)
end


