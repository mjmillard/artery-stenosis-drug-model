function sol = bdf2Eq4(h,k,r1,R,radii_plaque_norm,K,m,C,Beta)
    % BDF2, no-flux (Neumann) BC at r1, from blood_flow_finale.mlx
    z_cords_plaque = linspace(0.5,1.5,size(radii_plaque_norm,2));
    z_cords = linspace(0,2,k+1);
    r_vals = ones(1,k+1);
    r_vals(k/4+1:k-k/4+1) = interp1(z_cords_plaque,radii_plaque_norm,z_cords(k/4+1:k-k/4+1),'spline');

    delta_z = 2/k;
    delta_r = (R - r1)/h;

    r_cords = (r1:delta_r:1-delta_r)';
    lambda_0 = K*delta_z/(delta_r^2);
    lambda_1 = (K*delta_z)/(delta_r^2) * (r_cords+0.5*delta_r)./(r_cords);
    lambda_2 = (K*delta_z)/(delta_r^2) * (r_cords-0.5*delta_r)./(r_cords);
    U_f = computeVelocity(r1,R,m,C,r_cords,Beta);

    lambda_1(1) = 2*lambda_0;
    lambda_1 = [0; lambda_1(1:end-1)];
    lambda_2 = [lambda_2(2:end); 0];

    sol = zeros(h+1,k+1);
    sol(:,1) = 0.5;

    main_diag_star = U_f + lambda_0;
    star_mat = spdiags([-lambda_2/2 main_diag_star -lambda_1/2],[-1 0 1],h,h);
    G_star = star_mat\(U_f.*sol(1:h,1));

    main_diag_one = 3*U_f + 2*lambda_0;
    one_mat = spdiags([-lambda_2 main_diag_one -lambda_1],[-1 0 1],h,h);
    sol(1:h,2) = one_mat\(U_f.*(4*G_star-sol(1:h,1)));

    for i = 3:k+1
        steps_plaque = floor((1-r_vals(i))/delta_r);
        mat_size = h-steps_plaque;

        r_cords = (r1:delta_r:1-(1+steps_plaque)*(delta_r))';
        lambda_1 = (K*delta_z)/(delta_r^2) * (r_cords+0.5*delta_r)./(r_cords);
        lambda_2 = (K*delta_z)/(delta_r^2) * (r_cords-0.5*delta_r)./(r_cords);
        U_f = computeVelocity(r1,(R-delta_r*steps_plaque),m,C,r_cords,Beta);
        main_diag = 3*U_f + 4*lambda_0;

        lambda_1(1) = 2*lambda_0;
        lambda_1 = [0; lambda_1(1:end-1)];
        lambda_2 = [lambda_2(2:end); 0];

        A = spdiags([-2*lambda_2 main_diag -2*lambda_1],[-1 0 1],mat_size,mat_size);
        b = (U_f.*(4*sol(1:h-steps_plaque,i-1)-sol(1:h-steps_plaque,i-2)));

        sol(1:h-steps_plaque,i) = A\b;
    end
end
