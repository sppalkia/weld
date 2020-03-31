"""
Index used for access columns in Grizzly.

"""

from weld.grizzly.core.indexes.base import Index

class ColumnIndex(Index):
    """
    An index used for columns in a Grizzly DataFrame.

    Each index value is a Python object. For operations between two DataFrames
    with the same ColumnIndex, the result will also have the same index. For
    operations between two DataFrames with different ColumnIndex, the output
    will have a join of the two ColumnIndex, sorted by the index values.

    Two ColumnIndex are equal if their index names are equal and have the same
    order.

    Parameters
    ----------
    columns : iterable
        column names.
    slots : iterable of int or None
        slots associated with each column. If provided, the length must be
        len(columns). This is used for underlying data access only; index
        equality depends only on the column names and ordering.


    Examples
    --------
    >>> index = ColumnIndex(["name", "age"])
    >>> index
    ColumnIndex(['name', 'age'])

    """

    def __init__(self, columns, slots=None):
        if not isinstance(columns, list):
            columns = list(columns)
        if slots is not None:
            assert len(columns) == len(slots)
        else:
            slots = range(len(columns))

        # The original column order.
        self.columns = columns
        # The mapping from columns to slots.
        self.index = dict(zip(columns, slots))

    def zip(self, other):
        """
        Zips this index with 'other', returning an iterator of `(name,
        slot_in_self, slot_in_other)`. The slot may be `None` if the name does
        not appear in either column.

        The result columns are ordered in a way consistent with how DataFrame
        columns should be be ordered (i.e., same order `self` if `self ==
        other`, and sorted by the union of columns from `self` and `other`
        otherwise).

        Examples
        --------
        >>> a = ColumnIndex(["name", "age"])
        >>> b = ColumnIndex(["name", "age"])
        >>> list(a.zip(b))
        [('name', 0, 0), ('age', 1, 1)]
        >>> b = ColumnIndex(["age", "income", "name"])
        >>> list(a.zip(b))
        [('age', 1, 0), ('income', None, 1), ('name', 0, 2)]

        """
        if self == other:
            for name in self.columns:
                yield (name, self.index[name], other.index[name])
        else:
            columns = sorted(list(set(self.columns).union(other.columns)))
            for name in columns:
                yield (name, self.index.get(name), other.index.get(name))

    def __eq__(self, other):
        """
        Compare equality depending on column names.

        Examples
        --------
        >>> a = ColumnIndex(["name", "age"])
        >>> a == ColumnIndex(["name", "age"])
        True
        >>> a == ColumnIndex(["age", "name"])
        False
        >>> a == ColumnIndex(["name", "age", "income"])
        False

        """
        return isinstance(other, ColumnIndex) and self.columns == other.columns

    def __str__(self):
        return "ColumnIndex({})".format(self.index)

    def __repr__(self):
        return "ColumnIndex({})".format(self.columns)
