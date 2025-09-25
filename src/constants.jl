"""
Physical constants from CODATA 2022

All constants are stored as plain Float64.
"""

# Speed of light in vacuum [m/s]
const C_LIGHT = 2.99792458e8

# Planck constant [J⋅s]
const H_PLANCK = 6.62607015e-34

# Reduced Planck constant [J⋅s]
const H_BAR = H_PLANCK / (2π)

# Elementary charge [C]
const E_CHARGE = 1.602176634e-19

# Electron mass [MeV/c²]
const M_ELECTRON = 0.51099895069

# Proton mass [MeV/c²]
const M_PROTON = 938.27208816

# Neutron mass [MeV/c²]
const M_NEUTRON = 939.56542052

# Muon mass [MeV/c²]
const M_MUON = 105.6583755

# Pion⁰ mass [MeV/c²]
const M_PION_0 = 134.9768

# Charged pion mass [MeV/c²]
const M_PION_CHARGED = 139.57039

# Deuteron mass [MeV/c²]
const M_DEUTERON = 1875.61294257

# Helion mass (³He nucleus) [MeV/c²]
const M_HELION = 2808.39160743

# Fine structure constant (dimensionless)
const FINE_STRUCTURE = 0.0072973525643

# Avogadro constant [mol⁻¹]
const AVOGADRO = 6.02214076e23

# Bohr radius [m]
const BOHR_RADIUS = 5.29177210903e-11

# Rydberg constant [m⁻¹]
const RYDBERG = 10973731.568160

# Classical electron radius [m]
const R_ELECTRON = 2.8179403262e-15

# Permittivity of free space [F/m]
const EPS_0 = 8.8541878128e-12

# Permeability of free space [N/A²]
const MU_0 = 1.25663706212e-6

# Boltzmann constant [J/K]
const K_BOLTZMANN = 1.380649e-23

# Gravitational constant [m³/(kg⋅s²)]
const G_NEWTON = 6.67430e-11

# Magnetic moments [J/T]
const MU_ELECTRON = -9.2847646917e-24
const MU_PROTON = 1.41060679545e-26
const MU_NEUTRON = -9.6623653e-27
const MU_MUON = -4.4904483e-26
const MU_DEUTERON = 4.330735087e-27
const MU_HELION = -1.07461755198e-26

# g-factors (dimensionless)
const G_ELECTRON = -2.00231930436092
const G_PROTON = 5.5856946893
const G_NEUTRON = -3.82608552
const G_MUON = -2.00233184123
const G_DEUTERON = 0.8574382335
const G_HELION = -4.2552506995

# Unit conversions
const KG_PER_AMU = 1.66053906892e-27  # kg per atomic mass unit
const EV_PER_AMU = 931.49410242e6     # eV per atomic mass unit
const J_PER_EV = 1.602176634e-19      # Joules per eV
const C_PER_E = 1.602176634e-19       # Coulombs per elementary charge

# Release year
const RELEASE_YEAR = 2022
