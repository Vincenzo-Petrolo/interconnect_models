% ECE 594 - Homework 1
% Advanced Sakurai showing the contributes
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

%/////////////////////////////SAKURAI///////////////////////////////////////////
% THIS MODEL DOESN'T TAKE INTO ACCOUNT SIDE-WALL DAMAGE
H_trench  = linspace(24, 56, 500);                                              % Create different Heights for trench
W_trench  = linspace(16, 28, 500);                                              % Create different Widths for trench
[W_trench, H_trench] = meshgrid(W_trench, H_trench);                            % Create the mesh for surfae plot
d_b       = H_stack - H_trench;                                                 % Compute distance from bottom plate
sakurai_tb    = eps .* (1.15 .*W_trench./d_b);                                  % Sakurai top-bottom contributes
sakurai_side  = eps .* 2.8.*(H_trench./d_b).^0.222;                             % Sakurai sidewall contributes

sakurai_tb      = sakurai_tb ./ 1e-15 .* 1e-6;                                  % Transform in fF/um
sakurai_side    = sakurai_side ./ 1e-15 .* 1e-6;                                % Transform in fF/um

                                                                                % Plotting stuff

figure(1);                                                                      % Plot the bottom capacitance
[c, h] = contour(W_trench(1,:), H_trench(:,1), sakurai_tb, "linewidth", 2, "g");

xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Sakurai model top and bottom capacitance[fF/um]");
clabel (c, h, "fontsize", 12);
figure(2);                                                                      % Plot the bottom capacitance
[c, h] = contour(W_trench(1,:), H_trench(:,1), sakurai_side, "linewidth", 2, "g");

xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Sakurai model sidewall capacitance[fF/um]");
clabel (c, h, "fontsize", 12);
%///////////////////////////////////////////////////////////////////////////////
