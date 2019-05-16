%пример запроса - start([1, 1, 1,0, 2, 2, 2],[2,2,2, 0, 1,1,1])
%можно добавлять лягушек слева и справа, но обязательно симметрично
%например - start([1, 1, 1, 1,0, 2, 2, 2, 2],[2,2,2,2, 0,1, 1,1,1])
%предикат подсмотрен на сайте StackOverflow, автор - M09
%происходит замена ToReplace-списка  на ToInsert список в списке
%List, результат замены - список Result
replace(ToReplace, ToInsert, List, Result) :-
    once(append([Left, ToReplace, Right], List)),
    append([Left, ToInsert, Right], Result).

%предикат подсмотрен на сайте StackOverflow, автор - REDPIXY
%происходит подсчет количества элементов в списке
countElements([], 0).
countElements([_|Tail], Cnt) :-  countElements(Tail, Cnt1), Cnt is Cnt1 + 1.

%автор - Климашевич Николай, 621702, БГУИР
%происходит вывод в строку элементов списка
writeList([]) :- nl.
writeList([X|L]) :- write(X), writeList(L).

%автор - Климашевич Николай, 621702, БГУИР
%Обнаружение обозначения свободного камня
%Свободный камень является серединой по условию задачи
%Первый параметр - это множество, где мы ищем середину
%второй - это середина списка, дробное число
%Например, для 7 это 3,5.
%Третий параметр - текущий счетчик, когда мы дойдем до
%Середины, то сохраним значение в Mid - это  будет обозначение камня пустого
getMiddle([X|_], Res, Cnt, Mid) :- Cnt > Mid - 1, Res is X.
getMiddle([_|Tail], Res, Cnt, Mid) :- Cnt < Mid, Cnt1 is Cnt + 1, getMiddle(Tail, Res, Cnt1, Mid).

%автор - Климашевич Николай, 621702, БГУИР
%берем первый элемент списка - обозначения типа
%лягушки из левой части до свободного камня
getLeft(Left, [X|_]) :- Left is X.

%автор - Климашевич Николай, 621702, БГУИР
%берем правый тип лягушки
%когда мы подошли к концу списка, то там и будет на
%последнем месте оьозначение коричневой по условию лягушки
getRight(Right, [X|[]]) :- Right is X.
getRight(Right, [_|Tail]) :-   getRight(Right, Tail).

%автор - Климашевич Николай, 621702, БГУИР
%перемещения лягушек
%ищем подлист определенный
%если нашли, меняем на подлист после перемещения
%G, B, E - зеленая лягушка, коричневая, свободн.  место
move(_, _, _, X, Y) :- X = Y, writeList(X).
move(E, G, B, X, Y) :-    
    replace([G, E], [E, G], X, Res),
    writeList(X),
    move(E, G, B, Res, Y).
move(E, G, B, X, Y) :-    
    replace([E, B], [B, E], X, Res),
    writeList(X),
    move(E, G, B, Res, Y).
move(E, G, B, X, Y) :-    
    replace([G, B, E], [E, B, G], X, Res),
    writeList(X),
    move(E, G, B, Res, Y).
move(E, G, B, X, Y) :-   
    replace([E, G, B], [B, G, E], X, Res),
    writeList(X),
    move(E, G, B, Res, Y).
%автор - Климашевич Николай, 621702, БГУИР
%X - начальное состояние
%Y - желаемое состояние
start(X, Y):-  countElements(X, Cnt), 
    write('Начальное состояние: '), nl,  writeList(X),
    write('Желаемое состояние: '), nl,  writeList(Y),
    write('Обозначения: '), nl,
    HalfFrogs is Cnt/2, getMiddle(X, Midd, 0, HalfFrogs), 
    write('Свободный камень - '), write(Midd), nl,
    E is Midd, getLeft(Left, X), G is Left,
    write('Зеленая лягушка - '), write(G), nl,
    getRight(Right, X), B is Right, 
    write('Коричневая лягушка - '), write(B), nl,
    write('История перестановок:'), nl, nl,
    move(E, G, B, X, Y).
   
   
    
    
    
    
    
    
    