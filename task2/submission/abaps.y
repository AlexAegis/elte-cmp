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
%left COMP_LS
%left COMP_GT
%left COMP_EQ
%left LOGIC_AND
%left LOGIC_OR
%right LOGIC_NOT
%left MATH_SUB
%left MATH_MULT
%left MATH_DIV

%token VARIABLE
%token NUMBER

%%

start:
	prog_decl expressions
	{
		std::cout << "start -> prog_decl expressions" << std::endl;
	}
|
	comments prog_decl expressions
	{
		std::cout << "start -> comments prog_decl expressions" << std::endl;
	}
;

expressions:
	// null
	{
		std::cout << "expressions -> null" << std::endl;
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
|
	comments expressions
	{
		std::cout << "expressions -> comments expressions" << std::endl;
	}
;

expressions_plus:
	comments exp expressions
	{
		std::cout << "expressions_plus -> comments exp expressions" << std::endl;
	}
|
	exp expressions
	{
		std::cout << "expressions_plus -> exp expressions" << std::endl;
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
	comments var_lines
	{
		std::cout << "var_lines -> COMMENT var_lines" << std::endl;
	}
|
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

comments:
	COMMENT
	{
		std::cout << "comments -> COMMENT" << std::endl;
	}
|
	COMMENT comments
	{
		std::cout << "comments -> COMMENT comments" << std::endl;
	}
;

exp:
	OP_MOVE value to_var STMT_DOT
	{
		std::cout << "exp -> OP_MOVE value to_var STMT_DOT" << std::endl;
	}
|
	OP_READ to_var STMT_DOT
	{
		std::cout << "exp -> OP_READ to_var STMT_DOT" << std::endl;
	}
|
	OP_WRITE value STMT_DOT
	{
		std::cout << "exp -> OP_WRITE VARIABLE STMT_DOT" << std::endl;
	}
|
	OP_ADD value to_var STMT_DOT
	{
		std::cout << "exp -> OP_ADD value to_var STMT_DOT" << std::endl;
	}
|
	MATH_SUB value DIR_FROM VARIABLE STMT_DOT
	{
		std::cout << "exp -> MATH_SUB value DIR_FROM VARIABLE STMT_DOT" << std::endl;
	}
|
	MATH_MULT VARIABLE DIR_BY value STMT_DOT
	{
		std::cout << "exp -> MATH_MULT VARIABLE DIR_BY value STMT_DOT" << std::endl;
	}
|
	MATH_DIV VARIABLE DIR_BY value STMT_DOT
	{
		std::cout << "exp -> MATH_DIV VARIABLE DIR_BY value STMT_DOT" << std::endl;
	}
|
	struct_while
	{
		std::cout << "exp -> struct_while" << std::endl;
	}
|
	struct_if
	{
		std::cout << "exp -> struct_if" << std::endl;
	}
;

value:
	VARIABLE
	{
		std::cout << "value -> VARIABLE" << std::endl;
	}
|
	NUMBER
	{
		std::cout << "value -> NUMBER" << std::endl;
	}
;

to_var:
	DIR_TO VARIABLE
	{
		std::cout << "to_var -> DIR_TO variable" << std::endl;
	}
;

struct_while:
	STRUCT_WHILE VARIABLE STMT_DOT expressions STRUCT_ENDWHILE STMT_DOT
	{
		std::cout << "while -> STRUCT_WHILE exp STMT_DOT expressions STRUCT_ENDWHILE STMT_DOT" << std::endl;
	}
;

struct_if:
	STRUCT_IF logic_body if_body STRUCT_ENDIF STMT_DOT
	{
		std::cout << "struct_if -> STRUCT_IF logic_body if_body STRUCT_ENDIF STMT_DOT" << std::endl;
	}
;

logic_body:
	logic_exp STMT_DOT expressions_plus
	{
		std::cout << "logic_body -> logic_exp STMT_DOT expressions_plus" << std::endl;
	}
;

if_body:
	//null
	{
		std::cout << "if_body -> null" << std::endl;
	}
|
	if_else
	{
		std::cout << "if_body -> if_else" << std::endl;
	}
|
	if_elseif
	{
		std::cout << "if_body -> if_elseif" << std::endl;
	}
;

if_else:
	STRUCT_ELSE STMT_DOT expressions
	{
		std::cout << "if_else -> STRUCT_ELSE expressions" << std::endl;
	}
;

if_elseif:
	STRUCT_ELSEIF logic_body if_elseif
	{
		std::cout << "if_elseif -> STRUCT_ELSEIF logic_body if_elseif" << std::endl;
	}
|
	STRUCT_ELSEIF logic_body
	{
		std::cout << "if_elseif -> STRUCT_ELSEIF logic_body" << std::endl;
	}
|
	STRUCT_ELSEIF logic_body if_else
	{
		std::cout << "if_elseif -> STRUCT_ELSEIF logic_body if_else" << std::endl;
	}
;

logic_exp:
	logic_exp logic_bin_op logic_exp
	{
		std::cout << "logic_exp -> logic_exp logic_bin_op logic_exp" << std::endl;
	}
|
	logic_un_op logic_exp
	{
		std::cout << "logic_exp -> logic_un_op logic_exp" << std::endl;
	}
|
	VARIABLE
	{
		std::cout << "logic_exp -> VARIABLE" << std::endl;
	}
|
	NUMBER
	{
		std::cout << "logic_exp -> NUMBER" << std::endl;
	}
;


logic_un_op:
	LOGIC_NOT
	{
		std::cout << "logic_un_op -> LOGIC_NOT" << std::endl;
	}
;

logic_bin_op:
	LOGIC_AND
	{
		std::cout << "logic_bin_op -> LOGIC_AND" << std::endl;
	}
|
	LOGIC_OR
	{
		std::cout << "logic_bin_op -> LOGIC_OR" << std::endl;
	}
|
	COMP_LS
	{
		std::cout << "logic_bin_op -> COMP_LS" << std::endl;
	}
|
	COMP_GT
	{
		std::cout << "logic_bin_op -> COMP_GT" << std::endl;
	}
|
	COMP_EQ
	{
		std::cout << "logic_bin_op -> COMP_EQ" << std::endl;
	}
;
