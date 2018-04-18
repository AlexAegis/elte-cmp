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

static const char* typeNames[] = { "Integer", "Boolean" };

struct VarData {
	int row;
	Type type;
	
	VarData(int _row, Type _type) : row(_row), type(_type) {}
	
	VarData(){}

	friend std::ostream & operator<<(std::ostream & _stream, VarData const & mc) {
        _stream << "row: " << mc.row << " type: " << typeNames[mc.type];
    }
};



#endif //SEMANTICS_H