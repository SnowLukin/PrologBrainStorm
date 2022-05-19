/*
    1 Построить предикат fib(+N,?A), проверяющий является ли число А числом
    Фибоначчи с номером N или находящий число с таким номером и
    записывающим его в A. (любой числовой алгоритм с применением рекурсии
    вверх или вниз).

    2 Построить предикат fib_list(+List,-Count), находящий количество таких пар в
    списке, что первый элемент – это номер числа Фибоначчи, а второй – число
    Фибоначчи.

    3 Построить предикат razm(+List,K,-Razm), записывающий в Razm все
    возможные размещения по K элементов без повторений. (Возможна
    формулировка для любого комбинаторного объекта, размещения,
    перестановки, подмножества, с размещениями или без).

    4 С помощью предиката из предыдущих задач построить предикат с
    одним обязательным аргументом – список, который выводит на экран
    все размещения по k элементов, которые содержат только элементы
    последовательности Фибоначчи в возрастающем порядке.

    5 Построить предикат, который выводит на экран все слова длины 6, в
    которых первые три буквы любые из [a,b,c,d,e] без повторов,
    остальные буквы [v,w,x,y,z] возможно с повторами.

    6 Граф задан списком вершин и списком ребер, где каждое ребро –
    список двух вершин. [a,b,c,d,e], [[a,b],[a,e],[b,c],[c,d],[d,e],[c,e],[a,c]].
    Зная, что таким образом задан НЕОРИЕНТИРОВАННЫЙ граф,
    найти гамильтонов цикл. (или любые задачи на графы из лекции).
*/

% -------- 1 --------

% Recursion bottom-up
fibUp(Index, Number):- Index < 3, Number is 1, !.
fibUp(Index, Number):-
    PreviousIndex is Index - 1,
    PrePreviousIndex is Index - 2,
    fibUp(PreviousIndex, PreviousNumber),
    fibUp(PrePreviousIndex, PrePreviousNumber),
    Number is PreviousNumber + PrePreviousNumber, !.

% Recursion top-down
fibDown(0, 0).
fibDown(1, 1).
fibDown(Index, Number):-
    NewIndex is Index - 1,
    fibDown_(0, 1, NewIndex, Number).
fibDown_(_, Number, 0, Number).
fibDown_(PrePreviousNumber, PreviousNumber, Index, Number):-
    NewPreviousNumber is PrePreviousNumber + PreviousNumber,
    NewIndex is Index - 1,
    fibDown_(PreviousNumber, NewPreviousNumber, NewIndex, Number).

% -------- 2 --------

/* Example:
        ?- fibList([1,2,3,4,5,5],Result).
        2, 1
        3, 2
        4, 3
        5, 5
        Result = 4
*/

writeCouple(FirstNumber, SecondNumber):- write(FirstNumber), write(', '), writeln(SecondNumber).

% Fibonacci couple - one of the element is a Fibonacci number and the other one is its index.
amountOfFibCouples([Head|Tail], Number, Result):- amountOfFibCouples([Head|Tail], Number, 0, Result).
amountOfFibCouples([], _, Counter, Result):- Result is Counter, !.
amountOfFibCouples([Head|Tail], Number, Counter, Result):-
    (fibUp(Head, Number), writeCouple(Head, Number) ; fibUp(Number, Head), writeCouple(Number, Head)),
    NewCounter is Counter + 1,
    amountOfFibCouples(Tail, Number, NewCounter, Result)
    ;
    amountOfFibCouples(Tail, Number, Counter, Result).

fibList([Head|Tail], Result):- fibList([Head|Tail], 0, Result).
fibList([], Counter, Result):- Result is Counter, !.
fibList([Head|Tail], Counter, Result):-
    amountOfFibCouples(Tail, Head, TempCounter),
    NewCounter is Counter + TempCounter,
    fibList(Tail, NewCounter, Result);
    fibList(Tail, Counter, Result).


% -------- 3 --------

