%option noyywrap c++ yylineno

%{
#include <iostream>
#include <cstdlib>
%}

DIGIT   [0-9]
WS  [ \t\n]

%%

{DIGIT}+    std::cout << "NUMBER" << std::endl;

"+"         std::cout << "PLUS" << std::endl;
"-"         std::cout << "MINUS" << std::endl;
"="         std::cout << "EQUAL" << std::endl;
"("         std::cout << "OPEN" << std::endl;
")"         std::cout << "CLOSE" << std::endl;

{WS}+       // feher szokozok: semmi teendo

.           {
                std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
                exit(1);
            }

%%
