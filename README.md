# APClite.jl

A lightweight version of AtomicAndPhysicalConstants.jl that provides atomic and physical constants as plain Float64 values without Unitful dependencies.

## Features

- **Latest CODATA 2022 data**: All physical constants from the most recent CODATA release
- **No dependencies**: Pure Julia with no external dependencies
- **Fast compilation**: Simple static constants for optimal performance
- **Simple API**: Easy-to-use Species struct with direct field access
- **Comprehensive coverage**: Subatomic particles, atoms, ions, and isotopes

## Installation

```julia
julia> using Pkg
julia> Pkg.add("APClite")
```

## Quick Start

```julia
using APClite

# Access physical constants directly
C_LIGHT          # 2.99792458e8 [m/s]
H_PLANCK         # 6.62607015e-34 [J⋅s]
M_ELECTRON       # 0.51099895069 [MeV/c²]
FINE_STRUCTURE   # 0.0072973525643

# Create species objects
e = Species("electron")
p = Species("proton")
h = Species("H")
h_ion = Species("H+")
anti_p = Species("anti-proton")

# Access species properties (direct fields)
e.mass           # 0.51099895069 [MeV/c²]
p.charge         # 1.0 [e]
e.spin           # 0.5 [ħ]
```

## Supported Species

### Subatomic Particles
- `"electron"`, `"positron"`
- `"proton"`, `"anti-proton"`
- `"neutron"`, `"anti-neutron"`
- `"muon"`, `"anti-muon"`
- `"pion0"`, `"pion+"`, `"pion-"`
- `"deuteron"`, `"anti-deuteron"`
- `"photon"`

### Atomic Species
- All common elements: `"H"`, `"He"`, `"C"`, `"O"`, `"Fe"`, `"U"`, etc.
- Ions: `"H+"`, `"He++"`, `"C+"`, `"O-"`
- Isotopes: `"H1"`, `"C12"`, `"U235"`

## API Reference

### Constants
All constants are available as module-level constants:
- `C_LIGHT`: Speed of light [m/s]
- `H_PLANCK`: Planck constant [J⋅s]
- `H_BAR`: Reduced Planck constant [J⋅s]
- `E_CHARGE`: Elementary charge [C]
- `M_ELECTRON`, `M_PROTON`, `M_NEUTRON`: Particle masses [MeV/c²]
- `FINE_STRUCTURE`: Fine structure constant
- `AVOGADRO`: Avogadro constant [mol⁻¹]
- And many more...

### Species Functions
- `Species(name::String)`: Create a species from name
- Access fields directly:
  - `species.mass` (MeV/c²)
  - `species.charge` (units of e)
  - `species.spin` (ħ)
  - `species.moment` (J/T)
  - `species.iso` (mass number)
  - `species.kind` (ATOM, HADRON, LEPTON, PHOTON, NULL)
  - `species.name` or `nameof(species)` for isotope and charge information

## Examples

```julia
using APClite

# Physical constants
println("Speed of light: ", C_LIGHT, " m/s")
println("Electron mass: ", M_ELECTRON, " MeV/c²")

# Create particles
electron = Species("electron")
proton = Species("proton")
hydrogen = Species("H")
carbon12 = Species("C12")

# Access properties
println("Electron charge: ", electron.charge, " e")
println("Proton mass: ", proton.mass, " MeV/c²")
println("Hydrogen mass: ", hydrogen.mass, " MeV/c²")

# Display species
println(electron)
println(proton)
```

## Comparison with AtomicAndPhysicalConstants.jl

| Feature | APClite | AtomicAndPhysicalConstants |
|---------|---------|----------------------------|
| Dependencies | None | Unitful, DynamicQuantities, etc. |
| Compilation | Fast | Slower due to macros |
| Units | Plain Float64 | Unitful quantities |
| Macros | None | @APCdef required |
| Data sources | CODATA 2022 only | Multiple years available |
| API | Direct field access | Macro-based API |
