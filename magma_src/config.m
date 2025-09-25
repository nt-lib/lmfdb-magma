// A global variable to store all the data in
config := NewStore();
StoreSet(config, "python_interpreter_path", "python3");


intrinsic MDGetConfig() -> Rec
{A record containing all configuration variables}
    return config;
end intrinsic;

intrinsic MDSetPythonInterpreter(path::MonStgElt)
{Set the path to the python interpreter for use by LMFDB-magma}
    StoreSet(config, "python_interpreter_path", path);
end intrinsic;


intrinsic MDGetPythonInterpreter() -> MonStgElt
{Get the path to the python interpreter used by LMFDB-magma}
    return StoreGet(config, "python_interpreter_path");
end intrinsic;