intrinsic MDGL2FromAssoc(A::Assoc) -> GrpMat
{Construct a GL2 matrix group from an an LMFDB entry A.}
    return GL2FromGenerators(
        A["level"],
        A["index"],
        [[gi : gi in g] : g in A["generators"]]
    );
end intrinsic;


intrinsic MDGL2FromLMFDBLabel(label::MonStgElt) -> GrpMat
{Construct a GL2 matrix group an lmfdb label.}
    A := MDLMFDBLookup("gps_gl2zhat_fine",label);
    return MDGL2FromAssoc(A);
end intrinsic;


intrinsic MDGL2LMFDBLookup(G::GrpMat) -> Assoc
{Lookup the GL2 object G in the LMFDB database and return all stored data as an associative array.}

    // technically genus and index are not needed, but they make the search faster
    search_params := [*
        <"level", GL2Level(G)>,
        <"genus", GL2Genus(G)>,
        <"index", GL2Index(G)>,
        <"canonical_generators", GL2CanonicalGenerators(G)>
    *];
    result := MDLMFDBSearch("gps_gl2zhat_fine", search_params);

    assert #result eq 1;
    return result[1];
end intrinsic;

intrinsic MDGL2LMFDBLabel(G::GrpMat) -> MonStgElt
{The LMFDB label of the GL2 matrix group G.}
    return MDGL2LMFDBLookup(G)["label"];
end intrinsic;