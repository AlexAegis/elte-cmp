%baseclass-preinclude <iostream>
%lsp-needed


%token STMT_DOT
%token STMT_COMMA
%token STMT_OPN
%token PROGRAM
%token DATA
%token TYPE
%token TYPE_INTEGER
%token TYPE_BOOLEAN
%token BOOLEAN_TRUE
%token BOOLEAN_FALSE
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
%token PAR_OPN
%token PAR_CLS

%left LOGIC_AND LOGIC_OR
%left COMP_EQ
%left COMP_LS COMP_GT
%left MATH_SUB MATH_MULT MATH_DIV

%right LOGIC_NOT

%token VARIABLE
%token NUMBER

%%

start:
	prog_decl data_decl statements
	{
		std::cout << "start -> prog_decl data_decl statements" << std::endl;
	}
;

statements:
	// null
	{
		std::cout << "statements -> null" << std::endl;
	}
|
	statement statements
	{
		std::cout << "statements -> statement statements" << std::endl;
	}
;

statements_plus:
	statement statements
	{
		std::cout << "statements_plus -> statement statements" << std::endl;
	}
;

prog_decl:
	PROGRAM VARIABLE STMT_DOT
	{
		std::cout << "prog_decl -> PROGRAM VARIABLE STMT_DOT" << std::endl;
	}
;

data_decl:
	//null
	{
		std::cout << "data_decl -> null" << std::endl;
	}
|
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

statement:
	statement_move
	{
		std::cout << "statement -> statement_move" << std::endl;
	}
|
	statement_read
	{
		std::cout << "statement -> statement_read" << std::endl;
	}
|
	statement_write
	{
		std::cout << "statement -> statement_write" << std::endl;
	}
|
	statement_math_add
	{
		std::cout << "statement -> statement_math_add" << std::endl;
	}
|
	statement_math_sub
	{
		std::cout << "statement -> statement_math_sub" << std::endl;
	}
|
	statement_math_mult
	{
		std::cout << "statement -> statement_math_mult" << std::endl;
	}
|
	statement_math_div
	{
		std::cout << "statement -> statement_math_div" << std::endl;
	}
|
	struct_while
	{
		std::cout << "statement -> struct_while" << std::endl;
	}
|
	struct_if
	{
		std::cout << "statement -> struct_if" << std::endl;
	}
;

statement_move:
	OP_MOVE expression to_var STMT_DOT
	{
		std::cout << "statement_move -> OP_MOVE value to_var STMT_DOT" << std::endl;
	}
;

statement_read:
	OP_READ to_var STMT_DOT
	{
		std::cout << "statement_read -> OP_READ to_var STMT_DOT" << std::endl;
	}
;

statement_write:
	OP_WRITE expression STMT_DOT
	{
		std::cout << "statement_write -> OP_WRITE VARIABLE STMT_DOT" << std::endl;
	}
;

statement_math_add:
	OP_ADD expression to_var STMT_DOT
	{
		std::cout << "statement_math_add -> OP_ADD value to_var STMT_DOT" << std::endl;
	}
;

statement_math_sub:
	MATH_SUB expression DIR_FROM VARIABLE STMT_DOT
	{
		std::cout << "statement_math_sub -> MATH_SUB value DIR_FROM VARIABLE STMT_DOT" << std::endl;
	}
;

statement_math_mult:
	MATH_MULT VARIABLE DIR_BY value STMT_DOT
	{
		std::cout << "statement_math_mult -> MATH_MULT VARIABLE DIR_BY value STMT_DOT" << std::endl;
	}
;

statement_math_div:
	MATH_DIV VARIABLE DIR_BY value STMT_DOT
	{
		std::cout << "statement_math_div -> MATH_DIV VARIABLE DIR_BY value STMT_DOT" << std::endl;
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
	STRUCT_WHILE VARIABLE STMT_DOT statements STRUCT_ENDWHILE STMT_DOT
	{
		std::cout << "while -> STRUCT_WHILE statement STMT_DOT statements STRUCT_ENDWHILE STMT_DOT" << std::endl;
	}
;

struct_if:
	STRUCT_IF logic_body if_body STRUCT_ENDIF STMT_DOT
	{
		std::cout << "struct_if -> STRUCT_IF logic_body if_body STRUCT_ENDIF STMT_DOT" << std::endl;
	}
;

logic_body:
	expression STMT_DOT statements_plus
	{
		std::cout << "logic_body -> expression STMT_DOT statements_plus" << std::endl;
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
	STRUCT_ELSE STMT_DOT statements
	{
		std::cout << "if_else -> STRUCT_ELSE STMT_DOT statements" << std::endl;
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

expression:
	value
	{
		std::cout << "expression -> value" << std::endl;
	}
|
	literal_boolean
	{
		std::cout << "expression -> literal_boolean" << std::endl;
	}
|
	PAR_OPN expression PAR_CLS
	{
		std::cout << "expression -> PAR_CLS expression PAR_CLS" << std::endl;
	}
|
	LOGIC_NOT expression
	{
		std::cout << "expression -> LOGIC_NOT expression" << std::endl;
	}
|
	expression LOGIC_AND expression
	{
		std::cout << "expression -> expression LOGIC_AND expression" << std::endl;
	}
|
	expression LOGIC_OR expression
	{
		std::cout << "logic_bin_op -> expression LOGIC_OR expression" << std::endl;
	}
|
	expression COMP_LS expression
	{
		std::cout << "logic_bin_op -> expression COMP_LS expression" << std::endl;
	}
|
	expression COMP_GT expression
	{
		std::cout << "logic_bin_op -> expression COMP_GT expression" << std::endl;
	}
|
	expression COMP_EQ expression
	{
		std::cout << "logic_bin_op -> expression COMP_EQ expression" << std::endl;
	}
;

literal_boolean:
	BOOLEAN_FALSE
	{
		std::cout << "literal_boolean -> BOOLEAN_FALSE" << std::endl;
	}
|
	BOOLEAN_TRUE
	{
		std::cout << "literal_boolean -> BOOLEAN_TRUE" << std::endl;
	}
;