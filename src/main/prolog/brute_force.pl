main :-
	sudoku(X),
	solve_sudoku(X),
	display_sudoku(X).
 
sudoku(
[[
[[_,_,_],[_,_,_],[9,_,6]],
[[_,_,_],[_,6,2],[8,1,_]],
[[_,_,_],[1,_,_],[_,_,_]]
],[
[[9,_,2],[_,_,_],[3,_,_]],
[[6,_,_],[_,_,3],[1,_,7]],
[[7,_,_],[8,_,_],[_,6,4]]
],[
[[1,_,4],[2,_,_],[_,_,_]],
[[_,_,3],[_,_,_],[_,_,_]],
[[_,8,_],[9,_,_],[6,_,5]]
]]).
 
solve_sudoku(X) :-
	flatten(X, Y),
	maplist(process(Y), Y).

process(Y, E) :-
	var(E) -> instantiate(Y, E) ; true.
 
instantiate(Y, E) :-
	between(1, 9, E),
	valid(Y).
 
hr :-
	write('+-------+-------+-------+\n').
 
display_sudoku(X) :-
	hr,
	maplist(display_3linesof9, X).
 
display_3linesof9(X) :-
	maplist(display_lineof9, X),
	hr.
 
display_lineof9(L) :-
	write('| '),
	maplist(display_rowof3, L),
	write('\n').
 
display_rowof3(R) :-
	maplist(display_element, R),
	write('| ').
 
display_element(E) :-
	representation(E, R),
	maplist(write, [R, ' ']).
 
representation(E, E) :- ground(E).
representation(E, '?') :- var(E).
 
valid([
	X00, X01, X02, X03, X04, X05, X06, X07, X08,
	X09, X10, X11, X12, X13, X14, X15, X16, X17,
	X18, X19, X20, X21, X22, X23, X24, X25, X26,
	X27, X28, X29, X30, X31, X32, X33, X34, X35,
	X36, X37, X38, X39, X40, X41, X42, X43, X44,
	X45, X46, X47, X48, X49, X50, X51, X52, X53,
	X54, X55, X56, X57, X58, X59, X60, X61, X62,
	X63, X64, X65, X66, X67, X68, X69, X70, X71,
	X72, X73, X74, X75, X76, X77, X78, X79, X80
]) :-
	check([X00, X01, X02, X03, X04, X05, X06, X07, X08]),
	check([X09, X10, X11, X12, X13, X14, X15, X16, X17]),
	check([X18, X19, X20, X21, X22, X23, X24, X25, X26]),
	check([X27, X28, X29, X30, X31, X32, X33, X34, X35]),
	check([X36, X37, X38, X39, X40, X41, X42, X43, X44]),
	check([X45, X46, X47, X48, X49, X50, X51, X52, X53]),
	check([X54, X55, X56, X57, X58, X59, X60, X61, X62]),
	check([X63, X64, X65, X66, X67, X68, X69, X70, X71]),
	check([X72, X73, X74, X75, X76, X77, X78, X79, X80]),
	check([X00, X09, X18, X27, X36, X45, X54, X63, X72]),
	check([X01, X10, X19, X28, X37, X46, X55, X64, X73]),
	check([X02, X11, X20, X29, X38, X47, X56, X65, X74]),
	check([X03, X12, X21, X30, X39, X48, X57, X66, X75]),
	check([X04, X13, X22, X31, X40, X49, X58, X67, X76]),
	check([X05, X14, X23, X32, X41, X50, X59, X68, X77]),
	check([X06, X15, X24, X33, X42, X51, X60, X69, X78]),
	check([X07, X16, X25, X34, X43, X52, X61, X70, X79]),
	check([X08, X17, X26, X35, X44, X53, X62, X71, X80]),
	check([X00, X01, X02, X09, X10, X11, X18, X19, X20]),
	check([X03, X04, X05, X12, X13, X14, X21, X22, X23]),
	check([X06, X07, X08, X15, X16, X17, X24, X25, X26]),
	check([X27, X28, X29, X36, X37, X38, X45, X46, X47]),
	check([X30, X31, X32, X39, X40, X41, X48, X49, X50]),
	check([X33, X34, X35, X42, X43, X44, X51, X52, X53]),
	check([X54, X55, X56, X63, X64, X65, X72, X73, X74]),
	check([X57, X58, X59, X66, X67, X68, X75, X76, X77]),
	check([X60, X61, X62, X69, X70, X71, X78, X79, X80]).
 
check(GroupOf9) :-
	findall(X, (member(X, GroupOf9), ground(X)), XS),
	sort(XS, S1),
	msort(XS, S2),
	S1 = S2.
