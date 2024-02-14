init;

eigenvalues = eig(A);

for i = 1:numel(eigenvalues)
    e = eigenvalues(i)
    4 - rank(A - e*eye(size(A)))
end

%Not diagonalizable, evaluate jordan decomposition
[V, J] = jordan(A);

%State space base
V %Transformation matrix ModalCoor-to-CanonicalBase. x = V*r

%% Modal state evolution matrix
syms t
modalStateMatrix = expm(J*t);
vpa(modalStateMatrix)

%% Modal decomposition
r = sym('r', [4 1]);    %State in modal coordinates
closedSolution = vpa(modalStateMatrix*r)

x = vpa(V*closedSolution, 4)    %State in canonical coordinates     

% r1 = subs(closedSolution, t, 1);
% x = V*r1