% ******************
%   Mini Project 3
%   Riley Waite & Andrew Schiffman
%   Comp Apps 1
% ******************

%% Script preproccess tidying
clear variables
clc
close all;
fclose all;

%% Parameters
% Timestep
dt = 0.001; % s
% Target
targ = [-15 25]; % m

%% Accuracy Definitions
% How many layers of scope-reducing recursion
Recurse = 7;
% Delta divisor for initial sweep
SplitCount = 10;
% Delta fraction on scope reduction
Frac = 3;
% Width of re-focus on scope reduction (in multiples of delta)
Wide = 3;

%% Initial Ranges
Aeta = 0;
Beta = 60;

Atheta = 30;
Btheta = 150;

Aomega = 60;
Bomega = 120;

%% Initial splitting range
deta = (Beta-Aeta)/SplitCount;
dtheta = (Btheta-Atheta)/SplitCount;
domega = (Bomega-Aomega)/SplitCount;

%% Recursive scope loop
for Loopy = 1:Recurse
    %% Cleanup previous (if any) trajectory matrix
    clear Trajectories
    
    %% Applying scope ranges
    eta = Aeta:deta:Beta;
    theta = Atheta:dtheta:Btheta;
    omega = Aomega:domega:Bomega;

    %% Welcome to the Combination Station
    % Creates a list of possibile combinations
    PosList = 1:SplitCount+1;
    cv = combvec(PosList,PosList,PosList);

    %% Populating Trajectories Vector
    for i = 1:size(cv,2)
        % Creates trajectory plots for every combination of parameters
        Trajectories(i) = Trajectory(theta(cv(1,i)),eta(cv(2,i)),omega(cv(3,i)),dt,targ);
    end

    %% Minimizing PI
    minVec = [Trajectories(:).PI];
    [~,Ind] = min(minVec);
    
    %% Just break if it's the last time...
    % This saves us the computation of rescoping on the last iteration
    if Loopy == Recurse
        break
    end

    %% Re-scoping and re-splitting
    Aeta = Trajectories(Ind).eta - Wide*deta;
    Beta = Trajectories(Ind).eta + Wide*deta;

    Atheta = Trajectories(Ind).theta - Wide*dtheta;
    Btheta = Trajectories(Ind).theta + Wide*dtheta;

    Aomega = Trajectories(Ind).omega - Wide*domega;
    Bomega = Trajectories(Ind).omega + Wide*domega;

    deta = deta / Frac;
    dtheta = dtheta / Frac;
    domega = domega / Frac;
end

%% Winner, Winner, ...
ChickenDinner = Trajectories(Ind); % Best trajectory

%% Plotting
x = ChickenDinner.x;
y = ChickenDinner.y;
z = ChickenDinner.z;
t = ChickenDinner.t;
%targ = ChickenDinner.targ;

% Plots trajectory curve and target
plot3(x,y,z,targ(1),targ(2),0,'rh');
xlabel('x(m)'); ylabel('y(m)'); zlabel('z(m)');
grid on;

%% Debugging outputs
ChickenDinner

fprintf('tf=%f\npos=<%f,%f,%f>\n',t(end),x(end),y(end),z(end));
fprintf('PI=%f\n',ChickenDinner.PI);
