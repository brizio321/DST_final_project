init;

%% Controllability
controllabilityMatrix = ctrb(A, B)
rank(controllabilityMatrix)

%% Observability
observabilityMatrix = obsv(A, C)
null(observabilityMatrix)
rank(observabilityMatrix)