/*
    Example:
        ?- partialPermutation([1,2,3],2).
        1 2
        1 3
        2 1
        2 3
        3 1
        3 2
*/

writeList([]):- writeln(''), !.
writeList([Head|Tail]):- write(Head), write(' '), writeList(Tail).

partialPermutation(List, PermutationLength):-
    partialPermutation(List, PermutationLength, []).
partialPermutation(_, 0, ResultList):-
    writeList(ResultList), !, fail.
partialPermutation(List, PermutationLength, ResultList):-
    select(Head, List, ListTail),
    NewPermutationLength is PermutationLength - 1,
    append(ResultList, [Head], NewResultList),
    partialPermutation(ListTail, NewPermutationLength, NewResultList).


/*
    Example:
        ?- partialPermutationNoRepeats([1,2,2,3],2).
        1 2
        1 3
        2 1
        2 3
        3 1
        3 2
*/

partialPermutationNoRepeats(List, Lenght):-
    sort(List, SortedList),
    partialPermutation(SortedList, Lenght).

/*
    Example:
        ?- permutation([1,2,3]).
        1 2 3
        1 3 2
        2 1 3
        2 3 1
        3 1 2
        3 2 1
*/

permutation(List):-
    length(List, Length),
    partialPermutation(List, Length).

/*
    Example:
        ?- permutationNoRepeats([1,2,2,3]).
        1 2 3
        1 3 2
        2 1 3
        2 3 1
        3 1 2
        3 2 1
*/

permutationNoRepeats(List):-
    sort(List, SortedList),
    permutation(SortedList).


/*
    Example:
        ?- compromise([1,2,3],2).
        1 2
        1 3
        2 3
*/

compromise(List, Lenght):- compromise(List, Lenght, []).
compromise(_, 0, ResultList):-
    writeList(ResultList), !, fail.
compromise([Head|Tail], Length, ResultList):-
    NewLength is Length - 1,
    append(ResultList, [Head], NewResultList),
    compromise(Tail, NewLength, NewResultList).
compromise([_|Tail], Length, ResultList):-
    compromise(Tail, Length, ResultList).


/*
    Example:
        ?- compromiseNoRepeats([1,2,2,3],2).
        1 2
        1 3
        2 3
*/

compromiseNoRepeats(List, Lenght):-
    sort(List, SortedList),
    compromise(SortedList, Lenght).

% -------- 4 --------

isFib(0):- true, !.
isFib(1):- true, !.
isFib(Number):- isFib(Number, 1, 0).
isFib(Number, Number, _):- true, !.
isFib(Number, Previous, PrePrevious):-
    Number > Previous,
    NewPrevious is Previous + PrePrevious,
    isFib(Number, NewPrevious, Previous);
    false, !.

getSortedListForTaskThree(List, ResultList):-
    include(isFib, List, FibList),
    sort(FibList, NewFibList),
    ResultList = NewFibList.

/*
    Example:
        ?- startTask4([1,2,3,2,4,5,6,7,8], 4).
        1 2 3 5
        1 2 3 8
        1 2 5 8
        1 3 5 8
        2 3 5 8
*/

% Since there is nothing about repeats in the task description,
% I decided to do it without repeats.
startTask4(List, PermutationLength):-
    % Since we need each elements greater than the previous one,
    % we can just use compromise instead of partial permutation
    getSortedListForTaskThree(List, SortedList),
    compromiseNoRepeats(SortedList, PermutationLength).



% Test

factorial(Number, Result):- factorial(Number, 1, Result).
factorial(0, Mult, Result):- Result is Mult.
factorial(Number, Mult, Result) :-
    Number > 0,
    NewMult is Number * Mult,
    NewNumber is Number - 1,
    factorial(NewNumber, NewMult, Result).

countPartialPermutation(List, PartialPermutationLenght, Result):-
    length(List, ListLenght),
    factorial(ListLenght, NFactorial),
    NSubK is ListLenght - PartialPermutationLenght,
    factorial(NSubK, NKSubFactorial),
    Result is NFactorial div NKSubFactorial, !.
