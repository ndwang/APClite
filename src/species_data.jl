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
    #merge!(ATOMIC_SPECIES, Dict{String, NamedTuple}(
    #))
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
