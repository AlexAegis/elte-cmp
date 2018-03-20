%option noyywrap c++ yylineno

%{
#include "Parserbase.h"
%}

VARIABLE				[a-zA-Z][0-9a-zA-Z]*
WS						[ \t\n]

%%

\.						return Parser::STMT_DOT;
,						return Parser::STMT_COMMA;
:						return Parser::STMT_OPN;
^\*.*$					return Parser::COMMENT;
DATA					return Parser::DATA;
TYPE					return Parser::TYPE;
I						return Parser::TYPE_INTEGER;
B						return Parser::TYPE_BOOLEAN;

{VARIABLE}				return Parser::VARIABLE;

{WS}+					// feher szokozok: semmi teendo

.						{
							std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
							exit(1);
						}

%%