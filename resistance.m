% ECE 594 - Homework 1
% Resistance models
clf;
%//////////////////////////PARAMETERS///////////////////////////////////////////
ro  = mean([103 89 98]);                                                        % Assuming uniformly distributed resisitivity on the section
                                                                                % Got it by using the mean of experiments from Table 1.
W_trench = 6;                                                                   % Variable width for the trench interconnect
H_trench = 10;                                                                  % Variable heigth for the trench interconnect
T_w = 6;                                                                        % Thickness of horizontal diffusion barrier [nm]
T_h = 3;                                                                        % Thickness of vertical diffusion barrier [nm]
%///////////////////////////////////////////////////////////////////////////////


%//////////////////////////NO PARASITICS////////////////////////////////////////
W_trench = linspace(6, 34, 100);
H_trench = linspace(10, 90, 100);
[W_trench, H_trench] = meshgrid(W_trench, H_trench);
R = ro ./(W_trench .* H_trench);                                                % Formula for resistance
R = R .* 1e3;                                                                   % Transform in ohm/um
                                                                                % Plot the contour

W_trench = linspace(16, 28, 100);

figure(1);                                                                      % 2D plot of R(W) with three different fixed heights of trench
R = ro ./(W_trench .* 32);                                                      % Formula for resistance with Height 32nm
R = R .* 1e3;                                                                   % Transform in ohm/um
plot(W_trench, R, "linewidth", 2, "g; H_{trench} = 32nm;");
hold on;
R = ro ./(W_trench .* 46);                                                      % Formula for resistance with Height 46nm
R = R .* 1e3;                                                                   % Transform in ohm/um
plot(W_trench, R, "linewidth", 2, "b; H_{trench} = 46nm;");
hold on;
R = ro ./(W_trench .* 56);                                                      % Formula for resistance with Height 56nm
R = R .* 1e3;                                                                   % Transform in ohm/um
plot(W_trench, R, "linewidth", 2, "r; H_{trench} = 56nm;");
xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Resistance without parasitcs [ohm/um]");
%///////////////////////////////////////////////////////////////////////////////



%//////////////////////DIFFUSION BARRIER////////////////////////////////////////
W_trench = linspace(6, 34, 500);
H_trench = linspace(10, 90, 500);
[W_trench, H_trench] = meshgrid(W_trench, H_trench);
Ad  = T_w .* W_trench .* 2 + T_h .* (H_trench - 2.* T_w) .* 2;                  % Area of the diffusion barrier
ro_b = ro ./ (1 - Ad./(W_trench .* H_trench));                                  % Resistivity taking into account diffusion barrier
R = ro_b ./(W_trench .* H_trench);                                              % Formula for resistance
R = R .* 1e3;                                                                   % Transform in ohm/um
                                                                                % Plot the contour

W_trench = linspace(16, 28, 500);

figure(2);                                                                      % 2D plot of R(W) with three different fixed heights of trench
Ad  = T_w .* W_trench .* 2 + T_h .* (32 - 2.* T_w) .* 2;                        % Area of the diffusion barrier
ro_b = ro ./ (1 - Ad./(W_trench .* 32));                                        % Resistivity taking into account diffusion barrier
R = ro_b ./(W_trench .* 32);                                                    % Formula for resistance with Height 32nm
R = R .* 1e3;                                                                   % Transform in ohm/um
plot(W_trench, R, "linewidth", 2, "g; H_{trench} = 32nm;");


hold on;
Ad  = T_w .* W_trench .* 2 + T_h .* (46 - 2.* T_w) .* 2;                        % Area of the diffusion barrier
ro_b = ro ./ (1 - Ad./(W_trench .* 46));                                        % Resistivity taking into account diffusion barrier
R = ro_b ./(W_trench .* 46);                                                    % Formula for resistance with Height 32nm
R = R .* 1e3;                                                                   % Transform in ohm/um
plot(W_trench, R, "linewidth", 2, "b; H_{trench} = 46nm;");

hold on;
Ad  = T_w .* W_trench .* 2 + T_h .* (46 - 2.* T_w) .* 2;                        % Area of the diffusion barrier
ro_b = ro ./ (1 - Ad./(W_trench .* 46));                                        % Resistivity taking into account diffusion barrier
R = ro_b ./(W_trench .* 56);                                                    % Formula for resistance with Height 32nm
R = R .* 1e3;                                                                   % Transform in ohm/um
plot(W_trench, R, "linewidth", 2, "r; H_{trench} = 56nm;");


xlabel("W_{trench} [nm]");
ylabel("H_{trench} [nm]");
title("Resistance with diffusion barrier [ohm/um]");
%///////////////////////////////////////////////////////////////////////////////

