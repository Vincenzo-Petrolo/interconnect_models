% ECE 594 - Homework 1
% Capacitance using different models
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

%/////////////////////////////ELMASRY///////////////////////////////////////////
% THIS MODEL DOESN'T TAKE INTO ACCOUNT SIDE-WALL DAMAGE
H_trench  = linspace(24, 56, 500);                                              % Create different Heights for trench
W_trench  = linspace(16, 28, 500);                                              % Create different Widths for trench
[W_trench, H_trench] = meshgrid(W_trench, H_trench);                            % Create the mesh for surfae plot
d_b       = H_stack - H_trench;                                                 % Compute distance from bottom plate
C_bottom  = eps .* W_trench ./ d_b;                                             % Bottom plate capacitance per unit length
elmasry   = C_bottom .* (1 +
                        2.*d_b./W_trench.*log(1 + H_trench./d_b) +
                        2.*H_trench./W_trench.*log(1+(W_trench/2)./(d_b+H_trench
                        )));                                                    % Elmasry model computation

elmasry   = elmasry ./ 1e-15 .* 1e-6;                                           % Transform in fF/um
figure(1);
[c, h] = contour(W_trench, H_trench, elmasry, "linewidth", 2, "g");
set(gca, "fontsize", 12)
clabel (c, h, "fontsize", 10);
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Elmasry model capacitance per unit of length [fF/um]");
%///////////////////////////////////////////////////////////////////////////////


%/////////////////////////////SAKURAI///////////////////////////////////////////
% THIS MODEL DOESN'T TAKE INTO ACCOUNT SIDE-WALL DAMAGE
H_trench  = linspace(24, 56, 500);                                              % Create different Heights for trench
W_trench  = linspace(16, 28, 500);                                              % Create different Widths for trench
[W_trench, H_trench] = meshgrid(W_trench, H_trench);                            % Create the mesh for surfae plot
d_b       = H_stack - H_trench;                                                 % Compute distance from bottom plate
sakurai   = eps .* (1.15 .*W_trench./d_b + 2.8.*(H_trench./d_b).^0.222);

sakurai   = sakurai ./ 1e-15 .* 1e-6;                                           % Transform in fF/um
                                                                                % Plotting stuff
figure(2);
[c, h] = contour(W_trench, H_trench, sakurai, "linewidth", 2, "g");
set(gca, "fontsize", 12)
clabel (c, h, "fontsize", 10);
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Sakurai model capacitance per unit of length [fF/um]");
%///////////////////////////////////////////////////////////////////////////////


%/////////////////////////////CHERN/////////////////////////////////////////////
% THIS MODEL DOESN'T TAKE INTO ACCOUNT SIDE-WALL DAMAGE
H_trench  = linspace(24, 56, 500);                                              % Create different Heights for trench
W_trench  = linspace(16, 28, 500);                                              % Create different Widths for trench
[W_trench, H_trench] = meshgrid(W_trench, H_trench);                            % Create the mesh for surfae plot
d_b       = H_stack - H_trench;                                                 % Compute distance from bottom plate
d_l       = P_trench - W_trench;                                                % Distance between interconnects
chern   = eps .* (W_trench./d_b + 3.28 .* (H_trench./(H_trench + 2.*d_b)).^0.023 +
            (d_l ./ (d_l + 2.*d_b)).^1.16);                                      % Chern model

chern   = chern ./ 1e-15 .* 1e-6;                                               % Transform in fF/um
                                                                                % Plotting stuff
figure(3);
[c, h] = contour(W_trench, H_trench, chern, "linewidth", 2, "g");
set(gca, "fontsize", 12)
clabel (c, h, "fontsize", 10);
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Chern model capacitance per unit of length [fF/um]");
%///////////////////////////////////////////////////////////////////////////////



