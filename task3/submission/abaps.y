%baseclass-preinclude "semantics.h"
%lsp-needed


%token STMT_DOT
%token STMT_COMMA
%token STMT_OPN
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
%token PAR_OPN
%token PAR_CLS

%left LOGIC_AND LOGIC_OR
%left COMP_EQ
%left COMP_LS COMP_GT
%left MATH_SUB MATH_MULT MATH_DIV

%right LOGIC_NOT

%token <value> BOOLEAN_TRUE
%token <value> BOOLEAN_FALSE

%token <value> VARIABLE
%token <value> NUMBER

%type <type> types;
%type <type> expression;

%union
{
	Type *type;
	std::string *value;
}


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
		std::cout << "var_line -> VARIABLE TYPE TYPE_INTEGER" << std::endl;

        
		if (symbols.count(*$1) > 0)
		{
			std::stringstream ss;
			ss << "Already declared variable: \"" << *$1 << "\", Previous declaration: " 
				<< symbols[*$1].row;
			error(ss.str().c_str());
		}
		
		symbols[*$1] = VarData(d_loc__.first_line, *$3);

		std::cout << "var_line -> VARIABLE (" << symbols[*$1] << ") TYPE TYPE_INTEGER" << std::endl;
		
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
		$$ = new Type(Integer);
	}
|
	TYPE_BOOLEAN
	{
		std::cout << "types -> TYPE_BOOLEAN" << std::endl;
		$$ = new Type(Boolean);
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
		std::cout << "statement_move -> OP_MOVE expression to_var STMT_DOT" << std::endl;
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
		std::cout << "statement_math_add -> OP_ADD expression to_var STMT_DOT" << std::endl;
	}
;

statement_math_sub:
	MATH_SUB expression DIR_FROM VARIABLE STMT_DOT
	{
		std::cout << "statement_math_sub -> MATH_SUB expression DIR_FROM VARIABLE STMT_DOT" << std::endl;
	}
;

statement_math_mult:
	MATH_MULT VARIABLE DIR_BY expression STMT_DOT
	{
		std::cout << "statement_math_mult -> MATH_MULT VARIABLE DIR_BY expression STMT_DOT" << std::endl;
	}
;

statement_math_div:
	MATH_DIV VARIABLE DIR_BY expression STMT_DOT
	{
		std::cout << "statement_math_div -> MATH_DIV VARIABLE DIR_BY expression STMT_DOT" << std::endl;
	}
;

to_var:
	DIR_TO VARIABLE
	{
		std::cout << "to_var -> DIR_TO VARIABLE" << std::endl;
		//$$ = new Type(symbols[*$2].type);
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
	VARIABLE
	{
		std::cout << "expression -> VARIABLE" << std::endl;

		// TODO only if variable is declared as boolean
		
		$$ = new Type(symbols[*$1].type);
	}
|
	NUMBER
	{
		std::cout << "expression -> NUMBER" << std::endl;
		/*
		if(symbols.count(*$1) == 0)
		{
			std::stringstream ss;
			ss << " Undeclared variable: " << *$1;
			error(ss.str().c_str());
		}
		*/
		$$ = new Type(Integer);
	}
|
	literal_boolean
	{
		std::cout << "expression -> literal_boolean" << std::endl;
		//$$ = $1;
	}
|
	PAR_OPN expression PAR_CLS
	{
		std::cout << "expression -> PAR_CLS expression PAR_CLS" << std::endl;
		//$$ = $2;
	}
|
	LOGIC_NOT expression
	{
		std::cout << "expression -> LOGIC_NOT expression" << std::endl;
		// TODO: if expression is not boolean then error
		//$$ = $2;
	}
|
	expression LOGIC_AND expression
	{
		std::cout << "expression -> expression LOGIC_AND expression" << std::endl;
		// TODO: if expression is not boolean then error
		//$$ = $1;
	}
|
	expression LOGIC_OR expression
	{
		std::cout << "logic_bin_op -> expression LOGIC_OR expression" << std::endl;
		// TODO: if expression is not boolean then error
		//$$ = $1;
	}
|
	expression COMP_LS expression
	{
		std::cout << "logic_bin_op -> expression COMP_LS expression" << std::endl;
		// TODO: if expression is not integer then error
		//$$ = $1;
	}
|
	expression COMP_GT expression
	{
		std::cout << "logic_bin_op -> expression COMP_GT expression" << std::endl;
		// TODO: if expression is not integer then error
		//$$ = $1;
	}
|
	expression COMP_EQ expression
	{
		std::cout << "logic_bin_op -> expression COMP_EQ expression" << std::endl;
		// TODO: if expression is not integer then error
		//$$ = $1;
	}
;

literal_boolean:
	BOOLEAN_FALSE
	{
		std::cout << "literal_boolean -> BOOLEAN_FALSE" << std::endl;
		//$$ = new Type(Boolean);
	}
|
	BOOLEAN_TRUE
	{
		std::cout << "literal_boolean -> BOOLEAN_TRUE" << std::endl;
		//$$ = new Type(Boolean);
	}
;