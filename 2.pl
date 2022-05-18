% 1
/*
    Построить предикат fib(+N,?A), проверяющий является ли число А числом
    Фибоначчи с номером N или находящий число с таким номером и
    записывающим его в A. (любой числовой алгоритм с применением рекурсии
    вверх или вниз).
*/
% x_i = x_(i-1) + x_(i-2)
fib(Index, Number):- Index < 3, Number is 1, !.
fib(Index, Number):-
    PreviousIndex is Index - 1, % i - 1
    PrePreviousIndex is Index - 2, % i - 2
    fib(PreviousIndex, PreviousNumber),  % x_(i-1)
    fib(PrePreviousIndex, PrePreviousNumber),  % x_(i-2)
    Number is PreviousNumber + PrePreviousNumber, !.
