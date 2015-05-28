%To use, call start(V,W,X,Y,Z), looks better if you use the names.
% start(Dina,William,Charlie,Daniel,Sam).

box(1,black,6).
box(2,black,2).
box(3,white,2).
box(4,black,4).
box(5,white,6).
start(Dina,William,Charlie,Daniel,Sam):-

	box(Dina,ColourX,_),
	box(William,ColourX,_),
	box(Daniel,ColourY,_),
	box(Sam,ColourY,_),
	box(Charlie,_,SizeX),
	box(Daniel,_,SizeX),
	box(Sam,_,SizeY),
	box(William,_,SizeZ),
	SizeY < SizeZ,
	Dina\=William,
	Dina\=Charlie,
	Dina\=Daniel,
	Dina\=Sam,
	William\=Charlie,
	William\=Daniel,
	William\=Sam,
	Charlie\=Daniel,
	Charlie\=Sam,
	Daniel\=Sam,
	!.












