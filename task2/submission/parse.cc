// Generated by Bisonc++ V4.13.01 on Sat, 24 Mar 2018 21:29:42 +0100

// $insert class.ih
#include "Parser.ih"

// The FIRST element of SR arrays shown below uses `d_type', defining the
// state's type, and `d_lastIdx' containing the last element's index. If
// d_lastIdx contains the REQ_TOKEN bitflag (see below) then the state needs
// a token: if in this state d_token__ is _UNDETERMINED_, nextToken() will be
// called

// The LAST element of SR arrays uses `d_token' containing the last retrieved
// token to speed up the (linear) seach.  Except for the first element of SR
// arrays, the field `d_action' is used to determine what to do next. If
// positive, it represents the next state (used with SHIFT); if zero, it
// indicates `ACCEPT', if negative, -d_action represents the number of the
// rule to reduce to.

// `lookup()' tries to find d_token__ in the current SR array. If it fails, and
// there is no default reduction UNEXPECTED_TOKEN__ is thrown, which is then
// caught by the error-recovery function.

// The error-recovery function will pop elements off the stack until a state
// having bit flag ERR_ITEM is found. This state has a transition on _error_
// which is applied. In this _error_ state, while the current token is not a
// proper continuation, new tokens are obtained by nextToken(). If such a
// token is found, error recovery is successful and the token is
// handled according to the error state's SR table and parsing continues.
// During error recovery semantic actions are ignored.

// A state flagged with the DEF_RED flag will perform a default
// reduction if no other continuations are available for the current token.

// The ACCEPT STATE never shows a default reduction: when it is reached the
// parser returns ACCEPT(). During the grammar
// analysis phase a default reduction may have been defined, but it is
// removed during the state-definition phase.

// So:
//      s_x[] = 
//      {
//                  [_field_1_]         [_field_2_]
//
// First element:   {state-type,        idx of last element},
// Other elements:  {required token,    action to perform},
//                                      ( < 0: reduce, 
//                                          0: ACCEPT,
//                                        > 0: next state)
// Last element:    {set to d_token__,    action to perform}
//      }

// When the --thread-safe option is specified, all static data are defined as
// const. If --thread-safe is not provided, the state-tables are not defined
// as const, since the lookup() function below will modify them


namespace // anonymous
{
    char const author[] = "Frank B. Brokken (f.b.brokken@rug.nl)";

    enum 
    {
        STACK_EXPANSION = 5     // size to expand the state-stack with when
                                // full
    };

    enum ReservedTokens
    {
        PARSE_ACCEPT     = 0,   // `ACCEPT' TRANSITION
        _UNDETERMINED_   = -2,
        _EOF_            = -1,
        _error_          = 256
    };
    enum StateType       // modify statetype/data.cc when this enum changes
    {
        NORMAL,
        ERR_ITEM,
        REQ_TOKEN,
        ERR_REQ,    // ERR_ITEM | REQ_TOKEN
        DEF_RED,    // state having default reduction
        ERR_DEF,    // ERR_ITEM | DEF_RED
        REQ_DEF,    // REQ_TOKEN | DEF_RED
        ERR_REQ_DEF // ERR_ITEM | REQ_TOKEN | DEF_RED
    };    
    struct PI__     // Production Info
    {
        size_t d_nonTerm; // identification number of this production's
                            // non-terminal 
        size_t d_size;    // number of elements in this production 
    };

    struct SR__     // Shift Reduce info, see its description above
    {
        union
        {
            int _field_1_;      // initializer, allowing initializations 
                                // of the SR s_[] arrays
            int d_type;
            int d_token;
        };
        union
        {
            int _field_2_;

            int d_lastIdx;          // if negative, the state uses SHIFT
            int d_action;           // may be negative (reduce), 
                                    // postive (shift), or 0 (accept)
            size_t d_errorState;    // used with Error states
        };
    };

