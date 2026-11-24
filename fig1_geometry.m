% Figure 1: R(z) geometry, annotated with stenosis peak
%
% Standalone: run this file directly, no other script needs to run first.

here = fileparts(mfilename('fullpath'));
outdir = fullfile(here, 'output');
if ~exist(outdir, 'dir'); mkdir(outdir); end
outdir = [outdir filesep];

setup_geometry;

[Rmin, idx_min] = min(r_vals);
z_peak = z_cords(idx_min);
stenosis_pct = (1 - Rmin^2) * 100; % area-based reduction, R normalized to 1

fprintf('Figure 1 stats: stenosis = %.1f%% area reduction at z = %.3f\n', stenosis_pct, z_peak);

figure('Visible','off');
plot(z_cords, r_vals, 'b-', 'LineWidth', 1.25);
hold on
plot(z_peak, Rmin, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7);
text(z_peak + 0.05, Rmin, sprintf('%.1f%% area reduction', stenosis_pct), 'Color', 'r', 'FontSize', 16);
hold off
axis([0 2 0.7 1.05])
set(gca, 'FontSize', 16)
xlabel('z-axis', 'FontSize', 18)
ylabel('R(z)', 'FontSize', 18)
set(gcf,'Theme','light');
print(gcf, '-dpng', '-r300', [outdir 'fig1_geometry.png']);
close(gcf);
