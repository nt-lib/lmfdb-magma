# LMFDB-magma
A magma interfact to the LMFDB.

# Requirements

This requires python and lmfdb-lite. lmfdb-lite is installed as follows:
```bash
pip3 install -U "lmfdb-lite[pgbinary] @ git+https://github.com/roed314/lmfdb-lite.git"
```

# Example usage:

All functions in this package are prefixed with `MD` in order to avoid namespace collisions with other packages.

At the moment there is only a high level implementation for creating subgroups
in GL_2(Zhat). This is done as below

```magma
> AttachSpec("lmfdb-magma/lmfdb.spec");
> MDGL2FromLabel("11.12.1.a.1");
MatrixGroup(2, IntegerRing(11)) of order 2^2 * 5^2 * 11
Generators:
    [5 2]
    [0 2]

    [6 3]
    [0 3]
```

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
