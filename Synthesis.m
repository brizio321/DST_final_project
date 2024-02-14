init;

%% State Feedback
P = [-1, -3.5, -2, -2.4261];
K = acker(A, B, P)

theta = pi;
perturbation = 0.15;
theta_perturbed = theta - perturbation;
% eq = stateToSimulinkOrder([0, 0, -perturbation, 0]);
eq = [0, 0, -perturbation, 0];

%Linearized system
out = sim("Linearized_state_feedback.slx");

figure
ax = subplot(1, 2, 1);
plot(ax, out.yout{1}.Values.Time, out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title('Linearized feedback system - Cart position')

ax = subplot(1, 2, 2);
plot(ax, out.yout{2}.Values.Time, out.yout{2}.Values.Data, 'LineWidth', 1.5)
grid
title('Linearized feedback system - Pendulum angle')

%Nonlinear system
out = sim("Nonlinear_state_feedback.slx");

figure
ax = subplot(1, 2, 1);
plot(ax, out.yout{1}.Values.Time, out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title('Non-linear feedback system - Cart position')

ax = subplot(1, 2, 2);
plot(ax, out.yout{2}.Values.Time, out.yout{2}.Values.Data, 'LineWidth', 1.5)
grid
title('Non-linear feedback system - Pendulum angle')

%% Observer
P = [-20, -24, -26, -28];
temp = place(A', C', P);
L_obs = temp'

%Linearized system
out = sim("Linearized_observer.slx");

figure
ax = subplot(1, 2, 1);
plot(ax, out.yout{1}.Values.Time, out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title(["Linearized system",  "State estimated by observer"])
legend('p', 'v', '\theta', '\omega')

ax = subplot(1, 2, 2);
plot(ax, out.yout{2}.Values.Time, out.yout{2}.Values.Data - out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title(["Linearized system", "Real-Estimed state error"])
legend('$p-\hat{p}$', '$v-\hat{v}$', '$\theta-\hat{\theta}$', '$\omega-\hat{\omega}$', 'Interpreter', 'latex')


%Nonlinear system
out = sim("Nonlinear_observer.slx");

figure
ax = subplot(1, 2, 1);
plot(ax, out.yout{1}.Values.Time, out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title(["Non-linear system", "State estimated by observer"])
legend('p', 'v', '\theta', '\omega')

ax = subplot(1, 2, 2);
plot(ax, out.yout{2}.Values.Time, out.yout{2}.Values.Data - out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title(["Non-linear system", "Real-Estimed state error"])
legend('$p-\hat{p}$', '$v-\hat{v}$', '$\theta-\hat{\theta}$', '$\omega-\hat{\omega}$', 'Interpreter', 'latex')

%% Dynamic compensator
figure

%Linearized system
out = sim("Linearized_compensator.slx");

ax = subplot(1, 2, 1);
plot(ax, out.yout{1}.Values.Time, out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title("Linearized system with dynamic compensator")
legend('p', '\theta')

%Nonlinear system
out = sim("Nonlinear_compensator.slx");

ax = subplot(1, 2, 2);
plot(ax, out.yout{1}.Values.Time, out.yout{1}.Values.Data, 'LineWidth', 1.5)
grid
title("Non-linear system with dynamic compensator")
legend('p', '\theta')

%% Regulation problem
[num, denom] = ss2tf(A-B*K, B, C-D*K, D);
posTf = tf(num(1, :), denom);
Kr = 1/evalfr(posTf, 0);

figure
%Nonlinear system
out = sim("Nonlinear_compensator_regulate_position.slx");

plot(out.yout{2}.Values.Time, out.yout{2}.Values.Data, 'LineWidth', 1.5)
grid
title("Non-linear system regulation problem for p(t)")
legend('p', '\theta')