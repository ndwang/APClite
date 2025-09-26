"""
Species constructors for APClite.jl

This module provides constructors for creating Species objects from particle names.
"""

# Regular expression for anti-particles
const ANTI_REGEX = r"anti-|anti|Anti-|Anti"

"""
    Species(name::String)

Create a Species object from a particle name.

# Arguments
- `name::String`: Name of the particle (e.g., "electron", "proton", "H", "H+", "anti-proton")

# Examples
```julia
julia> e = Species("electron")
julia> p = Species("proton") 
julia> h = Species("H")
julia> h_ion = Species("H+")
julia> anti_p = Species("anti-proton")
```

# Supported formats
- Subatomic particles: "electron", "proton", "neutron", "muon", "pion+", "pion-", "pion0", "deuteron", "photon"
- Anti-particles: "anti-electron", "anti-proton", "anti-neutron", "anti-muon", "anti-deuteron"
- Atomic species: "H", "He", "C", "O", "Fe", "U", etc.
- Ions: "H+", "He++", "C+", "O-", etc.
- Isotopes: "H1", "C12", "U235", etc.
"""
function Species(name::String)
    # Handle null/empty names
    if name == "" || lowercase(name) == "null"
        return Species()
    end
    
    # Check for anti-particles
    is_anti = occursin(ANTI_REGEX, name)
    if is_anti
        # Remove anti- prefix for lookup
        clean_name = replace(name, ANTI_REGEX => "")
    else
        clean_name = name
    end
    
    # Check if it's a subatomic particle (exact match first)
    if haskey(SUBATOMIC_SPECIES, name)
        particle_data = SUBATOMIC_SPECIES[name]
        return Species(
            name,
            particle_data.charge,
            particle_data.mass,
            particle_data.spin,
            particle_data.moment,
            0.0,  # iso = 0 for subatomic particles
            particle_data.kind
        )
    end
    
    # Check if it's an anti-particle of a subatomic particle
    if is_anti && haskey(SUBATOMIC_SPECIES, clean_name)
        particle_data = SUBATOMIC_SPECIES[clean_name]
        return Species(
            name,
            -particle_data.charge,  # Flip charge for anti-particle
            particle_data.mass,
            particle_data.spin,
            -particle_data.moment,  # Flip magnetic moment for anti-particle
            0.0,
            particle_data.kind
        )
    end
    
    # Try to parse as atomic species, but catch errors
    try
        return parse_atomic_species(name)
    catch e
        error("Species '$name' not found in subatomic or atomic species database: $e")
    end
end

"""
    parse_atomic_species(name::String)

Parse atomic species from string format like "H", "H+", "C12", "U235++", etc.
"""
function parse_atomic_species(name::String)
    # Define regex patterns (matching AtomicAndPhysicalConstants)
    rgas = r"[A-Z][a-z]|[A-Z]" # atomic symbol regex
    rgm = r"#[0-9][0-9][0-9]|#[0-9][0-9]|#[0-9]" # atomic mass regex with # prefix
    rgm_no_hash = r"[0-9][0-9][0-9]|[0-9][0-9]|[0-9]" # atomic mass regex without # prefix
    rgcp = r"\+[0-9][0-9][0-9]|\+[0-9][0-9]|\+[0-9]|\+\+|\+" # positive charge regex
    rgcm = r"\-[0-9][0-9][0-9]|\-[0-9][0-9]|\-[0-9]|\-\-|\-" # negative charge regex
    
    anti_atom::Bool = false
    charge = 0
    iso = -1
    
    # Handle anti-atoms
    if occursin(ANTI_REGEX, name)
        name = replace(name, ANTI_REGEX => "")
        anti_atom = true
    end
    
    # Extract atomic symbol
    AS = match(rgas, name)
    if AS === nothing
        error("The specified particle name does not exist in this library.")
    end
    
    symbol = AS.match
    name = replace(name, symbol => "") # strip atomic symbol from the entered text
    
    # Parse isotope number
    isom = match(rgm, name)
    if isom !== nothing
        isostr = strip(isom.match, '#')
        iso = tryparse(Int, isostr)
        if iso === nothing
            error("Invalid isotope number format")
        end
        name = replace(name, isom.match => "")
    else
        # Try without # prefix
        isom = match(rgm_no_hash, name)
        if isom !== nothing
            isostr = isom.match
            iso = tryparse(Int, isostr)
            if iso === nothing
                error("Invalid isotope number format")
            end
            name = replace(name, isom.match => "")
        end
    end
    
    # Parse charge
    if count('+', name) != 0 && count('-', name) != 0
        error("You made a typo in \"$name\". You have both + and - in the name.")
    elseif occursin(rgcp, name)
        chstr = match(rgcp, name).match
        if chstr == "+"
            charge = 1
        elseif chstr == "++"
            charge = 2
        else
            charge = tryparse(Int, chstr)
            if charge === nothing
                error("Invalid charge format")
            end
        end
        name = replace(name, chstr => "")
    elseif occursin(rgcm, name)
        chstr = match(rgcm, name).match
        if chstr == "-"
            charge = -1
        elseif chstr == "--"
            charge = -2
        else
            charge = tryparse(Int, chstr)
            if charge === nothing
                error("Invalid charge format")
            end
        end
        name = replace(name, chstr => "")
    end
    
    # Check for remaining characters
    if name != ""
        error("You have entered too many characters: please try again.")
    end
    
    # Check if element exists in atomic species database
    if !haskey(ATOMIC_SPECIES, symbol)
        error("Element $symbol not found in atomic species database")
    end
    
    atom_data = ATOMIC_SPECIES[symbol]
    
    # Error handling for isotope availability
    if iso != -1 && iso ∉ keys(atom_data.mass)
        error("The isotope you specified is not available.")
    end
    
    # Error handling for charge limits
    if charge > atom_data.Z
        error("You have specified a larger positive charge than the fully stripped $symbol atom has, which is unphysical.")
    end
    
    # Calculate mass
    mass = begin
        if anti_atom == false
            nmass = atom_data.mass[iso] * EV_PER_AMU / 1e6
            # Mass of the positively charged isotope in MeV/c²
            nmass + M_ELECTRON * (atom_data.Z - charge)
            # Remove the electrons
        else
            nmass = atom_data.mass[iso] * EV_PER_AMU / 1e6
            # Mass of the positively charged isotope in MeV/c²
            nmass + M_ELECTRON * (-atom_data.Z + charge)
            # Remove the positrons
        end
    end
    
    # Calculate spin
    if iso == -1 # if it's the average, make an educated guess at the spin
        partonum = round(atom_data.mass[iso])
        if anti_atom == false
            spin = 0.5 * (partonum + (atom_data.Z - charge))
        else
            spin = 0.5 * (partonum + (atom_data.Z + charge))
        end
    else # otherwise, use the sum of proton and neutron spins
        spin = 0.5 * iso
    end
    
    # Return the object
    if anti_atom == false
        return Species(symbol, Float64(charge), mass, spin, 0.0, Float64(iso), ATOM)
    else
        return Species("anti-" * symbol, Float64(charge), mass, spin, 0.0, Float64(iso), ATOM)
    end
end
