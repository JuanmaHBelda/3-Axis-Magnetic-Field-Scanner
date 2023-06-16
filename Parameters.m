% ==  SCRIPT FOR PARAMETERS

%% =  PULSE SYSTEM PARAMETERS

Step_Rate = 200; %[steps/s] ---- Nominal value 200 pps

%% =  CARRIAGES MASS
% Default (nominal) values:
% mx = 1.557096 [kg]
% my = 0.574990 [kg]
% mz = 1.557196 [kg]

mx = 1.557096;
my = 0.574990;
mz = 1.557196;

%% =  LEAD SCREW PARAMETERS
% Default parameters:
% Coefficient of kinetic friction:  F_k  = 0.205;
% Coefficient of static friction:   F_s  = 0.205;
% Velocity threshold [m/s]:         Vth  = 1e-3;
% Lead of screw [m/rev]:            Lead = 0.025;
% Screw radius [m]:                 R_s  = 0.005;
% Low pass filter constant [s]:     Lpc  = 1e-3;

x.F_k     = 0.205;
x.F_s     = 0.205;
x.Vth     = 1e-3;
x.Lead    = 0.025;
x.R_s     = 0.005;
x.Lpc     = 1e-3;

z.F_k     = 0.36;
z.F_s     = 0.205;
z.Vth     = 1e-3;
z.Lead    = 0.025;
z.R_s     = 0.005;
z.Lpc     = 1e-3;

y.F_k     = 0.205;
y.F_s     = 0.205;
y.Vth     = 1e-3;
y.Lead    = 0.025;
y.R_s     = 0.005;
y.Lpc     = 1e-3;


%% =  STEPPER MOTOR PARAMETERS
% Default parameters (ELECTRICAL TORQUE)
% Simulation mode:                  stepping
% Phase winding resistance [Ohm]:   R_pw        = 2.8;
% Phase winding inductance [H]:     i_pw        = 3.8*1e-3;
% Motor torque constant [N*m/A]:    Mtc         = 0.266667;
% Detent torque [N*m]:              T_d         = 0;
% Magnetizing resistance [Ohm]:     R_m         = Inf;
% Full step size [deg]:             deg_step    = 1.8;

% Default parameters (Mechanical)
% Rotor inertia [kg*m^2]            R_I         = 1.2e-6;
% Rotor damping [N*m/(rad/s)]       R_D         = 1e-2;
% Initial rotor speed [rpm]         R_v0        = 0;
% Initial rotor angle [deg]         R_ang0      = 0;


% For x & y axes NEMA 14 %

R_pw        = 2.8;
i_pw        = 3.8*1e-3;
Mtc         = 0.26666667;
T_d         = 0;
R_m         = Inf;
deg_step    = 1.8;

R_I         = 1.2*1e-6;
R_D         = 1e-2;
R_v0        = 0;
R_ang0      = 0;

% For z axis NEMA 17

z.R_pw        = 1.75;
z.i_pw        = 3.3*1e-3;
z.Mtc         = 0.2666667;
z.T_d         = 0.022;
z.R_m         = Inf;
z.deg_step    = 1.8;

z.R_I         = 1.2*1e-6;
z.R_D         = 1e-2;
z.R_v0        = 0;
z.R_ang0      = 0;


