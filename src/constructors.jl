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
    catch
        error("Species '$name' not found in subatomic or atomic species database")
    end
end

"""
    parse_atomic_species(name::String)

Parse atomic species from string format like "H", "H+", "C12", "U235++", etc.
"""
function parse_atomic_species(name::String)
    # Check for anti-atoms
    is_anti = occursin(ANTI_REGEX, name)
    if is_anti
        clean_name = replace(name, ANTI_REGEX => "")
    else
        clean_name = name
    end
    
    # Extract element symbol, isotope number, and charge
    element, isotope, charge = parse_atomic_string(clean_name)
    
    # Get atomic data
    if !haskey(ATOMIC_SPECIES, element)
        error("Element $element not found in atomic species database")
    end
    
    atom_data = ATOMIC_SPECIES[element]
    
    # Get mass for the isotope
    if isotope == 0
        mass = get_most_abundant_mass(element)
    else
        mass = get_atomic_mass(element, isotope)
    end
    
    # Adjust mass for charge (add/remove electron masses)
    if charge > 0
        # Positive ion: remove electron masses
        mass -= charge * M_ELECTRON
    elseif charge < 0
        # Negative ion: add electron masses
        mass += abs(charge) * M_ELECTRON
    end
    
    # Calculate spin (rough approximation)
    if isotope == 0
        # Use most abundant isotope
        isotope = Int(round(mass / 931.5))  # Rough conversion from MeV to mass number
    end
    
    spin = isotope % 2 == 0 ? 0.0 : 0.5  # Even mass number: integer spin, odd: half-integer
    
    # Create final name
    final_name = is_anti ? "anti-$name" : name
    
    return Species(
        final_name,
        Float64(charge),
        mass,
        spin,
        0.0,  # Magnetic moment not calculated for atoms
        Float64(isotope),
        ATOM
    )
end

"""
    parse_atomic_string(name::String)

Parse atomic string into element, isotope number, and charge.

# Examples
- "H" -> ("H", 0, 0)
- "H+" -> ("H", 0, 1) 
- "C12" -> ("C", 12, 0)
- "U235++" -> ("U", 235, 2)
- "O-" -> ("O", 0, -1)
"""
function parse_atomic_string(name::String)
    # Find the element symbol (1-2 characters at the start)
    element = ""
    isotope = 0
    charge = 0
    
    # Find element symbol
    if length(name) >= 2 && islowercase(name[2])
        element = name[1:2]  # Two-letter symbol
        remaining = name[3:end]
    else
        element = name[1:1]  # One-letter symbol
        remaining = name[2:end]
    end
    
    # Parse remaining string for isotope and charge
    if remaining == ""
        return (element, isotope, charge)
    end
    
    # Find charge symbols
    plus_count = count(==('+'), remaining)
    minus_count = count(==('-'), remaining)
    
    if plus_count > 0 && minus_count > 0
        error("Cannot have both positive and negative charges in $name")
    end
    
    if plus_count > 0
        charge = plus_count
        remaining = replace(remaining, "+" => "")
    elseif minus_count > 0
        charge = -minus_count
        remaining = replace(remaining, "-" => "")
    end
    
    # Parse isotope number
    if remaining != ""
        isotope = parse(Int, remaining)
    end
    
    return (element, isotope, charge)
end
