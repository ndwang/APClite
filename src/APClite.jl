"""
APClite.jl - A lightweight version of AtomicAndPhysicalConstants.jl

This package provides atomic and physical constants as plain Float64 values
without Unitful dependencies. It includes a simplified Species struct for
representing particles and atoms.

Key features:
- Latest CODATA 2022 physical constants as plain floats
- Simplified Species struct for particles and atoms
- No macros or complex unit systems
- Fast compile times and minimal dependencies
"""

module APClite

# Include all modules
include("types.jl")
include("constants.jl")
include("constructors.jl")
include("functions.jl")
include("species_data.jl")

# Export main types and functions
export Species
export Kind, ATOM, HADRON, LEPTON, PHOTON, NULL
export C_LIGHT, H_PLANCK, H_BAR, E_CHARGE, M_ELECTRON, M_PROTON, M_NEUTRON
export FINE_STRUCTURE, AVOGADRO, BOHR_RADIUS, RYDBERG

end # module
