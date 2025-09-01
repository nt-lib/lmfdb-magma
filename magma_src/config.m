/* the below doesn't work I guess magma copies on return or something
// Global variable to store the settings in
config := AssociativeArray(); 
config["python_interpreter_path"] := "python";

intrinsic MDGetConfig() -> Assoc
{Set the python path to the python interpreter for use by LMFDB-magma}
    return config;
end intrinsic;

intrinsic MDSetPythonInterpreter(path::MonStgElt)
{Set the python path to the python interpreter for use by LMFDB-magma}
    config := MDGetConfig();
    config["python_interpreter_path"] := path;
end intrinsic;


intrinsic MDGetPythonInterpreter() -> MonStgElt
{Set the python path to the python interpreter for use by LMFDB-magma}
    return config["python_interpreter_path"];
end intrinsic;
*/

/* this doesn't work either for the same reason
config := ["python"];

intrinsic MDGetConfig() -> SeqEnum
{Set the python path to the python interpreter for use by LMFDB-magma}
    return config;
end intrinsic;

intrinsic MDSetPythonInterpreter(path::MonStgElt)
{Set the python path to the python interpreter for use by LMFDB-magma}
    config := MDGetConfig();
    config[1] := path;
end intrinsic;


intrinsic MDGetPythonInterpreter() -> MonStgElt
{Set the python path to the python interpreter for use by LMFDB-magma}
    return config[1];
end intrinsic;
*/

// So we go with a super hacky solution and use magmas AssignNames
// functionality to store strigns globally.
config := FreeGroup(1); 
AssignNames(~config, ["python"]);


intrinsic MDGetConfig() -> GrpFP
{A free group whose variable names store the configuration variables}
    return config;
end intrinsic;

intrinsic MDSetPythonInterpreter(path::MonStgElt)
{Set the path to the python interpreter for use by LMFDB-magma}
    config := MDGetConfig();
    AssignNames(~config, [path]);
end intrinsic;


intrinsic MDGetPythonInterpreter() -> MonStgElt
{Get the path to the python interpreter used by LMFDB-magma}
    return Sprint(Name(config,1));
end intrinsic;