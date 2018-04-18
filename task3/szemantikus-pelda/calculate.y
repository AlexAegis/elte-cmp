%baseclass-preinclude "semantics.h"
%lsp-needed

%union
{
    std::string *szoveg;
    kifejezes_leiro *kif;
}

%token <szoveg> NUMBER
%token OPEN
%token CLOSE

%left EQUAL
%left PLUS MINUS

%type<kif> exp

%%

start:
    expressions
;

expressions:
    // ures
|
    exp expressions
;

exp:
    NUMBER
    {
        $$ = new kifejezes_leiro( d_loc__.first_line, Egesz );
        delete $1;
    }
|
    exp PLUS exp
    {
        const std::string hibauzenet = ": Az osszeadas argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Egesz );
        delete $1;
        delete $3;
    }
|
    exp MINUS exp
    {
        const std::string hibauzenet = ": A kivonas argumentuma csak egesz tipusu kifejezes lehet.\n";
        if( $1->ktip != Egesz )
        {
            std::cerr << $1->sor << hibauzenet;
            exit(1);
        }
        if( $3->ktip != Egesz )
        {
            std::cerr << $3->sor << hibauzenet;
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Egesz );
        delete $1;
        delete $3;
    }
|
    exp EQUAL exp
    {
        if( $1->ktip != $3->ktip )
        {
            std::cerr << $1->sor << ": Az egyenloseg operatorral csak azonos tipusu kifejezeseket lehet osszehasonlitani.\n";
            exit(1);
        }
        $$ = new kifejezes_leiro( $1->sor, Logikai );
        delete $1;
        delete $3;
    }
|
    OPEN exp CLOSE
    {
        $$ = $2;
    }
;