    // $insert staticdata
    
// Productions Info Records:
PI__ const s_productionInfo[] = 
{
     {0, 0}, // not used: reduction values are negative
     {290, 1}, // 1: start ->  expressions
     {291, 0}, // 2: expressions ->  <empty>
     {291, 2}, // 3: expressions ->  prog_decl expressions
     {291, 2}, // 4: expressions ->  data_decl expressions
     {291, 2}, // 5: expressions ->  exp expressions
     {292, 3}, // 6: prog_decl (PROGRAM) ->  PROGRAM VARIABLE STMT_DOT
     {293, 3}, // 7: data_decl (DATA) ->  DATA STMT_OPN var_lines
     {295, 2}, // 8: var_lines ->  var_line var_lines
     {295, 1}, // 9: var_lines ->  var_last_line
     {298, 3}, // 10: var_line_core (VARIABLE) ->  VARIABLE TYPE types
     {296, 2}, // 11: var_line (STMT_COMMA) ->  var_line_core STMT_COMMA
     {297, 2}, // 12: var_last_line (STMT_DOT) ->  var_line_core STMT_DOT
     {299, 1}, // 13: types (TYPE_INTEGER) ->  TYPE_INTEGER
     {299, 1}, // 14: types (TYPE_BOOLEAN) ->  TYPE_BOOLEAN
     {294, 1}, // 15: exp (COMMENT) ->  COMMENT
     {294, 4}, // 16: exp (OP_MOVE) ->  OP_MOVE VARIABLE to_var STMT_DOT
     {294, 4}, // 17: exp (OP_MOVE) ->  OP_MOVE NUMBER to_var STMT_DOT
     {294, 3}, // 18: exp (OP_READ) ->  OP_READ to_var STMT_DOT
     {294, 3}, // 19: exp (OP_WRITE) ->  OP_WRITE VARIABLE STMT_DOT
     {294, 4}, // 20: exp (OP_ADD) ->  OP_ADD VARIABLE to_var STMT_DOT
     {294, 1}, // 21: exp ->  struct_while
     {294, 1}, // 22: exp ->  struct_if
     {300, 2}, // 23: to_var (DIR_TO) ->  DIR_TO VARIABLE
     {301, 6}, // 24: struct_while (STRUCT_WHILE) ->  STRUCT_WHILE VARIABLE STMT_DOT expressions STRUCT_ENDWHILE STMT_DOT
     {302, 6}, // 25: struct_if (STRUCT_IF) ->  STRUCT_IF logic_exp STMT_DOT expressions STRUCT_ENDIF STMT_DOT
     {303, 3}, // 26: logic_exp ->  logic_exp logic_bin_op logic_exp
     {303, 2}, // 27: logic_exp ->  logic_un_op logic_exp
     {303, 1}, // 28: logic_exp (VARIABLE) ->  VARIABLE
     {303, 1}, // 29: logic_exp (NUMBER) ->  NUMBER
     {305, 1}, // 30: logic_un_op (LOGIC_NOT) ->  LOGIC_NOT
     {304, 1}, // 31: logic_bin_op (LOGIC_AND) ->  LOGIC_AND
     {304, 1}, // 32: logic_bin_op (LOGIC_OR) ->  LOGIC_OR
     {304, 1}, // 33: logic_bin_op (COMP_LS) ->  COMP_LS
     {304, 1}, // 34: logic_bin_op (COMP_GT) ->  COMP_GT
     {304, 1}, // 35: logic_bin_op (COMP_EQ) ->  COMP_EQ
     {306, 1}, // 36: start_$ ->  start
};

// State info and SR__ transitions for each state.


SR__ s_0[] =
{
    { { REQ_DEF}, { 17} },                
    { {     290}, {  1} }, // start       
    { {     291}, {  2} }, // expressions 
    { {     292}, {  3} }, // prog_decl   
    { {     293}, {  4} }, // data_decl   
    { {     294}, {  5} }, // exp         
    { {     261}, {  6} }, // PROGRAM     
    { {     262}, {  7} }, // DATA        
    { {     260}, {  8} }, // COMMENT     
    { {     266}, {  9} }, // OP_MOVE     
    { {     267}, { 10} }, // OP_READ     
    { {     269}, { 11} }, // OP_WRITE    
    { {     268}, { 12} }, // OP_ADD      
    { {     301}, { 13} }, // struct_while
    { {     302}, { 14} }, // struct_if   
    { {     274}, { 15} }, // STRUCT_WHILE
    { {     273}, { 16} }, // STRUCT_IF   
    { {       0}, { -2} },                
};

SR__ s_1[] =
{
    { { REQ_TOKEN}, {            2} }, 
    { {     _EOF_}, { PARSE_ACCEPT} }, 
    { {         0}, {            0} }, 
};

SR__ s_2[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -1} }, 
};

SR__ s_3[] =
{
    { { REQ_DEF}, { 16} },                
    { {     291}, { 17} }, // expressions 
    { {     292}, {  3} }, // prog_decl   
    { {     293}, {  4} }, // data_decl   
    { {     294}, {  5} }, // exp         
    { {     261}, {  6} }, // PROGRAM     
    { {     262}, {  7} }, // DATA        
    { {     260}, {  8} }, // COMMENT     
    { {     266}, {  9} }, // OP_MOVE     
    { {     267}, { 10} }, // OP_READ     
    { {     269}, { 11} }, // OP_WRITE    
    { {     268}, { 12} }, // OP_ADD      
    { {     301}, { 13} }, // struct_while
    { {     302}, { 14} }, // struct_if   
    { {     274}, { 15} }, // STRUCT_WHILE
    { {     273}, { 16} }, // STRUCT_IF   
    { {       0}, { -2} },                
};

