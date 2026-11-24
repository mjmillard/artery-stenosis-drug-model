% Figure 3: Dirichlet vs Neumann BC comparison at baseline
%
% Standalone: run this file directly, no other script needs to run first.

here = fileparts(mfilename('fullpath'));
addpath(fullfile(here, 'functions'));
outdir = fullfile(here, 'output');
if ~exist(outdir, 'dir'); mkdir(outdir); end
outdir = [outdir filesep];

setup_geometry;

C_base = 0.5;
r1_base = 0.1;
m_base = 0.07*exp(2.49*C_base + (1107/T)*exp(-1.69*C_base));

D_base = 0.01;
solDiri = backEulerEq4Dirichlet(h,k,r1_base,R,radii_plaque_norm,D_base,m_base,C_base,Beta);
solNeum = backEulerEq4(h,k,r1_base,R,radii_plaque_norm,D_base,m_base,C_base,Beta);

fig3FontScale = 1.35; % Fig. 3 panels render at 0.48\textwidth vs ~0.6-0.7 for the others

figure('Visible','off');
plotG(solDiri, k, h, r1_base, fig3FontScale);
set(gcf,'Theme','light');
print(gcf, '-dpng', '-r300', [outdir 'fig3a_dirichlet.png']);
close(gcf);

figure('Visible','off');
plotG(solNeum, k, h, r1_base, fig3FontScale);
set(gcf,'Theme','light');
print(gcf, '-dpng', '-r300', [outdir 'fig3b_neumann.png']);
close(gcf);
