def hello():
    """
    >>> hello()
    'world'
    """
    return "world"


if __name__ == "__main__":
    import doctest

    doctest.testmod()
