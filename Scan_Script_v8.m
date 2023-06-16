%% SCRIPT TO SCAN AND GENERATE STAIR-LIKE SIGNAL

clear; clc;

fig = 0; % Set to 0 to avoid graphs, or 1 to include them.

% == GLOBAL VARIABLES TO DECLARE
global x_vec y_vec z_vec amp_z amp_x amp_y Scan_stop ...
       speed x_old y_old z_old

% == PARAMETERS
Parameters;

xyz_mat     = readmatrix('to_scan3.csv'); % Matrix of final positions
x_vec       = 100;%xyz_mat(:,3) - 219.3;      % Vector of "X" positions
y_vec       = 0;%xyz_mat(:,2);              % Vector of "Y" positions
z_vec       = 0;%xyz_mat(:,1) + 25;         % Vector of "Z" positions
amp_x       = [];                        % Number of "X" steps vector
amp_y       = [];                        % Number of "Y" steps vector
amp_z       = [];                        % Number of "Z" steps vector
Scan_stop   = [];                        % Times of scanning vector

% == CONFIGURATION FOR THE MOTION
rev_step    = deg_step/360;              % [rev/step]
w           = Step_Rate*rev_step;        % [rev/s] Angular velocity.
speed       = xz.Lead*1000*w;            % [mm/s]   --> Linear velocity

% == CONFIGURATION FOR STEPPER MOTORS ('SM')
pos2amp = 1/xz.Lead/rev_step/1000;       % Position --> N steps
x_old   = 0;                             % Keep previous positions
z_old   = 0;
y_old   = 0;
t_old   = 0;                             % Keep previous time
time(1) = 0;                             % Initialize simulation time

Npoints = length(x_vec); % if i want to scan everything
%Npoints = 10;

% == LOOP TO COMPUTE STAIR-CASE SIGNAL TO INPUT IN SMs
for i = 1:length(x_vec)

    % == Displacement for first movement to be performed
    deltax = x_vec(i)-x_old; % [mm]
    deltay = y_vec(i)-y_old; % [mm]
    deltaz = z_vec(i)-z_old; % [mm]

    %Time for first movement
    dtx = abs(deltax/speed); % [s]
    dty = abs(deltay/speed); % [s]
    dtz = abs(deltaz/speed); % [s]

    % == Set discretized times at which amplitude shall change

    %time = | t0     | t0 + dtx | t0 + dtx + dtz | t0 + dtx + dtz + dty 
    %pos  = | move x | move z   | move y         | move x

    % == [t0, t0+dtx] --> Move x
    if dtx ~=0
        amp_x(end+1) = x_vec(i)*pos2amp;
        amp_z(end+1) = z_old*pos2amp;
        amp_y(end+1) = y_old*pos2amp;

        x_old  = x_vec(i);
        time(end+1)  = t_old + dtx;
        t_old = time(end);
    end

    % == [t0+dtx, t0+dtx+dtz] --> Move z
    if dtz ~=0
        amp_x(end+1) = x_old*pos2amp;
        amp_z(end+1) = z_vec(i)*pos2amp;
        amp_y(end+1) = y_old*pos2amp;

        z_old = z_vec(i);
        time(end+1)  = t_old + dtz;
        t_old = time(end);
    end

    % == [t0+dtx+dtz, t0+dtx+dtz+dty] --> Move y
    if dty ~= 0
        amp_x(end+1) = x_old*pos2amp;
        amp_z(end+1) = z_old*pos2amp;
        amp_y(end+1) = y_vec(i)*pos2amp;

        y_old = y_vec(i);
        time(end+1)  = t_old + dty;
        t_old = time(end);
    end

    amp_x(end+1) = amp_x(end);
    amp_y(end+1) = amp_y(end);
    amp_z(end+1) = amp_z(end);
    time(end+1) = time(end) + 2;
    Scan_stop(i) = time(end);

    % Compute interpolated values
    %B_field(i,1) = Bx(x_vec(i), y_vec(i), z_vec(i));
    %B_field(i,2) = By(x_vec(i), y_vec(i), z_vec(i));
    %B_field(i,3) = Bz(x_vec(i), y_vec(i), z_vec(i));

    % Update time

    t_old = time(end); %Account for 2 seconds for scan.

end

time  = time(1:end-1); % No movement at the end of the period.

% == FIGURES
if fig == true

    figure
    stairs(time, -amp_x/8)
    title('#Steps to move X axis')
    ylabel('#Steps')
    xlabel('Time [s]')

    figure
    stairs(time, amp_z/8)
    title('#Steps to move Z axis')
    ylabel('#Steps')
    xlabel('Time [s]')

    figure
    stairs(time, amp_y/8)
    title('#Steps to move Y axis')
    ylabel('#Steps')
    xlabel('Time [s]')

    figure
    stairs(time, amp_x)
    hold on
    stairs(time, amp_z)
    hold on
    stairs(time, amp_y)
    hold on
    title('#Steps to move axes')
    legend('X axis', 'Z axis', 'Y axis')
    ylabel('#Steps')
    xlabel('Time [s]')


    figure
    quiver3(x_vec, y_vec, z_vec, B_field(:,1), B_field(:,2), B_field(:,3))
    title('Magnetic field')
    xlabel('X')
    ylabel('Y')
    zlabel('Z')

end

% Inputs that should go to Simscape:
% --> "amp_x", "amp_y", "amp_z"
% --> "tvecx", "tvecy", "tvecz"
