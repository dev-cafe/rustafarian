# -*- coding: utf-8 -*-

"""Console script for rustafarian."""

from typing import Union

import click

from .module.double import double
from . import __version__

@click.group()
@click.version_option(prog_name="rustafarian", version=__version__)
def cli(args=None):
    """Console script for rustafarian."""
    return 0


@click.command()
@click.argument(
    "number",
    type=int,
    metavar="<number>",
)
def doubler(number: Union[int, float]):
    """Run rustafarian to double a number.

    \b
    Parameters
    ----------
    number : int or float
        A number to double
    """

    def fn():
        return number

    print(double(fn))

cli.add_command(doubler)
