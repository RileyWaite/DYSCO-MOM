% ******************
%   Riley Waite & Andrew Schiffman
%   Comp Apps 1
%   Mini-Project 3 Class Trajectory
% ******************

classdef Trajectory
    properties
        % Position Coordinates (m)
        x
        y
        z
        
        % Velocity Components (m/s)
        vx
        vy
        vz
        
        % Time
        t
        
        % Timestep
        dt
        
        % Input parameters
        eta
        theta
        omega
        
        % Project Specific Quantities
        targ
        dist
        PI
    end
    methods
        function [obj] = Trajectory(theta,eta,omega,dt,targ)
            %% Parameters
            obj.eta = eta; % deg
            obj.theta = theta; % deg
            obj.omega = omega; % rad
            obj.targ = targ; % m
            
            obj.dt = dt; % s

            obj.x(1) = 0; % m
            obj.y(1) = 0; % m
            obj.z(1) = 0; % m
            obj.t(1) = 0; % s

            m = 0.43; % kg
            g = 9.81; % m/s^2
            k1 = 0.0025; % kg
            k2 = 0.0228; % kg/m
            Cd = 0.24;
            v0 = 25; % m/s

            %% Initializing Trajectory
            obj.vx(1) = v0*cosd(eta)*cosd(theta);
            obj.vy(1) = v0*cosd(eta)*sind(theta);
            obj.vz(1) = v0*sind(eta);

            %% Euler Method Loop
            i = 1;

            % While above the ground
            while obj.z(i) >= 0
                % Magnitude of velocity
                V = sqrt(obj.vx(i)^2+obj.vy(i)^2+obj.vz(i)^2);

                % Componential velocity integration
                obj.vx(i+1) = obj.vx(i) + dt*( (-k1/m)*omega*obj.vy(i) - (k2/m)*Cd*V*obj.vx(i) );
                obj.vy(i+1) = obj.vy(i) + dt*( (k1/m)*omega*obj.vx(i) - (k2/m)*Cd*V*obj.vy(i) );
                obj.vz(i+1) = obj.vz(i) - dt*( g + (1/m)*k2*Cd*V*obj.vz(i) );

                % Componential position integration
                obj.x(i+1) = obj.x(i) + obj.vx(i)*dt;
                obj.y(i+1) = obj.y(i) + obj.vy(i)*dt;
                obj.z(i+1) = obj.z(i) + obj.vz(i)*dt;

                % Time increment
                obj.t(i+1) = obj.t(i) + dt;

                i = i + 1;
            end

            %% Deleting the below-zero coordinate
            obj.vx(end) = [];
            obj.vy(end) = [];
            obj.vz(end) = [];
            obj.x(end) = [];
            obj.y(end) = [];
            obj.z(end) = [];
            obj.t(end) = [];
            
            %% Calculating distance and PI
            obj.dist = sqrt(obj.x(end)^2+obj.y(end)^2+obj.z(end)^2);
            
            derr = sqrt((obj.x(end)-targ(1))^2+(obj.y(end)-targ(2))^2);
            dtarg = sqrt(targ(1)^2+targ(2)^2);
            obj.PI = obj.t(end)/(dtarg/v0) + (derr/dtarg)*10;
        end
    end
end