SR__ s_4[] =
{
    { { REQ_DEF}, { 16} },                
    { {     291}, { 18} }, // expressions 
    { {     292}, {  3} }, // prog_decl   
    { {     293}, {  4} }, // data_decl   
    { {     294}, {  5} }, // exp         
    { {     261}, {  6} }, // PROGRAM     
    { {     262}, {  7} }, // DATA        
    { {     260}, {  8} }, // COMMENT     
    { {     266}, {  9} }, // OP_MOVE     
    { {     267}, { 10} }, // OP_READ     
    { {     269}, { 11} }, // OP_WRITE    
    { {     268}, { 12} }, // OP_ADD      
    { {     301}, { 13} }, // struct_while
    { {     302}, { 14} }, // struct_if   
    { {     274}, { 15} }, // STRUCT_WHILE
    { {     273}, { 16} }, // STRUCT_IF   
    { {       0}, { -2} },                
};

SR__ s_5[] =
{
    { { REQ_DEF}, { 16} },                
    { {     291}, { 19} }, // expressions 
    { {     292}, {  3} }, // prog_decl   
    { {     293}, {  4} }, // data_decl   
    { {     294}, {  5} }, // exp         
    { {     261}, {  6} }, // PROGRAM     
    { {     262}, {  7} }, // DATA        
    { {     260}, {  8} }, // COMMENT     
    { {     266}, {  9} }, // OP_MOVE     
    { {     267}, { 10} }, // OP_READ     
    { {     269}, { 11} }, // OP_WRITE    
    { {     268}, { 12} }, // OP_ADD      
    { {     301}, { 13} }, // struct_while
    { {     302}, { 14} }, // struct_if   
    { {     274}, { 15} }, // STRUCT_WHILE
    { {     273}, { 16} }, // STRUCT_IF   
    { {       0}, { -2} },                
};

SR__ s_6[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       288}, { 20} }, // VARIABLE
    { {         0}, {  0} },            
};

SR__ s_7[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       259}, { 21} }, // STMT_OPN
    { {         0}, {  0} },            
};

SR__ s_8[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -15} }, 
};

SR__ s_9[] =
{
    { { REQ_TOKEN}, {  3} },            
    { {       288}, { 22} }, // VARIABLE
    { {       289}, { 23} }, // NUMBER  
    { {         0}, {  0} },            
};

SR__ s_10[] =
{
    { { REQ_TOKEN}, {  3} },          
    { {       300}, { 24} }, // to_var
    { {       270}, { 25} }, // DIR_TO
    { {         0}, {  0} },          
};

SR__ s_11[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       288}, { 26} }, // VARIABLE
    { {         0}, {  0} },            
};

SR__ s_12[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       288}, { 27} }, // VARIABLE
    { {         0}, {  0} },            
};

SR__ s_13[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -21} }, 
};

SR__ s_14[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -22} }, 
};

SR__ s_15[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       288}, { 28} }, // VARIABLE
    { {         0}, {  0} },            
};

SR__ s_16[] =
{
    { { REQ_TOKEN}, {  6} },               
    { {       303}, { 29} }, // logic_exp  
    { {       305}, { 30} }, // logic_un_op
    { {       288}, { 31} }, // VARIABLE   
    { {       289}, { 32} }, // NUMBER     
    { {       284}, { 33} }, // LOGIC_NOT  
    { {         0}, {  0} },               
};

SR__ s_17[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -3} }, 
};

SR__ s_18[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -4} }, 
};

SR__ s_19[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -5} }, 
};

SR__ s_20[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 34} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_21[] =
{
    { { REQ_TOKEN}, {  6} },                 
    { {       295}, { 35} }, // var_lines    
    { {       296}, { 36} }, // var_line     
    { {       297}, { 37} }, // var_last_line
    { {       298}, { 38} }, // var_line_core
    { {       288}, { 39} }, // VARIABLE     
    { {         0}, {  0} },                 
};

SR__ s_22[] =
{
    { { REQ_TOKEN}, {  3} },          
    { {       300}, { 40} }, // to_var
    { {       270}, { 25} }, // DIR_TO
    { {         0}, {  0} },          
};

SR__ s_23[] =
{
    { { REQ_TOKEN}, {  3} },          
    { {       300}, { 41} }, // to_var
    { {       270}, { 25} }, // DIR_TO
    { {         0}, {  0} },          
};

