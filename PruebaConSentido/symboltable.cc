class Scope{

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