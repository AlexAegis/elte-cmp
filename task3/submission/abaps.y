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
%type <type> to_var;
%type <type> expression;
%type <type> literal_boolean;

%union
{
	Type *type;
	std::string *value;
}


%%

start:
	prog_decl data_decl statements {
		std::cout << "start -> prog_decl data_decl statements" << std::endl;
	}
;

statements:
	// null
	{
		std::cout << "statements -> null" << std::endl;
	}
|
	statement statements {
		std::cout << "statements -> statement statements" << std::endl;
	}
;

statements_plus:
	statement statements {
		std::cout << "statements_plus -> statement statements" << std::endl;
	}
;

prog_decl:
	PROGRAM VARIABLE STMT_DOT {
		std::cout << "prog_decl -> PROGRAM VARIABLE STMT_DOT" << std::endl;
	}
;

data_decl:
	//null 
	{
		std::cout << "data_decl -> null" << std::endl;
	}
|
	DATA STMT_OPN var_lines {
		std::cout << "data_decl -> DATA_STMT_OPN var_lines" << std::endl;
	}
;

var_lines:
	var_line var_lines {
		std::cout << "var_lines -> var_line var_lines" << std::endl;
	}
|
	var_last_line {
		std::cout << "var_line -> var_last_line" << std::endl;
	}
;