SR__ s_24[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 42} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_25[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       288}, { 43} }, // VARIABLE
    { {         0}, {  0} },            
};

SR__ s_26[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 44} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_27[] =
{
    { { REQ_TOKEN}, {  3} },          
    { {       300}, { 45} }, // to_var
    { {       270}, { 25} }, // DIR_TO
    { {         0}, {  0} },          
};

SR__ s_28[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 46} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_29[] =
{
    { { REQ_TOKEN}, {  8} },                
    { {       257}, { 47} }, // STMT_DOT    
    { {       304}, { 48} }, // logic_bin_op
    { {       282}, { 49} }, // LOGIC_AND   
    { {       283}, { 50} }, // LOGIC_OR    
    { {       279}, { 51} }, // COMP_LS     
    { {       280}, { 52} }, // COMP_GT     
    { {       281}, { 53} }, // COMP_EQ     
    { {         0}, {  0} },                
};

SR__ s_30[] =
{
    { { REQ_TOKEN}, {  6} },               
    { {       303}, { 54} }, // logic_exp  
    { {       305}, { 30} }, // logic_un_op
    { {       288}, { 31} }, // VARIABLE   
    { {       289}, { 32} }, // NUMBER     
    { {       284}, { 33} }, // LOGIC_NOT  
    { {         0}, {  0} },               
};

SR__ s_31[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -28} }, 
};

SR__ s_32[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -29} }, 
};

SR__ s_33[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -30} }, 
};

SR__ s_34[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -6} }, 
};

SR__ s_35[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -7} }, 
};

SR__ s_36[] =
{
    { { REQ_TOKEN}, {  6} },                 
    { {       295}, { 55} }, // var_lines    
    { {       296}, { 36} }, // var_line     
    { {       297}, { 37} }, // var_last_line
    { {       298}, { 38} }, // var_line_core
    { {       288}, { 39} }, // VARIABLE     
    { {         0}, {  0} },                 
};

SR__ s_37[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -9} }, 
};

SR__ s_38[] =
{
    { { REQ_TOKEN}, {  3} },              
    { {       258}, { 56} }, // STMT_COMMA
    { {       257}, { 57} }, // STMT_DOT  
    { {         0}, {  0} },              
};

SR__ s_39[] =
{
    { { REQ_TOKEN}, {  2} },        
    { {       263}, { 58} }, // TYPE
    { {         0}, {  0} },        
};

SR__ s_40[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 59} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_41[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 60} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_42[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -18} }, 
};

SR__ s_43[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -23} }, 
};

SR__ s_44[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -19} }, 
};

SR__ s_45[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 61} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_46[] =
{
    { { REQ_DEF}, { 16} },                
    { {     291}, { 62} }, // expressions 
    { {     292}, {  3} }, // prog_decl   
    { {     293}, {  4} }, // data_decl   
    { {     294}, {  5} }, // exp         
    { {     261}, {  6} }, // PROGRAM     
    { {     262}, {  7} }, // DATA        
    { {     260}, {  8} }, // COMMENT     
    { {     266}, {  9} }, // OP_MOVE     
    { {     267}, { 10} }, // OP_READ     
    { {     269}, { 11} }, // OP_WRITE    
    { {     268}, { 12} }, // OP_ADD      
    { {     301}, { 13} }, // struct_while
    { {     302}, { 14} }, // struct_if   
    { {     274}, { 15} }, // STRUCT_WHILE
    { {     273}, { 16} }, // STRUCT_IF   
    { {       0}, { -2} },                
};

SR__ s_47[] =
{
    { { REQ_DEF}, { 16} },                
    { {     291}, { 63} }, // expressions 
    { {     292}, {  3} }, // prog_decl   
    { {     293}, {  4} }, // data_decl   
    { {     294}, {  5} }, // exp         
    { {     261}, {  6} }, // PROGRAM     
    { {     262}, {  7} }, // DATA        
    { {     260}, {  8} }, // COMMENT     
    { {     266}, {  9} }, // OP_MOVE     
    { {     267}, { 10} }, // OP_READ     
    { {     269}, { 11} }, // OP_WRITE    
    { {     268}, { 12} }, // OP_ADD      
    { {     301}, { 13} }, // struct_while
    { {     302}, { 14} }, // struct_if   
    { {     274}, { 15} }, // STRUCT_WHILE
    { {     273}, { 16} }, // STRUCT_IF   
    { {       0}, { -2} },                
};

SR__ s_48[] =
{
    { { REQ_TOKEN}, {  6} },               
    { {       303}, { 64} }, // logic_exp  
    { {       305}, { 30} }, // logic_un_op
    { {       288}, { 31} }, // VARIABLE   
    { {       289}, { 32} }, // NUMBER     
    { {       284}, { 33} }, // LOGIC_NOT  
    { {         0}, {  0} },               
};

