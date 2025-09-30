"""
Functions for APClite.jl

This module provides utility functions for working with Species objects.
"""

"""
    g_spin(m, μ, spin, charge; signed::Bool=false)

Compute the g-factor for a particle

# Arguments
- `m::Float64`: The mass of the particle in MeV/c²
- `μ::Float64`: The magnetic moment of the particle in J/T
- `spin::Float64`: The spin of the particle in units of ħ
- `charge::Float64`: The charge of the particle in units of e
- `signed::Bool`: Whether to return the signed or absolute value of the g-factor
"""
function g_spin(m, μ, spin, charge; signed::Bool=false)
    m = m * KG_PER_MEV_C2 # kg
    μ = μ  # J/T
    spin = spin * H_BAR # J/T
    charge = charge * E_CHARGE
            
    g_factor = 2 * m * μ / (spin * charge)
    return signed ? g_factor : abs(g_factor)
end


"""
    g_spin(species::Species; signed::Bool=false)

Compute the g-factor for a particle
"""
function g_spin(species::Species; signed::Bool=false)
    return signed ? species.g_factor : abs(species.g_factor)
end

"""
    gyromagnetic_anomaly(species::Species; signed::Bool=false)

Compute and deliver the gyromagnetic anomaly for a particle
"""
function gyromagnetic_anomaly(species::Species; signed::Bool=false)
    gs = g_spin(species; signed=false)
    return signed ? (gs - 2) / 2 : abs((gs - 2) / 2)
end
