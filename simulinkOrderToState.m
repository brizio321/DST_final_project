function [state] = simulinkOrderToState(orderedState)
%Input: state for cart-pendulum system with Simulink order [x, theta, omega, v]
%Output: state for cart-pendulum system with order [x, v, theta, omega]
state = [orderedState(1), orderedState(4), orderedState(2), orderedState(3)]';
end