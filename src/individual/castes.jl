using Parameters

abstract type Caste end

@with_kw struct ALPHA <: Caste
    name::String = "ALPHA"
end

@with_kw struct BETA <: Caste
    name::String = "BETA"
end

@with_kw struct GAMMA <: Caste
    name::String = "GAMMA"
end

@with_kw struct DELTA <: Caste
    name::String = "DELTA"
end

@with_kw struct EPSILON <: Caste
    name::String = "EPSILON"
end
