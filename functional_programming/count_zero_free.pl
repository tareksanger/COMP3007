% COMP3007
% Assignment 4
% Tarek Sanger
% 101059686

% Question 1: "Counting Zerofrees"
% Prolog

countZerofree([], 0).
countZerofree([H|T], X) :-
  containsZero(H) -> countZerofree(T, X);
  countZerofree(T, Y), X is 1+Y.

containsZero(X) :-
  ((X - (10 * (X // 10))) =:= 0 ) -> true;
  ((X // 10) =:= 0) -> false;
  (X >= 0) -> containsZero(X // 10);
  false.
