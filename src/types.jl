"""
Types for APClite.jl

This module defines the core data structures used in APClite.
"""

# Kind enum for particle types
@enum Kind ATOM HADRON LEPTON PHOTON NULL

# Export the enum
export Kind

"""
    Species

A struct representing a particle or atom with its physical properties.

# Fields
- `name::String`: Name of the particle (e.g., "electron", "proton", "H")
- `charge::Float64`: Charge in units of elementary charge e
- `mass::Float64`: Mass in MeV/c²
- `spin::Float64`: Spin in units of ħ
- `moment::Float64`: Magnetic moment in J/T
- `iso::Float64`: Mass number for isotopes (0 for non-atomic particles)
- `kind::Kind`: Type of particle (ATOM, HADRON, LEPTON, PHOTON, NULL)
"""
struct Species
    name::String
    charge::Float64
    mass::Float64
    spin::Float64
    moment::Float64
    iso::Float64
    kind::Kind
end

# Default constructor for null species
Species() = Species("Null", 0.0, 0.0, 0.0, 0.0, 0.0, NULL)
