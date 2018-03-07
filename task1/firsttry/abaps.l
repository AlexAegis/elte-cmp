%option noyywrap c++ yylineno

%{
#include <iostream>
#include <cstdlib>
%}

DIGIT   		[0-9]
NUMBER 			{DIGIT}+
ALPHA			[a-zA-Z]
LCALPHA			[a-z]
UCALPHA			[A-Z]
VARIABLE 		{LCALPHA}+
VALUE 			{VARIABLE}|{NUMBER}
ENDL 			\n?
WS  			[ \t\n]
COMMENT 		\*.*(\n)?
PROG_NAME 		PROGRAM{WS}+{ALPHA}*\.
DATA			DATA:
TYPES 			I|B	
TYPE_DECL_LINE	{WS}+{VARIABLE}{WS}+TYPE{WS}+{TYPES}{1}
TYPE_DECL 		{DATA}\n(({TYPE_DECL_LINE},\n)+)*{TYPE_DECL_LINE}.
ASSIGN 			MOVE\ {DIGIT}\ TO\ {VARIABLE}.{ENDL}
INPUT 			READ\ TO\ {VARIABLE}.{ENDL}
OPERATION 		{ASSIGN}|{INPUT}
STRUCT 			{WHILE_STRUCT}|{IF_STRUCT}

COMP_OPERATOR 	>|<|==|<=|>=
COMPARISION 	{VALUE}{WS}{COMP_OPERATOR}{WS}{VALUE}
LOGIC_OPERATOR 	AND|OR
LOGIC_EXP 		({COMPARISION}{LOGIC_OPERATOR})*{COMPARISION}

WHILE_BEGIN 	WHILE\ {VARIABLE}.\n
WHILE_END		ENDWHILE.{ENDL}
WHILE_STRUCT 	{WHILE_BEGIN}({OPERATION}|{STRUCT})*{WHILE_END}

IF_BEGIN 		IF\ {LOGIC_EXP}
IF_END 			ENDIF.{ENDL}
IF_STRUCT 		{IF_BEGIN}{IF_STRUCT}
%%

{DIGIT}				std::cout << "DIGIT" << std::endl;
{NUMBER}			std::cout << "NUMBER" << std::endl;
{ALPHA}				std::cout << "ALPHA" << std::endl;
{LCALPHA}			std::cout << "LCALPHA" << std::endl;
{UCALPHA}			std::cout << "UCALPHA" << std::endl;
{VARIABLE}			std::cout << "VARIABLE" << std::endl;
{VALUE}				std::cout << "VALUE" << std::endl;
{ENDL}				std::cout << "ENDL" << std::endl;
{WS}				std::cout << "WS" << std::endl;
{COMMENT}			std::cout << "COMMENT" << std::endl;
{PROG_NAME}			std::cout << "PROG_NAME" << std::endl;
{DATA}				std::cout << "DATA" << std::endl;
{TYPES}				std::cout << "TYPES" << std::endl;
{TYPE_DECL_LINE}	std::cout << "TYPE_DECL_LINE" << std::endl;
{TYPE_DECL}			std::cout << "TYPE_DECL" << std::endl;
{ASSIGN}			std::cout << "ASSIGN" << std::endl;
{INPUT}				std::cout << "INPUT" << std::endl;
{OPERATION}			std::cout << "OPERATION" << std::endl;
{STRUCT}			std::cout << "STRUCT" << std::endl;
{COMP_OPERATOR}		std::cout << "COMP_OPERATOR" << std::endl;
{COMPARISION}		std::cout << "COMPARISION" << std::endl;
{LOGIC_OPERATOR}	std::cout << "LOGIC_OPERATOR" << std::endl;
{LOGIC_EXP}			std::cout << "LOGIC_EXP" << std::endl;
{WHILE_BEGIN}		std::cout << "WHILE_BEGIN" << std::endl;
{WHILE_END}			std::cout << "WHILE_END" << std::endl;
{WHILE_STRUCT}		std::cout << "WHILE_STRUCT" << std::endl;
{IF_BEGIN}			std::cout << "IF_BEGIN" << std::endl;
{IF_END}			std::cout << "IF_END" << std::endl;
{IF_STRUCT}			std::cout << "IF_STRUCT" << std::endl;

{WS}+       	// feher szokozok: semmi teendo

.           	{
                	std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
                	exit(1);
            	}

%%
