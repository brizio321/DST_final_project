function [orderedState] = stateToSimulinkOrder(state)
%Input: state for cart-pendulum system with order [x, v, theta, omega]
%Output: state for cart-pendulum system with Simulink order [x, theta, omega, v]
orderedState = [state(1), state(3), state(4), state(2)]';
end