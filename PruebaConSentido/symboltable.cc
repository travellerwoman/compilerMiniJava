#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include "Node.h"

class Record{
  string id;
  string type;
  //getters and setters
  
  printRecord();
}

class Class: Record{
  map <string, Variable> variables;
  map <string, Method> methods;

  addVariable(){}
  addMethod(){}
  lookUpVariable(){}
  lookUpMethod(){}
  // TODO: ...
}

class Method: Record{
  map <string, Variable> parameters;
  map <string, Variable> variables;

  addVariable(){}
  addParameter(){}
  // TODO: ...
}

class Variable: Record{
  // TODO: ...
}

class SymbolTable{
  Scope root;
  Scope current;

  SymbolTable(){
    root = new Scope(null); current = root;
  }
  enterScope(){
      current = current.nextChild(); //create new scope if needed
    }
  exitScope(){
      current = current.Parent();
    }

  put(String Key,Record item){
      current.put(Key,item);
  }
  Record lookUp(String key){
      return curent.lookUp(key);
  }

  printTable(){
      root.printScope();
  }
  resetTable(){
      root.resetScope();//preparation for the new traversal
  }
}

class Scope{
    int next = 0; // next child to visit
    Scope parentScope; // parent scope
    list childrenScopes; // children scopes
    map records; // symbol to record map

    // TODO: ...

    Scope nextChild{
        Scope nextChild;
        if(next == childrenScopes.size()){ //create new child scope
            nextChild = new Scope(this);
            childrenScopes.add(nextChild);
        }else{
            nextChild = childrenScopes.get(next); //visit scope
        }
        next++;
        return nextChild;
    }

    //TODO: ...

    Record lookup (string key){
        if ( records.containsKey ()) // check if it exist in the current scope
            return record.get(key); 
        else{
            if (parent == null)
            {
                return null; // identifier not in the symbol table
            }
            else
                return parent.lookup(key); // delegate the request to parent scope
        }
    }

    resetScope(){
        next = 0;
        for (int i = 0; i < children.size(); i++) 
            children.get(i).resetScope();
    }
}