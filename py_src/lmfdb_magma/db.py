from .conversion import py_to_magma

def lmfdb_lookup(table_name, label):
    from lmf import db
    result = db[table_name].lookup(label)
    return py_to_magma(result)
    
def lmfdb_search(table_name, *arg, **kwargs):
    from lmf import db
    result = db[table_name].search(*arg, **kwargs)
    return py_to_magma(list(result))
