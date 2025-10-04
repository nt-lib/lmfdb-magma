try:
    from sage.rings.real_mpfr import RealLiteral
except ImportError:
    # Sage not installed
    SAGE_MODE = False
    RealLiteral = float
else:
    SAGE_MODE = True
 
def py_to_magma(value):
    """Convert Python value to Magma."""
    match value:
        case None:
            # todo implement none type in magma
            return '"None"'
        case bool():
            return "true" if value else "false"
        case int() | float() | RealLiteral():
            return str(value)
        case str():
            return f'"{value}"'
        case list():
            return "[*" + ",".join(py_to_magma(v) for v in value) + "*]"
        case dict():
            return "MDLisToAssoc([*" + ",".join(f"<{py_to_magma(k)},{py_to_magma(v)}>" for k,v in value.items()) + "*])"
        case _:
            raise ValueError(f"Unsupported type: {type(value)}")

# Generate Magma code
def py_dict_to_magma_record(record_name, data):
    header = f"rec< {record_name} |\n";
    footer = "\n>;"
    lines = []
    for key, val in data.items():
        if val is None:
            continue
        magma_val = to_magma(val)
        lines.append(f"    {key} := {magma_val}")
    return header + ",\n".join(lines) + footer
