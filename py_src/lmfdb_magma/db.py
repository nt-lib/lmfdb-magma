from .conversion import py_to_magma

def lmfdb_lookup(table_name, label):
    from lmf import db
    result = db[table_name].lookup(label)
    return py_to_magma(result)
