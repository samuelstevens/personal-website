---
title: Type Checking Matrix Dimensions
author:
    - Sam Stevens
keywords: [programming, abstractions, types, matrices, matrix, static type checking, dimensions]
abstract: Can we use static type checking to make sure matrix multiplication works?
---

# Type Checking Matrix Multiplication

I have historically struggled with NumPy matrices being the right size while working on ML-oriented code. After reading some of [Learn You a Haskell](http://learnyouahaskell.com/) and working on a couple Elm projects ((1)[https://github.com/samuelstevens/elm-slow-youtube], (2)[https://github.com/samuelstevens/elm-csv]), I felt like it was a problem I could solve.

The basic idea is a wrapper class for NumPy matrices that overloads `*`, `+` and whatever else you want to type check the matrix dimensions using `mypy` before running the code. This only seemed possible because most of the matrices in a my typical ML problems are fixed sizes, and not changing at runtime.

The end result is:

```python
a = Matrix[_100, _500](np.zeros((100, 500)))
b = Matrix[_100, _500](np.zeros((100, 500)))
c = Matrix[_500, _600](np.zeros((500, 600)))
a + b
a * b # throws a mypy error
a * c
a + c # throws a mypy error
a.matrix # access the underlying numpy ndarray
```

I'm going to spend the rest of this explaining how it works.

## Literal Types in MyPy

Literal types in mypy let you define a literal as its own type. This is  useful for overloaded functions that return a different type based on a flag value. For example, in a made up function that returns a float or an int based on a flag:

```python
def parse_float_or_int(s: str, is_float: bool) -> Union[float, int]:
	...
```

You'd have to check if the return value was a float or an int every time you wanted to use the value later on. But if we know that the return type depends on the `is_float` flag, we can better model this function with literal types.

```python
from typing import overload, Literal

@overload  
def parse_float_or_int(s: str, is_float: Literal[True]) -> float:
	...

@overload
def parse_float_or_int(s: str, is_float: Literal[False]) -> int:
	...
```

> This is basically ripped straight from the [mypy docs on literal types](https://mypy.readthedocs.io/en/stable/literal_types.html#literal-types)

Now if we call `parse_float_or_int` with a literal `True` or `False`, mypy will know the return type. Note that if we pass a variable that is not of type `Literal` then mypy will need you to narrow the type down from a `Union[float, int]`.

Can we use literals as the dimensions of our matrix to type check matrix multiplication? Ideally we could use `Matrix[100, 200]` or some variant as our type annotation, knowing that it will only work for matrices where we know the dimensions at "compile"-time.

To the best of my knowledge, we can't define a generic `Matrix` class that will take integer literals to create concrete types for the dimensions that can be used later on. The `Literal` type isn't a free type if you don't give it a value. Here's what I mean:

```python
from typing import TypeVar, Literal, Generic

A = TypeVar("A")

class GenericOverTypeVar(Generic[A]):
	stuff: A # has type of A, whatever it is


# code below causes errors
class GenericOverLiteral(Generic[Literal[A]]):
	stuff: Literal[A] # value is just A
```

Ideally, I would be able to use `GenericOverLiteral` with any literal value and then get type checking, like this:

```python
a = GenericOverLiteral[100]
a.stuff # always 100 later on in my code
b = GenericOverLiteral["stay"]
b.stuff # "stay"
```

I couldn't bend mypy into this shape. If you know how, I'd love to hear. To get around this, we can define our `TypeVar` to be bound by `int`, like so:

```python
# Represent the different dimensions in our matrices
A = TypeVar("A", bound=int)
B = TypeVar("B", bound=int)
C = TypeVar("C", bound=int)
```

Now `A`, `B` and `C` always have to be `int`-like. Then, we can use these bounded type variables in a Matrix class:

```python
class Matrix(Generic[A, B]):
    rows: A
    cols: B

    def __init__(self) -> None: ...
```

Now `Matrix` is generic over two types, each of which have to be integer-like. The `rows` and `cols` will have those two types. But this alone doesn't do anything useful. Basically, all we've said is that `Matrix` has two attributes, `rows` and `cols`, that are both integers. The real fun comes when we overload `*`:

```python
def __mul__(self, other: Matrix[B, C]) -> Matrix[A, C]: ...
```

Now we see that we take another `Matrix` that has the same type of rows as we have columns. Not the same *number*, but the same *type*. How do we define these types?

Using `Literal`:

```python
_100 = Literal[100]
_200 = Literal[200]
_300 = Literal[300]
```

Now we have three types, all of which are integer like, with values known at "compile"-time. We can use it like this:

```python
a = Matrix[_100, _200]()
b = Matrix[_100, _200]()
c = Matrix[_200, _300]()
a * b # throws a mypy error
a * c # safe
```

Because `__mul__` requires that the generic types for the columns and rows for the first and second matrices, respectively, `a * b` throws a error in mypy: `Unsupported operand types for * ("Matrix[Literal[100], Literal[200]]" and "Matrix[Literal[100], Literal[200]]")`. Not the best error in the world, but clear enough and it happens before running.

The rest of it is just implementation details:
* Since we use `Matrix` in the function signature of `__mul__`, we have to quote it to solve forward reference issues. 
* We need an actual `.matrix` member in `Matrix` to store the numpy matrix.
* We need a bunch of types for common matrix dimensions: maybe 100 through 1000 and then some powers of 2.

Obviously, the downside of this is having to define types for all the dimensions. If there was a way to do this with just integer literals, that would be a massive improvement. I'd also like someway to verify that the shape of the matrix matches the literals, but it would have to be at runtime anyways.

Please [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further.