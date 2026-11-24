% Figures 10-12: Neumann BC, r1 sweep (baseline D=0.01, C=0.5)
%
% Standalone: run this file directly, no other script needs to run first.

here = fileparts(mfilename('fullpath'));
addpath(fullfile(here, 'functions'));
outdir = fullfile(here, 'output');
if ~exist(outdir, 'dir'); mkdir(outdir); end
outdir = [outdir filesep];

setup_geometry;

C_base = 0.5;
D_base = 0.01;
m_base = 0.07*exp(2.49*C_base + (1107/T)*exp(-1.69*C_base));

r1_vals = [0.05, 0.2, 0.3];
r1_names = {'fig10_r1_0p05.png', 'fig11_r1_0p2.png', 'fig12_r1_0p3.png'};
for i = 1:numel(r1_vals)
    r1i = r1_vals(i);
    sol = bdf2Eq4(h,k,r1i,R,radii_plaque_norm,D_base,m_base,C_base,Beta);
    figure('Visible','off');
    plotG(sol, k, h, r1i);
    set(gcf,'Theme','light');
    print(gcf, '-dpng', '-r300', [outdir r1_names{i}]);
    close(gcf);
end
