%option noyywrap c++ yylineno

%{
#include "Parserbase.h"
#include <iostream>
#include <cstdlib>
%}

VARIABLE 		[A-Za-z0-9]+
WS  			[ \t\n]

%%

{VARIABLE}			return Parser::VARIABLE;
\.					return Parser::STMT_DOT;
","					return Parser::STMT_COMMA;
":"					return Parser::STMT_OPN;
^\*.*$				return Parser::COMMENT;
"PROGRAM"			return Parser::PROGRAM;
"DATA"				return Parser::DATA;
"TYPE"				return Parser::TYPE;
"I"					return Parser::TYPE_INTEGER;
"B"					return Parser::TYPE_BOOLEAN;
"MOVE"				return Parser::OP_MOVE;
"READ"				return Parser::OP_READ;
"ADD"				return Parser::OP_ADD;
"WRITE"				return Parser::OP_WRITE;
"TO"				return Parser::DIR_TO;
"BY"				return Parser::DIR_BY;
"FROM"				return Parser::DIR_FROM;
"IF"				return Parser::STRUCT_IF;
"WHILE"				return Parser::STRUCT_WHILE;
"ELSEIF"			return Parser::STRUCT_ELSEIF;
"ELSE"				return Parser::STRUCT_ELSE;
"ENDIF"				return Parser::STRUCT_ENDIF;
"ENDWHILE"			return Parser::STRUCT_ENDWHILE;
"<"					return Parser::COMP_LS;
">"					return Parser::COMP_GT;
"="					return Parser::COMP_EQ;
"AND"				return Parser::LOGIC_AND;
"OR"				return Parser::LOGIC_OR;
"NOT"				return Parser::LOGIC_NOT;
"SUBTRACT"			return Parser::MATH_SUB;
"MULTIPLY"			return Parser::MATH_MULT;
"DIVIDE"			return Parser::MATH_DIV;

{WS}+				// feher szokozok: semmi teendo

.					{
						std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
						exit(1);
					}

%%
