calculate: calculate.cc lex.yy.cc
	g++ -ocalculate calculate.cc lex.yy.cc

lex.yy.cc: calculate.l
	flex calculate.l

clean:
	rm -f lex.yy.cc calculate
