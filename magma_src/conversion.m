intrinsic MDQueryToJSON(pairs::List) -> MonStgElt
{Convert a list of <key,value> pairs into a JSON string.}
    entries := [];
    for p in pairs do
        if Type(p[2]) eq MonStgElt then
            val := Sprintf("\"%o\"", p[2]) ;
        elif Type(p[2]) eq BoolElt then
            val := p[2] select "True" else "False"; 
        else 
            val := Sprintf("%o", p[2]);
        end if;
        Append(~entries, Sprintf("\"%o\":%o", p[1], val));
    end for;
    return Sprintf("{%o}", Join(entries, ", "));
end intrinsic;


intrinsic MDQueryToJSON(queries::SeqEnum) -> MonStgElt
{Convert a list of lists of <key,value> pairs into a JSON string.}
    json_queries := [MDQueryToJSON(q) : q in queries];
    return Sprintf("[%o]", Join(json_queries, ", "));
end intrinsic;