SR__ s_49[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -31} }, 
};

SR__ s_50[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -32} }, 
};

SR__ s_51[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -33} }, 
};

SR__ s_52[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -34} }, 
};

SR__ s_53[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -35} }, 
};

SR__ s_54[] =
{
    { { REQ_DEF}, {   7} },                
    { {     304}, {  48} }, // logic_bin_op
    { {     282}, {  49} }, // LOGIC_AND   
    { {     283}, {  50} }, // LOGIC_OR    
    { {     279}, {  51} }, // COMP_LS     
    { {     280}, {  52} }, // COMP_GT     
    { {     281}, {  53} }, // COMP_EQ     
    { {       0}, { -27} },                
};

SR__ s_55[] =
{
    { { DEF_RED}, {  1} }, 
    { {       0}, { -8} }, 
};

SR__ s_56[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -11} }, 
};

SR__ s_57[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -12} }, 
};

SR__ s_58[] =
{
    { { REQ_TOKEN}, {  4} },                
    { {       299}, { 65} }, // types       
    { {       264}, { 66} }, // TYPE_INTEGER
    { {       265}, { 67} }, // TYPE_BOOLEAN
    { {         0}, {  0} },                
};

SR__ s_59[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -16} }, 
};

SR__ s_60[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -17} }, 
};

SR__ s_61[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -20} }, 
};

SR__ s_62[] =
{
    { { REQ_TOKEN}, {  2} },                   
    { {       278}, { 68} }, // STRUCT_ENDWHILE
    { {         0}, {  0} },                   
};

SR__ s_63[] =
{
    { { REQ_TOKEN}, {  2} },                
    { {       277}, { 69} }, // STRUCT_ENDIF
    { {         0}, {  0} },                
};

SR__ s_64[] =
{
    { { REQ_DEF}, {   7} },                
    { {     304}, {  48} }, // logic_bin_op
    { {     282}, {  49} }, // LOGIC_AND   
    { {     283}, {  50} }, // LOGIC_OR    
    { {     279}, {  51} }, // COMP_LS     
    { {     280}, {  52} }, // COMP_GT     
    { {     281}, {  53} }, // COMP_EQ     
    { {       0}, { -26} },                
};

SR__ s_65[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -10} }, 
};

SR__ s_66[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -13} }, 
};

SR__ s_67[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -14} }, 
};

SR__ s_68[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 70} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_69[] =
{
    { { REQ_TOKEN}, {  2} },            
    { {       257}, { 71} }, // STMT_DOT
    { {         0}, {  0} },            
};

SR__ s_70[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -24} }, 
};

SR__ s_71[] =
{
    { { DEF_RED}, {   1} }, 
    { {       0}, { -25} }, 
};


// State array:
SR__ *s_state[] =
{
  s_0,  s_1,  s_2,  s_3,  s_4,  s_5,  s_6,  s_7,  s_8,  s_9,
  s_10,  s_11,  s_12,  s_13,  s_14,  s_15,  s_16,  s_17,  s_18,  s_19,
  s_20,  s_21,  s_22,  s_23,  s_24,  s_25,  s_26,  s_27,  s_28,  s_29,
  s_30,  s_31,  s_32,  s_33,  s_34,  s_35,  s_36,  s_37,  s_38,  s_39,
  s_40,  s_41,  s_42,  s_43,  s_44,  s_45,  s_46,  s_47,  s_48,  s_49,
  s_50,  s_51,  s_52,  s_53,  s_54,  s_55,  s_56,  s_57,  s_58,  s_59,
  s_60,  s_61,  s_62,  s_63,  s_64,  s_65,  s_66,  s_67,  s_68,  s_69,
  s_70,  s_71,
};

} // anonymous namespace ends



// If the parsing function call uses arguments, then provide an overloaded
// function.  The code below doesn't rely on parameters, so no arguments are
// required.  Furthermore, parse uses a function try block to allow us to do
// ACCEPT and ABORT from anywhere, even from within members called by actions,
// simply throwing the appropriate exceptions.

ParserBase::ParserBase()
:
    d_stackIdx__(-1),
    // $insert debuginit
    d_debug__(false),
    d_nErrors__(0),
    // $insert requiredtokens
    d_requiredTokens__(0),
    d_acceptedTokens__(d_requiredTokens__),
    d_token__(_UNDETERMINED_),
    d_nextToken__(_UNDETERMINED_)
{}


void Parser::print__()
{
// $insert print
}

