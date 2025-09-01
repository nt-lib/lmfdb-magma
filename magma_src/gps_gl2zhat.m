intrinsic MDGL2FromAssoc(A::Assoc) -> GrpMat
{Construct a GL2 matrix group from an an LMFDB entry A.}
    return GL2FromGenerators(
        A["level"],
        A["index"],
        A["generators"]
    );
end intrinsic;


intrinsic MDGL2FromLabel(label::MonStgElt) -> GrpMat
{Construct a GL2 matrix group an lmfdb label.}
    A := MDLMFDBLookup("gps_gl2zhat_fine",label);
    return MDGL2FromAssoc(A);
end intrinsic;