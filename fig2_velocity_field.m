% Figure 2: 2D velocity field U_f(r,z) at baseline (C=0.5, r1=0.1)
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

r_grid = linspace(r1_base, 1, h+1)';
vel_field = nan(h+1, k+1);
for j = 1:k+1
    Rz = r_vals(j);
    valid = r_grid <= Rz;
    vel_field(valid, j) = computeVelocity(r1_base, Rz, m_base, C_base, r_grid(valid), Beta);
end

figure('Visible','off');
im = imagesc(vel_field);
set(im, 'AlphaData', ~isnan(vel_field));
set(gca, 'YDir', 'normal', 'FontSize', 16);
colormap(jet)
cb = colorbar;
set(cb, 'FontSize', 16);
ylabel(cb, 'U_f Value', 'FontSize', 18)
ylabel('r-axis', 'FontSize', 18)
xlabel('z-axis', 'FontSize', 18)
xticks([1 k/4+1 k/2+1 k-k/4+1 k+1])
xticklabels({'0', '0.5', '1.0', '1.5', '2.0'})
yticks(linspace(1, h+1, 10))
yticklabels(arrayfun(@(v) sprintf('%.2f', v), linspace(r1_base, 1, 10), 'UniformOutput', false))
set(gcf,'Theme','light');
print(gcf, '-dpng', '-r300', [outdir 'fig2_velocity_field.png']);
close(gcf);
