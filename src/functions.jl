"""
Getter functions for Species objects

This module provides getter functions to access Species properties.
"""

"""
    nameof(species::Species; basename::Bool=false) -> String

Get the name of the species. For atomic species, includes isotope and charge information unless basename=true.
"""
function Base.nameof(species::Species; basename::Bool=false)::String
    if getfield(species, :kind) == NULL
        return "Null"
    end
    
    bname = getfield(species, :name)
    isostr = ""
    iso = Int(getfield(species, :iso))
    chstr = ""
    ch = Int(getfield(species, :charge))
    ptypes = [HADRON, LEPTON, PHOTON]
    
    if getfield(species, :kind) ∈ ptypes
        return bname
    elseif getfield(species, :kind) == ATOM
        if basename == true
            return bname
        else
            if iso != -1
                isostr = "#" * string(iso)
            end
            if ch > 0
                chstr = "+" * string(ch)
            elseif ch < 0
                chstr = string(ch)
            end
            return isostr * bname * chstr
        end
    end
end

 

"""
    show(io::IO, species::Species)

Display a Species object in a readable format.
"""
function Base.show(io::IO, species::Species)
    if species.kind == NULL
        print(io, "Species(Null)")
    else
        print(io, "Species($(species.name)), charge=$(species.charge)e, mass=$(species.mass) MeV/c², spin=$(species.spin)ħ)")
    end
end

"""
    show(io::IO, ::MIME"text/plain", species::Species)

Display a Species object in a detailed format.
"""
function Base.show(io::IO, ::MIME"text/plain", species::Species)
    if species.kind == NULL
        print(io, "Species(Null)")
    else
        println(io, "Species: $(species.name)")
        println(io, "  Charge: $(species.charge) e")
        println(io, "  Mass: $(species.mass) MeV/c²")
        println(io, "  Spin: $(species.spin) ħ")
        println(io, "  Magnetic moment: $(species.moment) J/T")
        if species.iso > 0
            println(io, "  Mass number: $(Int(species.iso))")
        end
        println(io, "  Kind: $(species.kind)")
    end
end
