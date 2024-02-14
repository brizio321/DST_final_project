function [Ao,Bo, Co, Do] = simulinkSysToModelOrder(A, B, C, D)
temp = horzcat(A(:, 1), A(:, 4), A(:, 2), A(:, 3));
Ao = vertcat(temp(1, :), temp(4, :), temp(2, :), temp(3, :));

Bo = [B(1), B(4), B(2), B(3)]';

Co = horzcat(C(:, 1), C(:, 4), C(:, 2), C(:, 3));
Do = D;
end