% Generates all 12 figures for the SIURO paper by running each fig
% script in turn. Each fig script is also standalone and can be run by
% itself instead.
clear; clc;

fig1_geometry;
fig2_velocity_field;
fig3_bc_comparison;
fig4to6_D_sweep;
fig7to9_C_sweep;
fig10to12_r1_sweep;

fprintf('All figures written to %s\n', outdir);
