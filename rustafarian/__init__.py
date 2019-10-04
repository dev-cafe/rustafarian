from .module.double import double
from .rustafarian import get_21, __version__, __sha__, sum_as_string

def get_42() -> int:
    return double(get_21)
