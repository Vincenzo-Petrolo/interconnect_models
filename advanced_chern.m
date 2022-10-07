% ECE 594 - Homework 1
% Advanced Chern showing the contributes
clf;
%//////////////////////////PARAMETERS///////////////////////////////////////////
W_trench  = 16; %nm                                                             % Nominal value, it's a variable
H_stack   = 64; %nm                                                             % Fixed
H_trench  = 32; %nm                                                             % Nominal value, it's a variable
K_lowk    = 2.2;                                                                % Fixed low-k dielectric constant
eps0      = 8.85e-12;                                                           % Fixed Vacuum dielectric constant
eps       = K_lowk*eps0;                                                        % Fixed dielectric constant
P_trench  = 32;                                                                 % Fixed, space between lines
CPP       = 42e-9;                                                              % Fixed, unit of wire length
%///////////////////////////////////////////////////////////////////////////////

%/////////////////////////////CHERN/////////////////////////////////////////////
% THIS MODEL DOESN'T TAKE INTO ACCOUNT SIDE-WALL DAMAGE
H_trench  = linspace(24, 56, 500);                                              % Create different Heights for trench
W_trench  = linspace(16, 28, 500);                                              % Create different Widths for trench
[W_trench, H_trench] = meshgrid(W_trench, H_trench);                            % Create the mesh for surfae plot
d_b       = H_stack - H_trench;                                                 % Compute distance from bottom plate
d_l       = P_trench - W_trench;                                                % Distance between interconnects
chern_gnd   = eps .* (W_trench./d_b);                                           % Chern parallel ground plane capacitance
chern_side  = eps .*( 3.28 .* (H_trench./(H_trench + 2.*d_b)).^0.023);          % Chern sidewall capacitance
chern_spac  = eps .*((d_l ./ (d_l + 2.*d_b)).^1.16);                            % Chern effects of spacing

chern_gnd   = chern_gnd ./ 1e-15 .* 1e-6;                                       % Transform in fF/um
chern_side   = chern_side ./ 1e-15 .* 1e-6;                                     % Transform in fF/um
chern_spac   = chern_spac ./ 1e-15 .* 1e-6;                                     % Transform in fF/um

                                                                                % Plotting stuff
figure(1);
[c, h] = contour(W_trench, H_trench, chern_gnd, "linewidth", 2, "g");
set(gca, "fontsize", 12)
clabel (c, h, "fontsize", 10);
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Chern parallel plate capacitance [fF/um]");

figure(2);
[c, h] = contour(W_trench, H_trench, chern_side, "linewidth", 2, "g");
set(gca, "fontsize", 12)
clabel (c, h, "fontsize", 10);
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Chern sidewall capacitance [fF/um]");

figure(3);
[c, h] = contour(W_trench, H_trench, chern_spac, "linewidth", 2, "g");
set(gca, "fontsize", 12)
clabel (c, h, "fontsize", 10);
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Chern spacing effects on parallel plate capacitance [fF/um]");
%///////////////////////////////////////////////////////////////////////////////

