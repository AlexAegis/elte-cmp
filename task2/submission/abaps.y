%baseclass-preinclude <iostream>
%lsp-needed

%token STMT_DOT
%token STMT_COMMA
%token STMT_OPN
%token COMMENT
%token DATA
%token TYPE
%token TYPE_INTEGER
%token TYPE_BOOLEAN

%token VARIABLE

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
	DATA d1
	{
		std::cout << "expressions -> DATA" << std::endl;
	}
|
	COMMENT expressions
	{
		std::cout << "expressions -> COMMENT expressions" << std::endl;
	}
;

d1:
	STMT_OPN d2
	{
		std::cout << "d1 -> STMT_OPN d2" << std::endl;
	}
;

d2:
	VARIABLE dl1
	{
		std::cout << "d2 -> VARIABLE dl1" << std::endl;
	}
;

dl1:
	TYPE dl2
	{
		std::cout << "dl1 -> TYPE dl2" << std::endl;
	}
;

dl2:
	TYPE_INTEGER dl3
	{
		std::cout << "dl2 -> TYPE_INTEGER dl3" << std::endl;
	}
|
	TYPE_BOOLEAN dl3
	{
		std::cout << "dl2 -> TYPE_BOOLEAN dl3" << std::endl;
	}
;

dl3:
	STMT_COMMA dl2
	{
		std::cout << "dl3 -> STMT_COMMA dl2" << std::endl;
	}
|
	STMT_DOT expressions
	{
		std::cout << "dl3 -> STMT_DOT expressions" << std::endl;
	}
;