intrinsic MDQueryToJSON(pairs::List) -> MonStgElt
{Convert a list of <key,value> pairs into a JSON string.}
    entries := [];
    for p in pairs do
        val := (Type(p[2]) eq MonStgElt) 
                  select Sprintf("\"%o\"", p[2]) 
                  else Sprintf("%o", p[2]);
        Append(~entries, Sprintf("\"%o\":%o", p[1], val));
    end for;
    return Sprintf("{%o}", Join(entries, ", "));
end intrinsic;