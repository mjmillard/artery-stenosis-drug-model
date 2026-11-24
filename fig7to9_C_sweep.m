% Figures 7-9: Neumann BC, C sweep (baseline D=0.01, r1=0.1)
%
% Standalone: run this file directly, no other script needs to run first.

here = fileparts(mfilename('fullpath'));
addpath(fullfile(here, 'functions'));
outdir = fullfile(here, 'output');
if ~exist(outdir, 'dir'); mkdir(outdir); end
outdir = [outdir filesep];

setup_geometry;

r1_base = 0.1;
D_base = 0.01;

C_vals = [0.35, 0.40, 0.55];
C_names = {'fig7_C0p35.png', 'fig8_C0p40.png', 'fig9_C0p55.png'};
for i = 1:numel(C_vals)
    Ci = C_vals(i);
    mi = 0.07*exp(2.49*Ci + (1107/T)*exp(-1.69*Ci));
    sol = bdf2Eq4(h,k,r1_base,R,radii_plaque_norm,D_base,mi,Ci,Beta);
    figure('Visible','off');
    plotG(sol, k, h, r1_base);
    set(gcf,'Theme','light');
    print(gcf, '-dpng', '-r300', [outdir C_names{i}]);
    close(gcf);
end
