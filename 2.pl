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

% 1
% x_i = x_(i-1) + x_(i-2)
fibUp(Index, Number):- Index < 3, Number is 1, !.
fibUp(Index, Number):-
    PreviousIndex is Index - 1, % i - 1
    PrePreviousIndex is Index - 2, % i - 2
    fibUp(PreviousIndex, PreviousNumber),  % x_(i-1)
    fibUp(PrePreviousIndex, PrePreviousNumber),  % x_(i-2)
    Number is PreviousNumber + PrePreviousNumber, !.

fibDown(0, Number, PreviousNumber, PrePreviousNumber):- Number is PreviousNumber + PrePreviousNumber, !.
fibDown(Index, Number, PreviousNumber, PrePreviousNumber):-
    NewPrePreviousNumber is PreviousNumber,
    NewPreviousNumber is PreviousNumber + PrePreviousNumber,
    NewIndex is Index - 1,
    fibDown(NewIndex, Number, NewPreviousNumber, NewPrePreviousNumber).
fibDown(Index, Number):- NewIndex is Index - 2, fibDown(NewIndex, Number, 1, 0), !.
    