void ParserBase::clearin()
{
    d_token__ = d_nextToken__ = _UNDETERMINED_;
}

void ParserBase::push__(size_t state)
{
    if (static_cast<size_t>(d_stackIdx__ + 1) == d_stateStack__.size())
    {
        size_t newSize = d_stackIdx__ + STACK_EXPANSION;
        d_stateStack__.resize(newSize);
        d_valueStack__.resize(newSize);
        // $insert LTYPEresize
        d_locationStack__.resize(newSize);
    }
    ++d_stackIdx__;
    d_stateStack__[d_stackIdx__] = d_state__ = state;
    *(d_vsp__ = &d_valueStack__[d_stackIdx__]) = d_val__;
    // $insert LTYPEpush
    *(d_lsp__ = &d_locationStack__[d_stackIdx__]) = d_loc__;
}

void ParserBase::popToken__()
{
    d_token__ = d_nextToken__;

    d_val__ = d_nextVal__;
    d_nextVal__ = STYPE__();

    d_nextToken__ = _UNDETERMINED_;
}
     
void ParserBase::pushToken__(int token)
{
    d_nextToken__ = d_token__;
    d_nextVal__ = d_val__;
    d_token__ = token;
}
     
void ParserBase::pop__(size_t count)
{
    if (d_stackIdx__ < static_cast<int>(count))
    {
        ABORT();
    }

    d_stackIdx__ -= count;
    d_state__ = d_stateStack__[d_stackIdx__];
    d_vsp__ = &d_valueStack__[d_stackIdx__];
    // $insert LTYPEpop
    d_lsp__ = &d_locationStack__[d_stackIdx__];
}

inline size_t ParserBase::top__() const
{
    return d_stateStack__[d_stackIdx__];
}

void Parser::executeAction(int production)
try
{
    if (d_token__ != _UNDETERMINED_)
        pushToken__(d_token__);     // save an already available token

// $insert defaultactionreturn
                            // save default non-nested block $$
    if (int size = s_productionInfo[production].d_size)
        d_val__ = d_vsp__[1 - size];

    switch (production)
    {
        // $insert actioncases
        
        case 1:
#line 43 "abaps.y"
        {
         std::cout << "start -> expressions" << std::endl;
         }
        break;

        case 2:
#line 50 "abaps.y"
        {
         std::cout << "expressions -> null" << std::endl;
         }
        break;

        case 3:
#line 55 "abaps.y"
        {
         std::cout << "expressions -> prog_decl expressions" << std::endl;
         }
        break;

        case 4:
#line 60 "abaps.y"
        {
         std::cout << "expressions -> data_decl expressions" << std::endl;
         }
        break;

        case 5:
#line 65 "abaps.y"
        {
         std::cout << "expressions -> exp expressions" << std::endl;
         }
        break;

        case 6:
#line 72 "abaps.y"
        {
         std::cout << "prog_decl -> PROGRAM VARIABLE STMT_DOT" << std::endl;
         }
        break;

        case 7:
#line 79 "abaps.y"
        {
         std::cout << "data_decl -> DATA_STMT_OPN var_lines" << std::endl;
         }
        break;

        case 8:
#line 86 "abaps.y"
        {
         std::cout << "var_lines -> var_line var_lines" << std::endl;
         }
        break;

        case 9:
#line 91 "abaps.y"
        {
         std::cout << "var_line -> var_last_line" << std::endl;
         }
        break;

        case 10:
#line 98 "abaps.y"
        {
         std::cout << "var_line -> VARIABLE TYPE types" << std::endl;
         }
        break;

        case 11:
#line 105 "abaps.y"
        {
         std::cout << "var_line -> var_line_core STMT_COMMA" << std::endl;
         }
        break;

        case 12:
#line 112 "abaps.y"
        {
         std::cout << "var_last_line -> var_line_core STMT_DOT" << std::endl;
         }
        break;

        case 13:
#line 119 "abaps.y"
        {
         std::cout << "types -> TYPE_INTEGER" << std::endl;
         }
        break;

        case 14:
#line 124 "abaps.y"
        {
         std::cout << "types -> TYPE_BOOLEAN" << std::endl;
         }
        break;

        case 15:
#line 131 "abaps.y"
        {
         std::cout << "exp -> COMMENT" << std::endl;
         }
        break;

        case 16:
#line 136 "abaps.y"
        {
         std::cout << "exp -> OP_MOVE variable to_var STMT_DOT" << std::endl;
         }
        break;

        case 17:
#line 141 "abaps.y"
        {
         std::cout << "exp -> OP_MOVE NUMBER to_var STMT_DOT" << std::endl;
         }
        break;

        case 18:
#line 146 "abaps.y"
        {
         std::cout << "exp -> OP_READ to_var STMT_DOT" << std::endl;
         }
        break;

        case 19:
#line 151 "abaps.y"
        {
         std::cout << "exp -> OP_WRITE VARIABLE STMT_DOT" << std::endl;
         }
        break;

        case 20:
#line 156 "abaps.y"
        {
         std::cout << "exp -> OP_ADD VARIABLE to_var STMT_DOT" << std::endl;
         }
        break;

        case 21:
#line 161 "abaps.y"
        {
         std::cout << "exp -> struct_while" << std::endl;
         }
        break;

        case 22:
#line 166 "abaps.y"
        {
         std::cout << "exp -> struct_if" << std::endl;
         }
        break;

        case 23:
#line 173 "abaps.y"
        {
         std::cout << "to_var -> DIR_TO variable" << std::endl;
         }
        break;

        case 24:
#line 180 "abaps.y"
        {
         std::cout << "while -> STRUCT_WHILE exp STMT_DOT expressions STRUCT_ENDWHILE STMT_DOT" << std::endl;
         }
        break;

        case 25:
#line 187 "abaps.y"
        {
         std::cout << "struct_if -> STRUCT_IF logic_exp STMT_DOT expressions STRUCT_ENDIF STMT_DOT" << std::endl;
         }
        break;

        case 26:
#line 194 "abaps.y"
        {
         std::cout << "logic_exp -> logic_exp logic_bin_op logic_exp" << std::endl;
         }
        break;

        case 27:
#line 199 "abaps.y"
        {
         std::cout << "logic_exp -> logic_un_op logic_exp" << std::endl;
         }
        break;

        case 28:
#line 204 "abaps.y"
        {
         std::cout << "logic_exp -> VARIABLE" << std::endl;
         }
        break;

        case 29:
#line 209 "abaps.y"
        {
         std::cout << "logic_exp -> NUMBER" << std::endl;
         }
        break;

        case 30:
#line 217 "abaps.y"
        {
         std::cout << "logic_un_op -> LOGIC_NOT" << std::endl;
         }
        break;

        case 31:
#line 224 "abaps.y"
        {
         std::cout << "logic_bin_op -> LOGIC_AND" << std::endl;
         }
        break;

        case 32:
#line 229 "abaps.y"
        {
         std::cout << "logic_bin_op -> LOGIC_OR" << std::endl;
         }
        break;

        case 33:
#line 234 "abaps.y"
        {
         std::cout << "logic_bin_op -> COMP_LS" << std::endl;
         }
        break;

        case 34:
#line 239 "abaps.y"
        {
         std::cout << "logic_bin_op -> COMP_GT" << std::endl;
         }
        break;

        case 35:
#line 244 "abaps.y"
        {
         std::cout << "logic_bin_op -> COMP_EQ" << std::endl;
         }
        break;

    }
}
catch (std::exception const &exc)
{
    exceptionHandler__(exc);
}

