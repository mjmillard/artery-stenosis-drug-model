function sol = backEulerEq4(h,k,r1,R,radii_plaque_norm,K,m,C,Beta)
    % backward Euler, no-flux (Neumann) BC at r1, from blood_flow_finale.mlx
    z_cords_plaque = linspace(0.5,1.5,size(radii_plaque_norm,2));
    z_cords = linspace(0,2,k+1);
    r_vals = ones(1,k+1);
    r_vals(k/4+1:k-k/4+1) = interp1(z_cords_plaque,radii_plaque_norm,z_cords(k/4+1:k-k/4+1),'spline');

    delta_z = 2/k;
    delta_r = (R - r1)/h;
    lambda_0 = K*delta_z/(delta_r^2);

    sol = zeros(h+1,k+1);
    sol(:,1) = 0.5;

    for i = 2:k+1
        steps_plaque = floor((1-r_vals(i))/delta_r);
        mat_size = h-steps_plaque;

        r_cords = (r1:delta_r:1-(1+steps_plaque)*(delta_r))';
        lambda_1 = (K*delta_z)/(delta_r^2) * (r_cords+0.5*delta_r)./(r_cords);
        lambda_2 = (K*delta_z)/(delta_r^2) * (r_cords-0.5*delta_r)./(r_cords);
        U_f = computeVelocity(r1,(R-delta_r*steps_plaque),m,C,r_cords,Beta);
        main_diag = U_f + 2*lambda_0;

        lambda_1(1) = 2*lambda_0;
        lambda_1 = [0; lambda_1(1:end-1)];
        lambda_2 = [lambda_2(2:end); 0];

        A = spdiags([-lambda_2 main_diag -lambda_1],[-1 0 1],mat_size,mat_size);
        b = (U_f.*sol(1:h-steps_plaque,i-1));

        sol(1:h-steps_plaque,i) = A\b;
    end
end
