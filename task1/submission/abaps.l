%option noyywrap c++ yylineno

%{
#include <iostream>
#include <cstdlib>
%}

VARIABLE				[a-zA-Z][0-9a-zA-Z]*
WS						[ \t\n]

%%

\.						std::cout << "STMT_DOT" 			<< " \"" << YYText() << "\"" << std::endl;
,						std::cout << "STMT_COMMA"			<< " \"" << YYText() << "\"" << std::endl;
:						std::cout << "STMT_OPN" 			<< " \"" << YYText() << "\"" << std::endl;
^\*.*$					std::cout << "COMMENT" 				<< " \"" << YYText() << "\"" << std::endl;
PROGRAM					std::cout << "PROGRAM" 				<< " \"" << YYText() << "\"" << std::endl;
DATA					std::cout << "DATA" 				<< " \"" << YYText() << "\"" << std::endl;
TYPE					std::cout << "TYPE" 				<< " \"" << YYText() << "\"" << std::endl;
I						std::cout << "TYPE_INTEGER"			<< " \"" << YYText() << "\"" << std::endl;
B						std::cout << "TYPE_BOOLEAN"			<< " \"" << YYText() << "\"" << std::endl;
MOVE					std::cout << "OP_MOVE"	 			<< " \"" << YYText() << "\"" << std::endl;
READ					std::cout << "OP_READ"				<< " \"" << YYText() << "\"" << std::endl;
ADD						std::cout << "OP_ADD"				<< " \"" << YYText() << "\"" << std::endl;
WRITE					std::cout << "OP_WRITE"				<< " \"" << YYText() << "\"" << std::endl;
TO						std::cout << "DIR_TO"				<< " \"" << YYText() << "\"" << std::endl;
BY						std::cout << "DIR_BY"				<< " \"" << YYText() << "\"" << std::endl;
FROM					std::cout << "DIR_FROM"				<< " \"" << YYText() << "\"" << std::endl;
IF						std::cout << "STRUCT_IF"			<< " \"" << YYText() << "\"" << std::endl;
WHILE					std::cout << "STRUCT_WHILE"			<< " \"" << YYText() << "\"" << std::endl;
ELSEIF					std::cout << "STRUCT_ELSEIF"		<< " \"" << YYText() << "\"" << std::endl;
ELSE					std::cout << "STRUCT_ELSE"			<< " \"" << YYText() << "\"" << std::endl;
ENDIF					std::cout << "STRUCT_ENDIF"			<< " \"" << YYText() << "\"" << std::endl;
ENDWHILE				std::cout << "STRUCT_ENDWHILE"		<< " \"" << YYText() << "\"" << std::endl;
"<"						std::cout << "COMP_LS"				<< " \"" << YYText() << "\"" << std::endl;
">"						std::cout << "COMP_GT"				<< " \"" << YYText() << "\"" << std::endl;
"="						std::cout << "COMP_EQ"				<< " \"" << YYText() << "\"" << std::endl;
AND						std::cout << "LOGIC_AND"			<< " \"" << YYText() << "\"" << std::endl;
OR						std::cout << "LOGIC_OR"				<< " \"" << YYText() << "\"" << std::endl;
NOT						std::cout << "LOGIC_NOT"			<< " \"" << YYText() << "\"" << std::endl;
SUBTRACT				std::cout << "MATH_SUB"				<< " \"" << YYText() << "\"" << std::endl;
MULTIPLY				std::cout << "MATH_MULT" 			<< " \"" << YYText() << "\"" << std::endl;
DIVIDE					std::cout << "MATH_DIV" 			<< " \"" << YYText() << "\"" << std::endl;

{VARIABLE}				std::cout << "VARIABLE" 			<< " \"" << YYText() << "\"" << std::endl;
[0-9]+					std::cout << "NUMBER" 				<< " \"" << YYText() << "\"" << std::endl;

{WS}+					// feher szokozok: semmi teendo

. 						{
							std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
							exit(1);
						}

%%