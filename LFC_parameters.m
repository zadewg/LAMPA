clear all

%%
% SINGLE AREA LFC - from: https://www.researchgate.net/publication/222227238_AGC_for_autonomous_power_system_using_combined_intelligent_techniques


% PARAMS
% Governor time constant Tg = 0.08s
% Turbine time constant Tt = 0.3s
% Generator time constant Tp = 20s
% Kg = Kt = 1, Kp = 100
% Ki (integral control) = 0.325

%%
% exercise
% load varies 1/100 for 1/100 change in frequency. Freq deviation after change in load of 20 MW?

% rated capacity of the area: 2000 MW
rated_capacity = 2000;
% normal operating load: 1000 MW
nominal_load = 1000;
% nominal frequency: 50 Hz
nominal_freq = 50;
% inertia constant of the area: 5.0s
H = 5;
% speed regulation of all regulating generators: 4/100
R = 4/100;
% governor time constant: 0.08s
Tg = 0.08;
% turbine time constant: 0.3s
Tt = 0.3;
% damping constant: 1/100
damping_constant = 1/100;

%%
% ======================= CALCULATIONS ===================================

% steady state frequency deviation delta_f = -M/B (Hz), where:
%   M = change in load in p.u. = 20 / 2000 = 0.01 p.u. MW
M = 20 / rated_capacity;

%   B = area frequency response characteristics = D + (1/R), where:
%       D = dp_d/df and R is regulation
%
%       D = ( 1000 * (1/100) ) / ( 50 * (1/100) ) = 20 MW / Hz or 20/2000 =
%          0.01 p.u. MW / Hz (note nominal operating load and frequency are
%          used)
D = ( (nominal_load * 1/100) / (nominal_freq * 1/100) ) / rated_capacity;

%       R = (4/100) * 50 = 2 Hz / p.u. MW (4 percent of 50 Hz)
R = R * nominal_freq;

%   B = D + (1/R) = 0.01 + (1/2) = 0.51 p.u. MW / hz
B = D + (1/R);

% delta_f = -M/B = -0.01/0.51 = -0.0196 Hz
delta_f = -M/B;

% hence final frequency:
fnew = nominal_freq + delta_f;

%%
% =========================================================================


% governor gain 
Kg = 1;

% turbine gain
Kt = 1;

% generator (power system) GAIN
Kp = 1/D; % = 1/0.01 = 100

% generator (power system) time constant
Tp = (2*H) / (nominal_freq * D); % = (2*5) / (50 * 0.01) = 20s



% compensator (integral controller)
% Ki =  (1/(4KpTp)) * (1+(Kp/R))^2 = 0.325
Ki =  (1/(4*Kp*Tp)) * (1+(Kp/R))^2;

