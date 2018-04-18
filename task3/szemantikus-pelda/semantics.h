#ifndef SEMANTICS_H
#define SEMANTICS_H

#include <string>
#include <iostream>
#include <cstdlib>

enum tipus { Egesz, Logikai };

struct kifejezes_leiro
{
    int sor;
    tipus ktip;
    kifejezes_leiro( int s, tipus t )
        : sor(s), ktip(t) {}
};

#endif //SEMANTICS_H

