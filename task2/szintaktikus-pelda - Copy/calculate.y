%baseclass-preinclude <iostream>
%lsp-needed

%token NUMBER
%token OPEN
%token CLOSE

%left EQUAL
%left PLUS MINUS

%%

start:
    expressions
    {
        std::cout << "start -> expressions" << std::endl;
    }
;

expressions:
    // ures
    {
        std::cout << "expressions -> epszilon" << std::endl;
    }
|
    exp expressions
    {
        std::cout << "expressions -> exp expressions" << std::endl;
    }
;

exp:
    NUMBER
    {
        std::cout << "exp -> NUMBER" << std::endl;
    }
|
    exp PLUS exp
    {
        std::cout << "exp -> exp PLUS exp" << std::endl;
    }
|
    exp MINUS exp
    {
        std::cout << "exp -> exp MINUS exp" << std::endl;
    }
|
    exp EQUAL exp
    {
        std::cout << "exp -> exp EQUAL exp" << std::endl;
    }
|
    OPEN exp CLOSE
    {
        std::cout << "exp -> OPEN exp CLOSE" << std::endl;
    }
;
