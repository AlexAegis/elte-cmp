#include<iostream>
#include<string>
#include<map>

enum type {natural, boolean};

struct var_data {
    var_data(int _decl_row, type _var_type) : decl_row(_decl_row), var_type(_var_type){}
    var_data(){}

    int decl_row;
    type var_type;
};


