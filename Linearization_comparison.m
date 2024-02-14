init;

perturbation = 0.15;

%% Pendulum down
eq = [0, 0, 0, 0];
[A, B, C, D] = linmod("Scheme_FDr21a", stateToSimulinkOrder(eq), 0);

theta0 = 0;
theta_perturbed = theta0 - perturbation;
eq_perturbed = stateToSimulinkOrder([0, 0, -perturbation, 0]);

out = sim("Compare_lin_nonlin.slx");

time = out.yout{1}.Values.Time;
nonLinCartPos = out.yout{1}.Values.Data(:, 1);
nonLinPendAng = out.yout{2}.Values.Data(:, 1);
linCartPos = out.yout{1}.Values.Data(:, 2);
linPendAng = out.yout{2}.Values.Data(:, 2);

fig(time, nonLinCartPos, nonLinPendAng, linCartPos, linPendAng, ...
    eq, theta0, perturbation);

%% Pendulum up
eq = [0, 0, pi, 0];
[A, B, C, D] = linmod("Scheme_FDr21a", stateToSimulinkOrder(eq), 0);

theta0 = pi;
theta_perturbed = theta0 - perturbation;
eq_perturbed = stateToSimulinkOrder([0, 0, -perturbation, 0]);

out = sim("Compare_lin_nonlin.slx");

time = out.yout{1}.Values.Time;
nonLinCartPos = out.yout{1}.Values.Data(:, 1);
nonLinPendAng = out.yout{2}.Values.Data(:, 1);
linCartPos = out.yout{1}.Values.Data(:, 2);
linPendAng = out.yout{2}.Values.Data(:, 2);

fig(time, nonLinCartPos, nonLinPendAng, linCartPos, linPendAng, ...
    eq, theta0, perturbation);

function fig(time, nonLinCartPos, nonLinPendAng, linCartPos, linPendAng, ...
    equilibrium, theta0, delta)
    figure
    ax = subplot(2, 2, 1);
    plot(ax, time, nonLinCartPos, 'LineWidth', 1.5)
    hold on
    plot(ax, time, nonLinPendAng, 'LineWidth', 1.5)
    grid
    legend("Cart position", "Pendulum angle")
    title("Non-linear model", ...
        "Initial condition \theta_0 = " + (theta0-delta) +" [rad]")
    
    ax = subplot(2, 2, 2);
    plot(ax, time, linCartPos, 'LineWidth', 1.5)
    hold on
    plot(ax, time, linPendAng, 'LineWidth', 1.5)
    grid
    legend("Cart position", "Pendulum angle")
    title("Linearization around " + string(mat2str(equilibrium)) +"^T", ...
        "Initial condition \theta_0 = " + (theta0-delta) + " [rad]")
    
    ax = subplot(2, 2, 3);
    plot(ax, time, nonLinCartPos - linCartPos, 'LineWidth', 1.5)
    grid
    title("Cart position error. Linearization around " + string(mat2str(equilibrium)) + "^T", ...
        "Non-Linear vs Linearized. \theta_0 = " + (theta0-delta) + "[rad]")
    
    ax = subplot(2, 2, 4);
    plot(ax, time, nonLinPendAng - linPendAng, 'LineWidth', 1.5)
    grid
    title("Pendulum angle error. Linearization around " + string(mat2str(equilibrium)) + "^T", ...
        "Non-Linear vs Linearized. \theta_0 = " + (theta0-delta) + " [rad]")
end