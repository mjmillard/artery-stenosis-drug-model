function U_f = computeVelocity(r1,R,m,C,r_cords,Beta)
    % two-phase velocity profile, from blood_flow_finale.mlx
    dPdz = computePGrad(R,r1,C,Beta,m);
    U_f = (-(1-m*C)/(4*(1-C)))*dPdz*(R^2 - r_cords.^2 + ((R^2 - r1^2)*log(r_cords./R))./(log(R/r1)));
end
