% Mark Tarakai
% Exam 3: Prolog Solution

% modulus to perform arithmetic
modulus(X) :- 0 is mod(X, 3). % or
modulus(X) :- 0 is mod(X, 5). % or
modulus(X) :- 0 is mod(X, 7).
% sum condition, or'd together
sum357(X,Sum) :- X>1000, write(Sum).
sum357(X,Sum) :- X=<1000, modulus(X), Tsum is Sum+X, Tx is X+1, sum357(Tx, Tsum).
sum357(X,Sum) :- X=<1000, \+ modulus(X), Tx is X+1, sum357(Tx,Sum).