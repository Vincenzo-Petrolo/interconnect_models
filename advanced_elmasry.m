% ECE 594 - Homework 1
% Advanced Elmasry showing the contributes

%//////////////////////////PARAMETERS///////////////////////////////////////////
W_trench  = 16; %nm                                                             % Nominal value, it's a variable
H_stack   = 64; %nm                                                             % Fixed
H_trench  = 32; %nm                                                             % Nominal value, it's a variable
K_lowk    = 2.2;                                                                % Fixed low-k dielectric constant
eps0      = 8.85e-12;                                                           % Fixed Vacuum dielectric constant
eps       = K_lowk*eps0;                                                        % Fixed dielectric constant
P_trench  = 32e-9;                                                              % Fixed, space between lines
CPP       = 42e-9;                                                              % Fixed, unit of wire length
%///////////////////////////////////////////////////////////////////////////////

%/////////////////////////////ELMASRY///////////////////////////////////////////
% THIS MODEL DOESN'T TAKE INTO ACCOUNT SIDE-WALL DAMAGE
H_trench  = linspace(24, 56, 100);                                              % Create different Heights for trench
W_trench  = linspace(16, 28, 100);                                              % Create different Widths for trench
[W_trench, H_trench] = meshgrid(W_trench, H_trench);                            % Create the mesh for surfae plot
d_b       = H_stack - H_trench;                                                 % Compute distance from bottom plate
C_bottom  = eps .* W_trench ./ d_b;                                             % Bottom plate capacitance per unit length
elmasry_bottom   = C_bottom;                                                    % Elmasry bottom plate component
elmasry_sideweall = C_bottom .* 2 .*d_b./W_trench.*log(1 + H_trench./d_b);       % Elmasry sidewall fringe capacitance
elmasry_topfringe = C_bottom .* 2.*H_trench./W_trench.*log(1+(W_trench./2)
                    ./(d_b+H_trench));                                          % Elmasry top side fringe capacitance

elmasry_bottom      = elmasry_bottom ./ 1e-15 .* 1e-6;                          % Transform in fF/um
elmasry_sideweall   = elmasry_sideweall ./ 1e-15 .* 1e-6;                       % Transform in fF/um
elmasry_topfringe   = elmasry_topfringe ./ 1e-15 .* 1e-6;                       % Transform in fF/um

figure(1);                                                                      % Plot the bottom capacitance
[c, h] = contour(W_trench(1,:), H_trench(:,1), elmasry_bottom, "linewidth", 2, "g");

xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Elmasry model bottom capacitance[fF/um]");
clabel (c, h, "fontsize", 12);

figure(2);                                                                      % Plot the sidewall fringe capacitance
[c, h] = contour(W_trench, H_trench, elmasry_sideweall, "linewidth", 2, "g");
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Elmasry model sidewall fringe capacitance[fF/um]");
clabel (c, h, "fontsize", 10);

figure(3);                                                                      % Plot the top fringe capacitance
[c, h] = contour(W_trench, H_trench, elmasry_topfringe, "linewidth", 2, "g");
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Elmasry model top fringe capacitance[fF/um]");
clabel (c, h, "fontsize", 10);

%///////////////////////////////////////////////////////////////////////////////

