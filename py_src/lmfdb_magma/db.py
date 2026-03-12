from .conversion import py_to_magma


def lmfdb_lookup(table_name, label):
    from lmf import db
    result = db[table_name].lookup(label)
    return py_to_magma(result)
    
def _lmfdb_search(table_name, *arg, **kwargs):
    import time
    start = time.perf_counter()
    from lmf import db
    result = list(db[table_name].search(*arg, **kwargs))
    end = time.perf_counter()
    for r in result:
        r["lmfdb_query_time"] = end - start
    return result

def lmfdb_search(table_name, *arg, **kwargs):
    return py_to_magma(_lmfdb_search(table_name, *arg, **kwargs))
    
def lmfdb_search_batch(table_name, arg_list, **kwargs):
    result = []
    for arg in arg_list:
        if isinstance(arg, list):
            result.append(_lmfdb_search(table_name, *arg, **kwargs))
        else:
            result.append(_lmfdb_search(table_name, arg, **kwargs))
    return py_to_magma(result)