inline void ParserBase::reduce__(PI__ const &pi)
{
    d_token__ = pi.d_nonTerm;
    pop__(pi.d_size);

}

// If d_token__ is _UNDETERMINED_ then if d_nextToken__ is _UNDETERMINED_ another
// token is obtained from lex(). Then d_nextToken__ is assigned to d_token__.
void Parser::nextToken()
{
    if (d_token__ != _UNDETERMINED_)        // no need for a token: got one
        return;                             // already

    if (d_nextToken__ != _UNDETERMINED_)
    {
        popToken__();                       // consume pending token
    }
    else
    {
        ++d_acceptedTokens__;               // accept another token (see
                                            // errorRecover())
        d_token__ = lex();
        if (d_token__ <= 0)
            d_token__ = _EOF_;
    }
    print();
}

// if the final transition is negative, then we should reduce by the rule
// given by its positive value. Note that the `recovery' parameter is only
// used with the --debug option
int Parser::lookup(bool recovery)
{
// $insert threading
    SR__ *sr = s_state[d_state__];          // get the appropriate state-table
    int lastIdx = sr->d_lastIdx;            // sentinel-index in the SR__ array
    
    SR__ *lastElementPtr = sr + lastIdx;
    lastElementPtr->d_token = d_token__;    // set search-token
    
    SR__ *elementPtr = sr + 1;              // start the search at s_xx[1]
    while (elementPtr->d_token != d_token__)
        ++elementPtr;
    

    if (elementPtr == lastElementPtr)   // reached the last element
    {
        if (elementPtr->d_action < 0)   // default reduction
        {
            return elementPtr->d_action;                
        }

        // No default reduction, so token not found, so error.
        throw UNEXPECTED_TOKEN__;
    }

    // not at the last element: inspect the nature of the action
    // (< 0: reduce, 0: ACCEPT, > 0: shift)

    int action = elementPtr->d_action;


    return action;
}

    // When an error has occurred, pop elements off the stack until the top
    // state has an error-item. If none is found, the default recovery
    // mode (which is to abort) is activated. 
    //
    // If EOF is encountered without being appropriate for the current state,
    // then the error recovery will fall back to the default recovery mode.
    // (i.e., parsing terminates)
