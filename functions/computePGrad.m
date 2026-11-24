function dPdz = computePGrad(R,r1,C,Beta,m)
    % pressure gradient, from blood_flow_finale.mlx
    Q = 1;
    S = 4.5*((4 + 3*sqrt(8*C-3*C^2) + 3*C)/(2-3*C)^2);

    dPdz = -((8*(-1 + C)*Q*S*Beta^2.*log(R/r1))./((pi).*(R - r1).*(R + r1).*((8*(-1 + C)*C + ...
    (-1 + C*m).*(R - r1).*(R + r1)*S*Beta^2).*log(R/r1) + (-1 + C*m)*S*(Beta^2)*(-R.^2 + r1^2 - 2*r1^2*log(r1./R)))));
end
