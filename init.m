clear
close all

m = 1;
M = 5;
L = 2;
g = 9.81;
%[~, ~,xstring] = Scheme_FDr21a

eq = [0, 0, pi, 0];
[A, B, C, D] = linmod("Scheme_FDr21a", stateToSimulinkOrder(eq), 0);
[A, B, C, D] = simulinkSysToModelOrder(A, B, C, D);
eig(A)