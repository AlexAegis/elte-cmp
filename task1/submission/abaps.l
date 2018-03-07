%option noyywrap c++ yylineno

%{
#include <iostream>
#include <cstdlib>
%}

NUMBER 			[0-9]+
ALPHA			[a-zA-Z]
LCALPHA			[a-z]
UCALPHA			[A-Z]
VARIABLE 		{WS}[A-Z][a-z]*{WS}|[a-z]+
STMT_DOT 		\.
STMT_COMMA		,
STMT_OPN 		:
WS  			[ \t\n]
COMMENT 		^\*.*$
PROG 			"PROGRAM"
DATA			"DATA"
TYPE 			"TYPE"
TYPE_INTEGER		I
TYPE_BOOLEAN		B	
OP_MOVE			MOVE
OP_READ 		READ
OP_ADD			ADD
OP_WRITE 		WRITE
DIR_TO			TO
DIR_BY 			BY
DIR_FROM 		FROM
STRUCT_IF		IF
STRUCT_WHILE		WHILE
STRUCT_ELSEIF		ELSEIF
STRUCT_ELSE		ELSE
STRUCT_ENDIF		ENDIF
STRUCT_ENDWHILE		ENDWHILE
COMP_LT			>
COMP_GT			<
COMP_EQ			=
LOGIC_AND 		AND
LOGIC_OR		OR
LOGIC_NOT		NOT
MATH_SUB		SUBTRACT
MATH_MULT		MULTIPLY
MATH_DIV		DIVIDE

%%

{VARIABLE}			std::cout << "VARIABLE" 		<< " \"" << YYText() << "\"" << std::endl;
{STMT_DOT}			std::cout << "STMT_DOT" 		<< " \"" << YYText() << "\"" << std::endl;
{STMT_COMMA}                    std::cout << "STMT_COMMA"               << " \"" << YYText() << "\"" << std::endl;
{STMT_OPN}			std::cout << "STMT_OPN" 		<< " \"" << YYText() << "\"" << std::endl;
{COMMENT}			std::cout << "COMMENT" 			<< " \"" << YYText() << "\"" << std::endl;
{PROG}				std::cout << "PROG" 			<< " \"" << YYText() << "\"" << std::endl;
{DATA}				std::cout << "DATA" 			<< " \"" << YYText() << "\"" << std::endl;
{TYPE}				std::cout << "TYPE" 			<< " \"" << YYText() << "\"" << std::endl;
{TYPE_INTEGER}			std::cout << "TYPE_INTEGER"		<< " \"" << YYText() << "\"" << std::endl;
{TYPE_BOOLEAN}                  std::cout << "TYPE_BOOLEAN"             << " \"" << YYText() << "\"" << std::endl;
{OP_MOVE}			std::cout << "OP_MOVE"	 		<< " \"" << YYText() << "\"" << std::endl;
{OP_READ}			std::cout << "OP_READ"                  << " \"" << YYText() << "\"" << std::endl;
{OP_ADD}			std::cout << "OP_ADD"                   << " \"" << YYText() << "\"" << std::endl;
{OP_WRITE}			std::cout << "OP_WRITE"                 << " \"" << YYText() << "\"" << std::endl;
{DIR_TO}			std::cout << "DIR_TO" 			<< " \"" << YYText() << "\"" << std::endl;
{DIR_BY}			std::cout << "DIR_BY"                   << " \"" << YYText() << "\"" << std::endl;
{DIR_FROM}			std::cout << "DIR_FROM"                 << " \"" << YYText() << "\"" << std::endl;
{STRUCT_IF}			std::cout << "STRUCT_IF"		<< " \"" << YYText() << "\"" << std::endl;
{STRUCT_WHILE}                  std::cout << "STRUCT_WHILE"             << " \"" << YYText() << "\"" << std::endl;
{STRUCT_ELSEIF}                 std::cout << "STRUCT_ELSEIF"            << " \"" << YYText() << "\"" << std::endl;
{STRUCT_ELSE}                   std::cout << "STRUCT_ELSE"              << " \"" << YYText() << "\"" << std::endl;
{STRUCT_ENDIF}                  std::cout << "STRUCT_ENDIF"             << " \"" << YYText() << "\"" << std::endl;
{STRUCT_ENDWHILE}               std::cout << "STRUCT_ENDWHILE"          << " \"" << YYText() << "\"" << std::endl;
{COMP_LT}			std::cout << "COMP_LS"		 	<< " \"" << YYText() << "\"" << std::endl;
{COMP_GT}                       std::cout << "COMP_GT"                  << " \"" << YYText() << "\"" << std::endl;
{COMP_EQ}                       std::cout << "COMP_EQ"                  << " \"" << YYText() << "\"" << std::endl;
{LOGIC_AND}			std::cout << "LOGIC_AND"	 	<< " \"" << YYText() << "\"" << std::endl;
{LOGIC_OR}                      std::cout << "LOGIC_OR"                 << " \"" << YYText() << "\"" << std::endl;
{LOGIC_NOT}                     std::cout << "LOGIC_NOT"                << " \"" << YYText() << "\"" << std::endl;
{MATH_SUB}			std::cout << "MATH_SUB"		 	<< " \"" << YYText() << "\"" << std::endl;
{MATH_MULT}                     std::cout << "MATH_MULT"                << " \"" << YYText() << "\"" << std::endl;
{MATH_DIV}                      std::cout << "MATH_DIV"                 << " \"" << YYText() << "\"" << std::endl;
{NUMBER}			std::cout << "NUMBER" 			<< " \"" << YYText() << "\"" << std::endl;

{WS}+      			// feher szokozok: semmi teendo

.           {
                std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
                exit(1);
            }

%%
