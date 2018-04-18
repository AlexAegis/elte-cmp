#ifndef SEMANTICS_H
#define SEMANTICS_H

#include <iostream>
#include <sstream>
#include <string> 
#include <map>

enum Type {
	Integer,
	Boolean
};

struct VarData {
	int row;
	Type type;
	
	VarData(int _row, Type _type) : row(_row), type(_type) {}
	
	VarData(){}
};

#endif //SEMANTICS_H