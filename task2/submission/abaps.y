%baseclass-preinclude <iostream>
%lsp-needed

%token STMT_DOT
%token STMT_COMMA
%token STMT_OPN
%token COMMENT
%token PROGRAM
%token DATA
%token TYPE
%token TYPE_INTEGER
%token TYPE_BOOLEAN
%token OP_MOVE
%token OP_READ
%token OP_ADD
%token OP_WRITE
%token DIR_TO
%token DIR_BY
%token DIR_FROM
%token STRUCT_IF
%token STRUCT_WHILE
%token STRUCT_ELSE
%token STRUCT_ELSEIF
%token STRUCT_ENDIF
%token STRUCT_ENDWHILE
%token COMP_LS
%token COMP_GT
%token COMP_EQ
%token LOGIC_AND
%token LOGIC_OR
%token LOGIC_NOT
%token MATH_SUB
%token MATH_MULT
%token MATH_DIV

%token VARIABLE
%token NUMBER

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