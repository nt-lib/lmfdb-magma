intrinsic MDLisToAssoc(pairs::List) -> Assoc
{Constructs an associative array from a sequence of <key, value> pairs.}
    A := AssociativeArray();
    for pair in pairs do
        A[pair[1]] := pair[2];
    end for;
    return A;
end intrinsic;


intrinsic MDLMFDBMagmaSourceDir() -> MonStgElt
{ Returns the source directory where lmfdb-magma is installed }
  filenames := GetFilenames(MDLisToAssoc);
  assert #filenames eq 1;
  source_dir := "/" cat Join(s[1..(#s - 2)], "/") where s := Split(filenames[1,1],"/");
  return source_dir;
end intrinsic;