void Parser::errorRecovery()
try
{
    if (d_acceptedTokens__ >= d_requiredTokens__)// only generate an error-
    {                                           // message if enough tokens 
        ++d_nErrors__;                          // were accepted. Otherwise
        error("Syntax error");                  // simply skip input

    }


    // get the error state
    while (not (s_state[top__()][0].d_type & ERR_ITEM))
    {
        pop__();
    }

    // In the error state, lookup a token allowing us to proceed.
    // Continuation may be possible following multiple reductions,
    // but eventuall a shift will be used, requiring the retrieval of
    // a terminal token. If a retrieved token doesn't match, the catch below 
    // will ensure the next token is requested in the while(true) block
    // implemented below:

    int lastToken = d_token__;                  // give the unexpected token a
                                                // chance to be processed
                                                // again.

    pushToken__(_error_);                       // specify _error_ as next token
    push__(lookup(true));                       // push the error state

    d_token__ = lastToken;                      // reactivate the unexpected
                                                // token (we're now in an
                                                // ERROR state).

    bool gotToken = true;                       // the next token is a terminal

    while (true)
    {
        try
        {
            if (s_state[d_state__]->d_type & REQ_TOKEN)
            {
                gotToken = d_token__ == _UNDETERMINED_;
                nextToken();                    // obtain next token
            }
            
            int action = lookup(true);

            if (action > 0)                 // push a new state
            {
                push__(action);
                popToken__();

                if (gotToken)
                {

                    d_acceptedTokens__ = 0;
                    return;
                }
            }
            else if (action < 0)
            {
                // no actions executed on recovery but save an already 
                // available token:
                if (d_token__ != _UNDETERMINED_)
                    pushToken__(d_token__);
 
                                            // next token is the rule's LHS
                reduce__(s_productionInfo[-action]); 
            }
            else
                ABORT();                    // abort when accepting during
                                            // error recovery
        }
        catch (...)
        {
            if (d_token__ == _EOF_)
                ABORT();                    // saw inappropriate _EOF_
                      
            popToken__();                   // failing token now skipped
        }
    }
}
catch (ErrorRecovery__)       // This is: DEFAULT_RECOVERY_MODE
{
    ABORT();
}

    // The parsing algorithm:
    // Initially, state 0 is pushed on the stack, and d_token__ as well as
    // d_nextToken__ are initialized to _UNDETERMINED_. 
    //
    // Then, in an eternal loop:
    //
    //  1. If a state does not have REQ_TOKEN no token is assigned to
    //     d_token__. If the state has REQ_TOKEN, nextToken() is called to
    //      determine d_nextToken__ and d_token__ is set to
    //     d_nextToken__. nextToken() will not call lex() unless d_nextToken__ is 
    //     _UNDETERMINED_. 
    //
    //  2. lookup() is called: 
    //     d_token__ is stored in the final element's d_token field of the
    //     state's SR_ array. 
    //
    //  3. The current token is looked up in the state's SR_ array
    //
    //  4. Depending on the result of the lookup() function the next state is
    //     shifted on the parser's stack, a reduction by some rule is applied,
    //     or the parsing function returns ACCEPT(). When a reduction is
    //     called for, any action that may have been defined for that
    //     reduction is executed.
    //
    //  5. An error occurs if d_token__ is not found, and the state has no
    //     default reduction. Error handling was described at the top of this
    //     file.

int Parser::parse()
try 
{
    push__(0);                              // initial state
    clearin();                              // clear the tokens.

    while (true)
    {
        try
        {
            if (s_state[d_state__]->d_type & REQ_TOKEN)
                nextToken();                // obtain next token


            int action = lookup(false);     // lookup d_token__ in d_state__

            if (action > 0)                 // SHIFT: push a new state
            {
                push__(action);
                popToken__();               // token processed
            }
            else if (action < 0)            // REDUCE: execute and pop.
            {
                executeAction(-action);
                                            // next token is the rule's LHS
                reduce__(s_productionInfo[-action]); 
            }
            else 
                ACCEPT();
        }
        catch (ErrorRecovery__)
        {
            errorRecovery();
        }
    }
}
catch (Return__ retValue)
{
    return retValue;
}



