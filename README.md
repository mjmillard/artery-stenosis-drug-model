# Artery Stenosis Drug Model

MATLAB code for simulating drug transport in blood flow through a stenosed
(plaque-narrowed) artery, using a two-phase (core/plasma layer) velocity
profile coupled to an axisymmetric advection-diffusion equation for drug
concentration `G(r,z)`. Generates the figures for an accompanying SIURO
paper.

## Model overview

- **Geometry**: the vessel radius `R(z)` is built from digitized
  atherosclerotic plaque cross-section data (Back et al.), normalized and
  splined onto a `(r,z)` grid ([setup_geometry.m](setup_geometry.m)).
- **Velocity field**: a two-phase (Newtonian core + peripheral plasma layer)
  velocity profile `U_f(r,z)` is derived from a closed-form pressure
  gradient that depends on hematocrit `C`, plasma-layer radius `r1`, and a
  viscosity parameter `m` ([computePGrad.m](functions/computePGrad.m),
  [computeVelocity.m](functions/computeVelocity.m)).
- **Drug transport**: `G(r,z)` solves an advection-diffusion equation with
  diffusivity `D` (called `K` in code) over the vessel cross-section, using
  finite differences in `r` marched forward in `z`. Two time-stepping
  schemes and two boundary conditions at the lumen centerline (`r1`) are
  provided:
  - Backward Euler, no-flux (Neumann) BC —
    [backEulerEq4.m](functions/backEulerEq4.m)
  - Backward Euler, Dirichlet BC —
    [backEulerEq4Dirichlet.m](functions/backEulerEq4Dirichlet.m)
  - BDF2, no-flux (Neumann) BC —
    [bdf2Eq4.m](functions/bdf2Eq4.m)

This code was ported/refactored from earlier exploratory Live Scripts
(`blood_flow_finale.mlx`, `blood_flow_2.mlx`); those are not included here.

## Repository layout

```
setup_geometry.m        Builds the plaque geometry R(z) and shared constants
main.m                  Runs all fig*.m scripts to regenerate every figure
fig1_geometry.m          Fig. 1  – R(z) geometry with stenosis annotation
fig2_velocity_field.m     Fig. 2  – 2D velocity field U_f(r,z) at baseline
fig3_bc_comparison.m      Fig. 3  – Dirichlet vs. Neumann BC comparison
fig4to6_D_sweep.m         Figs. 4-6  – diffusivity D sweep
fig7to9_C_sweep.m         Figs. 7-9  – hematocrit C sweep
fig10to12_r1_sweep.m      Figs. 10-12 – plasma-layer radius r1 sweep
functions/               Shared helper functions (see below)
output/                  Generated PNG figures (git-ignored, except as noted)
```

`functions/`:

| File | Purpose |
|---|---|
| [computePGrad.m](functions/computePGrad.m) | Pressure gradient `dP/dz` |
| [computeVelocity.m](functions/computeVelocity.m) | Two-phase velocity profile `U_f(r,z)` |
| [backEulerEq4.m](functions/backEulerEq4.m) | Backward Euler solver, Neumann BC |
| [backEulerEq4Dirichlet.m](functions/backEulerEq4Dirichlet.m) | Backward Euler solver, Dirichlet BC |
| [bdf2Eq4.m](functions/bdf2Eq4.m) | BDF2 solver, Neumann BC |
| [plotG.m](functions/plotG.m) | Shared heatmap plotting for `G(r,z)` solutions |

## Requirements

- MATLAB (no toolboxes beyond base MATLAB are required)

## Usage

Each `fig*.m` script is standalone — it can be run directly and will add
`functions/` to the path and create `output/` itself. To regenerate every
figure at once, run from the repo root:

```matlab
main
```

Figures are written as PNGs to `output/`.

## Key parameters

Set at the top of each figure script:

- `C` — hematocrit (fraction)
- `r1` — plasma-layer (core) radius
- `D` — drug diffusivity (`K` in the solver functions)
- `m` — viscosity ratio parameter, computed from `C` and temperature `T`
