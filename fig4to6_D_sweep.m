% Figures 4-6: Neumann BC, D sweep (baseline C=0.5, r1=0.1)
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

D_vals = [0.01, 0.001, 0.0001];
D_names = {'fig4_D0p01.png', 'fig5_D0p001.png', 'fig6_D0p0001.png'};
for i = 1:numel(D_vals)
    sol = bdf2Eq4(h,k,r1_base,R,radii_plaque_norm,D_vals(i),m_base,C_base,Beta);
    figure('Visible','off');
    plotG(sol, k, h, r1_base);
    set(gcf,'Theme','light');
    print(gcf, '-dpng', '-r300', [outdir D_names{i}]);
    close(gcf);
end
