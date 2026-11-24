function plotG(sol, n, m, r1, fontScale)
    % shared heatmap styling for G(r,z) solutions. fontScale compensates
    % figures rendered at a smaller page-width fraction (e.g. Fig 3's
    % side-by-side panels) so on-page text size stays consistent.
    if nargin < 5
        fontScale = 1.0;
    end
    tickFont = 16*fontScale;
    labelFont = 18*fontScale;

    imagesc(sol)
    set(gca, 'YDir', 'normal', 'FontSize', tickFont);
    colormap(jet)
    caxis([0 0.5]);
    cb = colorbar;
    set(cb, 'FontSize', tickFont);
    ylabel(cb, 'G Value', 'FontSize', labelFont)
    ylabel('r-axis', 'FontSize', labelFont)
    xlabel('z-axis', 'FontSize', labelFont)
    xticks([1 n/4+1 n/2+1 n-n/4+1 n+1])
    xticklabels({'0', '0.5', '1.0', '1.5', '2.0'})
    yticks(linspace(1, m+1, 10))
    yticklabels(arrayfun(@(v) sprintf('%.2f', v), linspace(r1, 1, 10), 'UniformOutput', false))
end
