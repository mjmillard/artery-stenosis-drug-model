% Atherosclerosis geometry data (Back et al.), from blood_flow_finale.mlx
x_cords_data_plaque = [2.9 3.2 3.5 3.7 4.0 4.3 4.6 4.9 5.2 5.5 5.8 6.1 6.4 6.6 6.9 7.2 7.5 7.8 8.1 8.4 8.7 9.0...
                       9.3 9.5 9.8 10.1 10.4 10.7 11.0 11.3 11.6 11.9 12.2 12.5 12.7 13.0 13.3 13.6 13.9 14.2...
                       14.5 14.8 15.1 15.4 15.6 15.9 16.2 16.5 16.8 17.1 17.4 17.7 18.0 18.3 18.5 18.8 19.1...
                       19.4 19.7 20.0 20.3 20.6 20.9 21.1 21.4 21.7 22.0 22.3 22.6 22.9 23.2 23.5 23.8 24.1...
                       24.4 24.6 24.9 25.2 25.5 25.8 26.1 26.4 26.7 27.0 27.3 27.5 27.8 28.1 28.4 28.7 29.0...
                       29.3 29.6];

area_plaque = [7.4 7.5 7.3 7.6 7.5 7.5 7.5 7.6 7.7 7.7 7.6 7.6 7.5 7.6 7.6 7.4 7.3 7.1 7.1 7.0 6.7 6.8...
               6.6 6.1 6.1 5.8 5.8 5.7 5.7 5.6 5.4 5.3 5.2 5.1 4.9 5.0 4.9 4.8 4.8 4.9 5.0 5.1 5.0 4.9...
               4.8 4.7 4.5 4.4 4.1 3.9 4.0 4.0 4.0 3.9 3.9 4.0 4.0 4.1 4.1 4.1 4.1 4.4 4.8 5.0 5.3 5.6...
               5.8 6.1 6.0 6.1 6.1 6.0 5.8 5.6 5.6 5.8 6.0 6.4 6.6 6.7 6.8 6.7 6.8 6.9 7.2 7.2 7.1 7.0...
               6.9 7.0 7.3 7.2 7.1];

radii_plaque = sqrt(area_plaque*(1/pi));
radii_plaque_norm = radii_plaque/max(radii_plaque);

% exclude first 15 entries of data, pad ones (as in blood_flow_finale.mlx)
radii_plaque_norm = radii_plaque_norm(16:end);
radii_plaque_norm = [1 radii_plaque_norm 1];

% grid init, same as blood_flow_finale.mlx
h = 360; % r grid step count
k = 800; % z grid step count
z_cords = linspace(0,2,k+1);
r_vals = ones(1,k+1);
z_cords_plaque = linspace(0.5,1.5,size(radii_plaque_norm,2));
r_vals(k/4+1:k-k/4+1) = interp1(z_cords_plaque,radii_plaque_norm,z_cords(k/4+1:k-k/4+1),'spline');

R = 1;
T = 310.5; % 98.6 F
Beta = (1 - min(radii_plaque_norm))/0.004; % geometric, independent of C
