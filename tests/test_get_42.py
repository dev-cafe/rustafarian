# -*- coding: utf-8 -*-

import pytest

from rustafarian import get_42

def test_get_42():
    assert get_42() == 42
