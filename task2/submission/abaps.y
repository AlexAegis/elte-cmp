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
	// null
	{
		std::cout << "expressions -> null" << std::endl;
	}
|
	prog_decl expressions
	{
		std::cout << "expressions -> prog_decl expressions" << std::endl;
	}
|
	data_decl expressions
	{
		std::cout << "expressions -> data_decl expressions" << std::endl;
	}
|
	exp expressions
	{
		std::cout << "expressions -> exp expressions" << std::endl;
	}

;

prog_decl:
	PROGRAM VARIABLE STMT_DOT
	{
		std::cout << "prog_decl -> PROGRAM VARIABLE STMT_DOT" << std::endl;
	}
;

data_decl:
	DATA STMT_OPN var_lines
	{
		std::cout << "data_decl -> DATA_STMT_OPN var_lines" << std::endl;
	}
;

var_lines:
	var_line var_lines
	{
		std::cout << "var_lines -> var_line var_lines" << std::endl;
	}
|
	var_last_line
	{
		std::cout << "var_line -> var_last_line" << std::endl;
	}
;

var_line_core:
	VARIABLE TYPE types
	{
		std::cout << "var_line -> VARIABLE TYPE types" << std::endl;
	}
;

var_line:
	var_line_core STMT_COMMA
	{
		std::cout << "var_line -> var_line_core STMT_COMMA" << std::endl;
	}
;

var_last_line:
	var_line_core STMT_DOT
	{
		std::cout << "var_last_line -> var_line_core STMT_DOT" << std::endl;
	}
;

types:
	TYPE_INTEGER
	{
		std::cout << "types -> TYPE_INTEGER" << std::endl;
	}
|
	TYPE_BOOLEAN
	{
		std::cout << "types -> TYPE_BOOLEAN" << std::endl;
	}
;

exp:
	COMMENT
	{
		std::cout << "exp -> COMMENT" << std::endl;
	}
|
	OP_MOVE VARIABLE to_var STMT_DOT
	{
		std::cout << "exp -> OP_MOVE variable to_var STMT_DOT" << std::endl;
	}
|
	OP_MOVE NUMBER to_var STMT_DOT
	{
		std::cout << "exp -> OP_MOVE NUMBER to_var STMT_DOT" << std::endl;
	}
|
	OP_READ to_var
	{
		std::cout << "exp -> OP_READ to_var" << std::endl;
	}
|
	OP_WRITE VARIABLE
	{
		std::cout << "exp -> OP_WRITE VARIABLE" << std::endl;
	}
;

to_var:
	DIR_TO VARIABLE
	{
		std::cout << "to_var -> DIR_TO variable" << std::endl;
	}
;


