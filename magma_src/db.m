intrinsic MDLMFDBLookupStr(table::MonStgElt, label::MonStgElt) -> MonStgElt
{Runs Python lmfdb_magma.db.lmfdb_lookup on the given collection and label. Returns the result as a string.}
    
    python := MDGetPythonInterpreter();
    py_src_dir := Sprintf("%o/py_src", MDLMFDBMagmaSourceDir());

    // Construct the Python command
    python_cmd := Sprintf(
        "%o -c 'from lmfdb_magma import db; print(db.lmfdb_lookup(\"%o\",\"%o\"))'",
        python, table, label
    );
    full_cmd := Sprintf("cd %o && %o", py_src_dir, python_cmd);

    entry := Pipe(full_cmd, "");


    return entry;
end intrinsic;

intrinsic MDLMFDBLookup(table::MonStgElt, label::MonStgElt) -> .
{Looks up the given collection and label using MDLMFDBLookupStr, raises an error if nothing is found, otherwise evaluates the returned string.}

    entry := MDLMFDBLookupStr(table, label);

    // I don't know how to strip whitespace in Magma so just check the first 4 characters and ignore trailing whitespace
    if entry[1..4] eq "None" then
        error label cat " not found in table " cat table;
    end if;

    return eval entry;
end intrinsic;

intrinsic MDLMFDBSearchStr(table::MonStgElt, query::List : limit := "None") -> MonStgElt
{Runs Python lmfdb_magma.db.lmfdb_search with the give query. Returns the result as a string.}
    
    python := MDGetPythonInterpreter();
    py_src_dir := Sprintf("%o/py_src", MDLMFDBMagmaSourceDir());
    query_json := MDQueryToJSON(query);

    // Construct the Python command
    python_cmd := Sprintf(
        "%o -c 'from lmfdb_magma import db; print(db.lmfdb_search(\"%o\",%o,limit=%o))'",
        python, table, query_json, limit
    );
    full_cmd := Sprintf("cd %o && %o", py_src_dir, python_cmd);
    //print full_cmd;

    entry := Pipe(full_cmd, "");


    return entry;
end intrinsic;

intrinsic MDLMFDBSearch(table::MonStgElt, query::List : limit := "None") -> .
{Runs Python lmfdb_magma.db.lmfdb_search with the give query. }

    entry := MDLMFDBSearchStr(table, query : limit := limit);


    return eval entry;
end intrinsic;
