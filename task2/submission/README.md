# Usage

flex abaps.l
bisonc++ abaps.y
g++ -oabaps abaps.cc parse.cc lex.yy.cc
./abaps test.abaps
