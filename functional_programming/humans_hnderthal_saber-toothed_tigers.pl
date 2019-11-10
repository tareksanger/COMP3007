% COMP3007
% Assignment 4
% Tarek Sanger
% 101059686

% Question 3: "Ancient History"

% Humans, Hnderthal, Saber-toothed tigers
passengers(2, 0, 0).
passengers(1, 0, 0).
passengers(1, 1, 0).
passengers(1, 0, 1).
passengers(0, 1, 0).
passengers(0, 1, 1).

transition( state(A, B, C, D, E, F, east), cross(Z, N, S), state(G, H, I, J, K, L, west) ) :-
  passengers(Z, N, S),
  G is A - Z,
  G >= 0,
  H is B - N,
  H >= 0,
  I is C - S,
  I >= 0,
  J is D + Z,
  K is E + N,
  L is F + S,
  safe(I, G, L, J).
  
transition( state(A, B, C, D, E, F, west), cross(Z, N, S), state(G, H, I, J, K, L, east) ) :-
  passengers(Z, N, S),
  G is A + Z,
  H is B + N,
  I is C + S,
  J is D - Z, J >= 0,
  K is E - N, K >= 0,
  L is F - S,
  L >= 0, safe(I, G, L, J).

safe(A, B, C, D) :- (A =< B ; B == 0), (C =< D; D == 0).

crosssafely(S, S, []).
crosssafely(S, E, [X | Y]) :- S \= E, transition(S, X, I), crosssafely(I, E, Y).

find_solution() :- length(L, 9), crosssafely(state(0, 0, 0, 3, 1, 2, west), state(3, 1, 2, 0, 0, 0, _), L), write(L).