var_line_core:
	VARIABLE TYPE types {
		if (symbols.count(*$1) > 0) {
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
	var_line_core STMT_COMMA {
		std::cout << "var_line -> var_line_core STMT_COMMA" << std::endl;
	}
;

var_last_line:
	var_line_core STMT_DOT {
		std::cout << "var_last_line -> var_line_core STMT_DOT" << std::endl;
	}
;

types:
	TYPE_INTEGER {
		std::cout << "types -> TYPE_INTEGER" << std::endl;
		$$ = new Type(Integer);
	}
|
	TYPE_BOOLEAN {
		std::cout << "types -> TYPE_BOOLEAN" << std::endl;
		$$ = new Type(Boolean);
	}
;

statement:
	statement_move {
		std::cout << "statement -> statement_move" << std::endl;
	}
|
	statement_read {
		std::cout << "statement -> statement_read" << std::endl;
	}
|
	statement_write {
		std::cout << "statement -> statement_write" << std::endl;
	}
|
	statement_math_add {
		std::cout << "statement -> statement_math_add" << std::endl;
	}
|
	statement_math_sub {
		std::cout << "statement -> statement_math_sub" << std::endl;
	}
|
	statement_math_mult {
		std::cout << "statement -> statement_math_mult" << std::endl;
	}
|
	statement_math_div {
		std::cout << "statement -> statement_math_div" << std::endl;
	}
|
	struct_while {
		std::cout << "statement -> struct_while" << std::endl;
	}
|
	struct_if {
		std::cout << "statement -> struct_if" << std::endl;
	}
;

statement_move:
	OP_MOVE expression to_var STMT_DOT {
		std::cout << "statement_move -> OP_MOVE expression to_var STMT_DOT" << std::endl;

		if(*$2 != *$3) {
			std::stringstream ss;
			ss << "Both end needs to have the same types. Got instead from: \"" << typeNames[*$2] << "\" to: " << typeNames[*$3];
			error(ss.str().c_str());
		}
	}
;

statement_read:
	OP_READ to_var STMT_DOT {
		std::cout << "statement_read -> OP_READ to_var STMT_DOT" << std::endl;
	}
;

statement_write:
	OP_WRITE expression STMT_DOT {
		std::cout << "statement_write -> OP_WRITE expression STMT_DOT" << std::endl;
	}
;

statement_math_add:
	OP_ADD expression to_var STMT_DOT {
		std::cout << "statement_math_add -> OP_ADD expression to_var STMT_DOT" << std::endl;

		if(*$2 != Integer) {
			std::stringstream ss;
			ss << "Math add needs numerical value. \"" << *$2 << "\" got " << typeNames[*$2] << " instead of Integer.";
			std::cout << ss.str() << std::endl;
			error(ss.str().c_str());
		}

		if(*$3 != Integer) {
			std::stringstream ss;
			ss << "Math add needs numerical value. \"" << *$3 << "\" got " << typeNames[*$3] << " instead of Integer.";
			std::cout << ss.str() << std::endl;
			error(ss.str().c_str());
		}
	}
;

statement_math_sub:
	MATH_SUB expression DIR_FROM VARIABLE STMT_DOT {
		if (symbols.count(*$4) == 0) {
			std::stringstream ss;
			ss << "Not declared variable: \"" << *$4 << "\"";
			error(ss.str().c_str());
		}

		if(*$2 != Integer) {
			std::stringstream ss;
			ss << "Math sub needs numerical value. \"" << *$2 << "\" got " << typeNames[*$2] << " instead of Integer.";
			error(ss.str().c_str());
		}

		if(symbols[*$4].type != Integer) {
			std::stringstream ss;
			ss << "Math sub needs numerical value. \"" << *$4 << "\" got " << typeNames[symbols[*$4].type] << " instead of Integer.";
			error(ss.str().c_str());
		}

		std::cout << "statement_math_sub -> MATH_SUB expression DIR_FROM VARIABLE (" << symbols[*$4] << ") STMT_DOT" << std::endl;
	}
;

statement_math_mult:
	MATH_MULT VARIABLE DIR_BY expression STMT_DOT {
		if (symbols.count(*$2) == 0) {
			std::stringstream ss;
			ss << "Not declared variable: \"" << *$2 << "\"";
			error(ss.str().c_str());
		}

		if(symbols[*$2].type != Integer) {
			std::stringstream ss;
			ss << "Math mult needs numerical value. \"" << *$2 << "\" got " << typeNames[symbols[*$2].type] << " instead of Integer.";
			error(ss.str().c_str());
		}

		if(*$4 != Integer) {
			std::stringstream ss;
			ss << "Math mult needs numerical value. \"" << *$4 << "\" got " << typeNames[*$4] << " instead of Integer.";
			error(ss.str().c_str());
		}

		std::cout << "statement_math_mult -> MATH_MULT VARIABLE (" << symbols[*$2] << ") DIR_BY expression STMT_DOT" << std::endl;
	}
;

statement_math_div:
	MATH_DIV VARIABLE DIR_BY expression STMT_DOT {
		if (symbols.count(*$2) == 0) {
			std::stringstream ss;
			ss << "Not declared variable: \"" << *$2 << "\"";
			error(ss.str().c_str());
		}

		if(symbols[*$2].type != Integer) {
			std::stringstream ss;
			ss << "Math div needs numerical value. \"" << *$2 << "\" got " << typeNames[symbols[*$2].type] << " instead of Integer.";
			error(ss.str().c_str());
		}

		if(*$4 != Integer) {
			std::stringstream ss;
			ss << "Math div needs numerical value. \"" << *$4 << "\" got " << typeNames[*$4] << " instead of Integer.";
			error(ss.str().c_str());
		}
		
		std::cout << "statement_math_div -> MATH_DIV VARIABLE (" << symbols[*$2] << ") DIR_BY expression STMT_DOT" << std::endl;
	}
;

to_var:
	DIR_TO VARIABLE {
		std::cout << "to_var -> DIR_TO VARIABLE (" << symbols[*$2] << ")" << std::endl;

		if (symbols.count(*$2) == 0) {
			std::stringstream ss;
			ss << "Not declared variable: \"" << *$2 << "\"";
			error(ss.str().c_str());
		}

		$$ = new Type(symbols[*$2].type);
	}
;

struct_while:
	STRUCT_WHILE VARIABLE STMT_DOT statements STRUCT_ENDWHILE STMT_DOT {
		std::cout << "while -> STRUCT_WHILE statement STMT_DOT statements STRUCT_ENDWHILE STMT_DOT" << std::endl;
	}
;

struct_if:
	STRUCT_IF logic_body if_body STRUCT_ENDIF STMT_DOT {
		std::cout << "struct_if -> STRUCT_IF logic_body if_body STRUCT_ENDIF STMT_DOT" << std::endl;
	}
;

logic_body:
	expression STMT_DOT statements_plus {
		if(*$1 != Boolean) {
			std::stringstream ss;
			ss << "Logic expression needs to be Boolean. \"" << *$1 << "\" got " << typeNames[*$1] << " instead of Boolean.";
			error(ss.str().c_str());
		}

		std::cout << "logic_body -> expression STMT_DOT statements_plus" << std::endl;
	}
;

if_body:
	//null
	{
		std::cout << "if_body -> null" << std::endl;
	}
|
	if_else {
		std::cout << "if_body -> if_else" << std::endl;
	}
|
	if_elseif {
		std::cout << "if_body -> if_elseif" << std::endl;
	}
;

if_else:
	STRUCT_ELSE STMT_DOT statements {
		std::cout << "if_else -> STRUCT_ELSE STMT_DOT statements" << std::endl;
	}
;

if_elseif:
	STRUCT_ELSEIF logic_body if_elseif {
		std::cout << "if_elseif -> STRUCT_ELSEIF logic_body if_elseif" << std::endl;
	}
|
	STRUCT_ELSEIF logic_body {
		std::cout << "if_elseif -> STRUCT_ELSEIF logic_body" << std::endl;
	}
|
	STRUCT_ELSEIF logic_body if_else {
		std::cout << "if_elseif -> STRUCT_ELSEIF logic_body if_else" << std::endl;
	}
;

expression:
	VARIABLE {
		if (symbols.count(*$1) == 0) {
			std::stringstream ss;
			ss << "Not declared variable: \"" << *$1 << "\"";
			error(ss.str().c_str());
		}

		std::cout << "expression -> VARIABLE (name: " << symbols[*$1] << " type: " <<  typeNames[symbols[*$1].type] << ")" << std::endl;

		$$ = new Type(symbols[*$1].type);
	}
|
	NUMBER {
		std::cout << "expression -> NUMBER" << std::endl;

		$$ = new Type(Integer);
	}
|
	literal_boolean {
		std::cout << "expression -> literal_boolean" << std::endl;
		$$ = new Type(*$1);
	}
|
	PAR_OPN expression PAR_CLS {
		std::cout << "expression -> PAR_CLS expression (" << typeNames[*$2] << ") PAR_CLS" << std::endl;
		$$ = new Type(*$2);
	}
|
	LOGIC_NOT expression {
		if(*$2 != Boolean) {
			std::stringstream ss;
			ss << "Logical expressions needs boolean value. \"" << *$2 << "\" got " << typeNames[*$2] << " instead of Boolean.";
			error(ss.str().c_str());
		}

		std::cout << "expression -> LOGIC_NOT expression (" << typeNames[*$2] << ")" << std::endl;

		$$ = new Type(*$2);
	}
|
	expression LOGIC_AND expression {
		if(*$1 != Boolean) {
			std::stringstream ss;
			ss << "Logical expressions needs boolean value. \"" << *$1 << "\" got " << typeNames[*$1] << " instead of Boolean.";
			error(ss.str().c_str());
		}

		if(*$3 != Boolean) {
			std::stringstream ss;
			ss << "Logical expressions needs boolean value. \"" << *$3 << "\" got " << typeNames[*$3] << " instead of Boolean.";
			error(ss.str().c_str());
		}

		std::cout << "expression -> expression  (" << typeNames[*$1] << ") LOGIC_AND expression  (" << typeNames[*$3] << ")" << std::endl;

		$$ = new Type(*$1);
	}
|
	expression LOGIC_OR expression {
		if(*$1 != Boolean) {
			std::stringstream ss;
			ss << "Logical expressions needs boolean value. \"" << *$1 << "\" got " << typeNames[*$1] << " instead of Boolean.";
			error(ss.str().c_str());
		}

		if(*$3 != Boolean) {
			std::stringstream ss;
			ss << "Logical expressions needs boolean value. \"" << *$3 << "\" got " << typeNames[*$3] << " instead of Boolean.";
			error(ss.str().c_str());
		}

		std::cout << "expression -> expression  (" << typeNames[*$1] << ") LOGIC_OR expression  (" << typeNames[*$3] << ")" << std::endl;

		$$ = new Type(*$1);
	}
|
	expression COMP_LS expression {
		if(*$1 != Integer) {
			std::stringstream ss;
			ss << "Comparisons needs numerical values. \"" << *$1 << "\" got " << typeNames[*$1] << " instead of Integer.";
			error(ss.str().c_str());
		}

		if(*$3 != Integer) {
			std::stringstream ss;
			ss << "Logical expressions needs boolean value. \"" << *$3 << "\" got " << typeNames[*$3] << " instead of Boolean.";
			error(ss.str().c_str());
		}
	
		std::cout << "expression -> expression (" << typeNames[*$1] << ") LOGIC_OR expression  (" << typeNames[*$3] << ")" << std::endl;

		$$ = new Type(Boolean);
	}
|
	expression COMP_GT expression {
		if(*$1 != Integer) {
			std::stringstream ss;
			ss << "Comparisons needs numerical values. \"" << *$1 << "\" got " << typeNames[*$1] << " instead of Integer.";
			error(ss.str().c_str());
		}

		if(*$3 != Integer) {
			std::stringstream ss;
			ss << "Logical expressions needs boolean value. \"" << *$3 << "\" got " << typeNames[*$3] << " instead of Boolean.";
			error(ss.str().c_str());
		}
		std::cout << "expression -> expression (" << typeNames[*$1] << ") COMP_GT expression  (" << typeNames[*$3] << ")" << std::endl;

		$$ = new Type(Boolean);
	}
|
	expression COMP_EQ expression {
		if(*$1 != *$3) {
			std::stringstream ss;
			ss << "Equals needs identical expressions. \"" << *$1 << "\" got " << typeNames[*$1] << " and \"" << *$3 << "\" got " << typeNames[*$3] << std::endl;
			error(ss.str().c_str());
		}

		std::cout << "expression -> expression (" << typeNames[*$1] << ") COMP_EQ expression  (" << typeNames[*$3] << ")" << std::endl;

		$$ = new Type(Boolean);
	}
;

literal_boolean:
	BOOLEAN_FALSE {
		std::cout << "literal_boolean -> BOOLEAN_FALSE" << std::endl;
		$$ = new Type(Boolean);
	}
|
	BOOLEAN_TRUE {
		std::cout << "literal_boolean -> BOOLEAN_TRUE" << std::endl;
		$$ = new Type(Boolean);
	}
;