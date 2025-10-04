# LMFDB-magma

A magma interfact to the LMFDB.

# Requirements

This requires python 3.10 or later and lmfdb-lite. lmfdb-lite is installed as follows:

```bash
pip3 install -U "lmfdb-lite[pgbinary] @ git+https://github.com/roed314/lmfdb-lite.git"
```

# Installation

The recommended way of installation at the moment is git using the command:

```
git clone --recurse-submodules https://github.com/nt-lib/lmfdb-magma.git
```

Note that this will also download Andrew V. Sutherland's 
[Magma](https://github.com/AndrewVSutherland/Magma) for more congruence subgroup related functionality.

# Example usage:

All functions in this package are prefixed with `MD` in order to avoid namespace collisions with other packages.

At the moment there is only a high level implementation for creating subgroups
in GL_2(Zhat). This is done as below

```magma
> AttachSpec("lmfdb-magma/lmfdb.spec");
> G := MDGL2FromLMFDBLabel("11.12.1.a.1"); G;
MatrixGroup(2, IntegerRing(11)) of order 2^2 * 5^2 * 11
Generators:
    [5 2]
    [0 2]

    [6 3]
    [0 3]
> // We can also lookup the label given the group
> MDGL2LMFDBLabel(G);
11.12.1.a.1
```

## Lookup by label

There is also lower level functionality to obtain any lmfdb object from any table listed on https://www.lmfdb.org/api/ using the label:

```magma
> AttachSpec("lmfdb-magma/lmfdb.spec");
> MDLMFDBLookup("gps_gl2zhat_fine", "11.12.1.a.1");
Associative Array with index universe String structure
> G := MDLMFDBLookup("gps_gl2zhat_fine", "11.12.1.a.1");
> G;
Associative Array with index universe String structure
> G["generators"];
[
    [ 5, 2, 0, 2 ],
    [ 6, 3, 0, 3 ]
]
```

## Searching

There is also limited search functionality similar to that of https://github.com/roed314/psycodict/blob/ab514e1a87ec73a2f27f59ef6c3ec927954a6623/psycodict/searchtable.py#L712 . Currently only the query and the limit arguments are supported. The result is a list of associative arrays, where each associative array contains the information of one lmfdb entry. 

The below shows there is only one modular curve containing -1 in the LMFDB whose CPlabel is 9A1.

```magma
> lmfdb_data := MDLMFDBSearch("gps_gl2zhat_fine",[*<"CPlabel","9A1">,<"contains_negative_one","true">*]);
> print #lmfdb_data;
1
> // manually turn the lmfdb result into a subgroup of GL2
> G := MDGL2FromAssoc(lmfdb_data[1]);
> print G;
MatrixGroup(2, IntegerRing(9)) of order 2^2 * 3^4
Generators:
    [2 1]
    [3 8]

    [5 7]
    [6 7]
> // the below shows which data is available for this modular curve
> print Keys(lmfdb_data[1]);
{ q_gonality, rank, coarse_class_num, num_known_degree1_noncusp_points, 
coarse_index, bad_primes, qbar_gonality, num_known_degree1_noncm_points, 
determinant_label, kummer_orbits, has_obstruction, level_is_squarefree, Glabel, 
CPlabel, RZBlabel, coarse_level, lattice_labels, pointless, psl2level, 
psl2index, traces, RSZBlabel, Slabel, trace_hash, q_gonality_bounds, power, 
models, genus, coarse_class, level, parents_conj, sl2level, index, nu2, 
rational_cusps, coarse_label, psl2label, nu3, squarefree, canonical_generators, 
fine_num, cusp_widths, coarse_num, conductor, reductions, scalar_label, parents,
label, sl2label, contains_negative_one, curve_label, lattice_x, newforms, 
cm_discriminants, cusp_orbits, generators, SZlabel, mults, name, factorization, 
obstructions, simple, all_degree1_points_known, cusps, num_known_degree1_points,
isogeny_orbits, canonical_conjugator, num_bad_primes, level_radical, 
genus_minus_rank, orbits, qbar_gonality_bounds, log_conductor, dims }
> // We look up the Q-gonality of this curve
> lmfdb_data[1]["q_gonality"];
2

```

# Troubleshooting

An error as below means that lmfdb-lite is not installed in the python
environment that is used. 

```magma
> AttachSpec("lmfdb-magma/lmfdb.spec");
> MDGL2FromLabel("11.12.1.a.1");
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "~/lmfdb-magma/py_src/lmfdb_magma/db.py", line 4, in lmfdb_lookup
    from lmf import db
ModuleNotFoundError: No module named 'lmf'

MDGL2FromLabel(
    label: 11.12.1.a.1
)
MDLMFDBLookup(
    table: gps_gl2zhat_fine,
    label: 11.12.1.a.1
)
MDLMFDBLookupStr(
    table: gps_gl2zhat_fine,
    label: 11.12.1.a.1
)
In file "~/lmfdb-magma/magma_src/d\
b.m", line 14, column 18:
>>     entry := Pipe(full_cmd, "");
                    ^
Runtime error in 'Pipe': Subprocess failed with exit status 1
```

The important line that indicates this is what is going wrong is the line

```
ModuleNotFoundError: No module named 'lmf'
```

To solve this make sure that lmfdb-lite is installed as mentioned above. If you are sure lmfdb-lite is installed then it is because lmfdb-magma is picking up the wrong python environment. You can configure which python installation to use as follows:

```magma
> python_path := "~/python_env/bin/python";
> MDSetPythonInterpreter(python_path);
> MDGL2FromLabel("11.12.1.a.1");                                               
MatrixGroup(2, IntegerRing(11)) of order 2^2 * 5^2 * 11
Generators:
    [5 2]
    [0 2]

    [6 3]
    [0 3]
```

