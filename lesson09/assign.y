%baseclass-preinclude "semantics.h"
%lsp-needed

%token NATURAL;
%token BOOLEAN;
%token TRUE;
%token FALSE;
%token NUMBER;
%token <szoveg> IDENT;
%token ASSIGN;

%union
{
  std::string *szoveg;
}

%%

start:
    declarations assignments
;

declarations:
    // ures
|
    declaration declarations
;

declaration:
    NATURAL IDENT 
    {
       std::cout << *$2 << std::endl; 
    }
|
    BOOLEAN IDENT
;

assignments:
    // ures
|
    assignment assignments
;

assignment:
    IDENT ASSIGN expr
;

expr:
    IDENT
|
    NUMBER
|
    TRUE
|
    FALSE
;
