"""
Species data for subatomic particles and common atoms

This module contains dictionaries with particle data using the latest CODATA 2022 values.
All masses are in MeV/c², charges in units of e, spins in units of ħ, and magnetic moments in J/T.
"""

# Global variables to store the dictionaries
const SUBATOMIC_SPECIES = Dict{String, NamedTuple}()
const ATOMIC_SPECIES = Dict{String, NamedTuple}()

# Initialize the species data
function init_species_data!()
    empty!(SUBATOMIC_SPECIES)
    empty!(ATOMIC_SPECIES)
    
    # Subatomic particles dictionary
    merge!(SUBATOMIC_SPECIES, Dict{String, NamedTuple}(
        "electron" => (charge=-1.0, mass=M_ELECTRON, spin=0.5, moment=MU_ELECTRON, kind=LEPTON),
        "positron" => (charge=1.0, mass=M_ELECTRON, spin=0.5, moment=MU_ELECTRON, kind=LEPTON),
        "proton" => (charge=1.0, mass=M_PROTON, spin=0.5, moment=MU_PROTON, kind=HADRON),
        "anti-proton" => (charge=-1.0, mass=M_PROTON, spin=0.5, moment=MU_PROTON, kind=HADRON),
        "neutron" => (charge=0.0, mass=M_NEUTRON, spin=0.5, moment=MU_NEUTRON, kind=HADRON),
        "anti-neutron" => (charge=0.0, mass=M_NEUTRON, spin=0.5, moment=MU_NEUTRON, kind=HADRON),
        "muon" => (charge=-1.0, mass=M_MUON, spin=0.5, moment=MU_MUON, kind=LEPTON),
        "anti-muon" => (charge=1.0, mass=M_MUON, spin=0.5, moment=MU_MUON, kind=LEPTON),
        "pion0" => (charge=0.0, mass=M_PION_0, spin=0.0, moment=0.0, kind=HADRON),
        "pion+" => (charge=1.0, mass=M_PION_CHARGED, spin=0.0, moment=0.0, kind=HADRON),
        "pion-" => (charge=-1.0, mass=M_PION_CHARGED, spin=0.0, moment=0.0, kind=HADRON),
        "deuteron" => (charge=1.0, mass=M_DEUTERON, spin=1.0, moment=MU_DEUTERON, kind=HADRON),
        "anti-deuteron" => (charge=-1.0, mass=M_DEUTERON, spin=1.0, moment=MU_DEUTERON, kind=HADRON),
        "photon" => (charge=0.0, mass=0.0, spin=1.0, moment=0.0, kind=PHOTON),
    ))

    # Common atomic species data (masses in MeV/c²)
    # For atoms, we store the neutral atom mass (including electrons)
    merge!(ATOMIC_SPECIES, Dict{String, NamedTuple}(
        "H" => (Z=1, mass=938.783, isotopes=Dict(1 => 938.783, -1 => 938.783)),
        "He" => (Z=2, mass=3728.401, isotopes=Dict(3 => 2808.391, 4 => 3727.379, -1 => 3727.379)),
        "Li" => (Z=3, mass=6535.0, isotopes=Dict(6 => 5603.0, 7 => 6535.0, -1 => 6535.0)),
        "Be" => (Z=4, mass=8394.0, isotopes=Dict(9 => 8394.0, -1 => 8394.0)),
        "B" => (Z=5, mass=10012.0, isotopes=Dict(10 => 9321.0, 11 => 10012.0, -1 => 10012.0)),
        "C" => (Z=6, mass=11178.0, isotopes=Dict(12 => 11178.0, 13 => 12109.0, -1 => 11178.0)),
        "N" => (Z=7, mass=13041.0, isotopes=Dict(14 => 13041.0, 15 => 13995.0, -1 => 13041.0)),
        "O" => (Z=8, mass=14908.0, isotopes=Dict(16 => 14908.0, 17 => 15835.0, 18 => 16732.0, -1 => 14908.0)),
        "F" => (Z=9, mass=17670.0, isotopes=Dict(19 => 17670.0, -1 => 17670.0)),
        "Ne" => (Z=10, mass=18756.0, isotopes=Dict(20 => 18756.0, 21 => 19693.0, 22 => 20618.0, -1 => 18756.0)),
        "Na" => (Z=11, mass=21407.0, isotopes=Dict(23 => 21407.0, -1 => 21407.0)),
        "Mg" => (Z=12, mass=22345.0, isotopes=Dict(24 => 22345.0, 25 => 23231.0, 26 => 24117.0, -1 => 22345.0)),
        "Al" => (Z=13, mass=25133.0, isotopes=Dict(27 => 25133.0, -1 => 25133.0)),
        "Si" => (Z=14, mass=26060.0, isotopes=Dict(28 => 26060.0, 29 => 26946.0, 30 => 27832.0, -1 => 26060.0)),
        "P" => (Z=15, mass=28914.0, isotopes=Dict(31 => 28914.0, -1 => 28914.0)),
        "S" => (Z=16, mass=29841.0, isotopes=Dict(32 => 29841.0, 33 => 30727.0, 34 => 31613.0, -1 => 29841.0)),
        "Cl" => (Z=17, mass=32240.0, isotopes=Dict(35 => 32240.0, 37 => 34012.0, -1 => 32240.0)),
        "Ar" => (Z=18, mass=33167.0, isotopes=Dict(36 => 33167.0, 38 => 34939.0, 40 => 36683.0, -1 => 33167.0)),
        "K" => (Z=19, mass=36390.0, isotopes=Dict(39 => 36390.0, 40 => 37276.0, 41 => 38162.0, -1 => 36390.0)),
        "Ca" => (Z=20, mass=37317.0, isotopes=Dict(40 => 37317.0, 42 => 39089.0, 43 => 39975.0, 44 => 40861.0, -1 => 37317.0)),
        "Fe" => (Z=26, mass=52000.0, isotopes=Dict(54 => 50300.0, 56 => 52000.0, 57 => 52886.0, 58 => 53772.0, -1 => 52000.0)),
        "Cu" => (Z=29, mass=59000.0, isotopes=Dict(63 => 59000.0, 65 => 60772.0, -1 => 59000.0)),
        "Zn" => (Z=30, mass=60000.0, isotopes=Dict(64 => 60000.0, 66 => 61772.0, 67 => 62658.0, 68 => 63544.0, -1 => 60000.0)),
        "U" => (Z=92, mass=220000.0, isotopes=Dict(235 => 219000.0, 238 => 222000.0, -1 => 222000.0)),
    ))
end

# Helper function to get atomic mass for a specific isotope
function get_atomic_mass(element::String, isotope::Int)
    if !haskey(ATOMIC_SPECIES, element)
        error("Element $element not found in atomic species database")
    end
    
    atom_data = ATOMIC_SPECIES[element]
    if haskey(atom_data.isotopes, isotope)
        return atom_data.isotopes[isotope]
    else
        error("Isotope $isotope of $element not found in database")
    end
end

# Helper function to get the most abundant isotope mass
function get_most_abundant_mass(element::String)
    if !haskey(ATOMIC_SPECIES, element)
        error("Element $element not found in atomic species database")
    end
    
    atom_data = ATOMIC_SPECIES[element]
    return atom_data.isotopes[-1]  # -1 key stores the most abundant isotope
end
