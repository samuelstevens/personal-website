---
title: I Suck at Naming Python Modules.
author:
  - Sam Stevens
keywords:
  [
    programming,
    python,
    naming,
    conflict,
    name conflict,
    module,
    modules,
    package,
    packages,
    import,
    imports
  ]
abstract: I always end up with awkward Python module names. If you don't, you should too.
---

# I Suck at Naming Python Modules

I often end up with name conflicts in Python, where a variable and a module have the same name within a function. I'll explain how it happens naturally, then the various solutions and their pros and cons.

## Name Conflicts

Suppose I have a Python class called `Spot` that represents a point in some image recognition software I'm writing:

```python
class Spot:
    def __init__(self, name, pos):
        self.name = name
        self.pos = pos
```

Then I write a couple utility functions, not attached as methods:

```python
def find_spot_clusters(spots, tolerance):
    """
    Returns a list of spot lists, where each list is a 
    'cluster' of spots within *tolerance* of each other.
    """
    ...
```

I put all this related code into a module (AKA a file). As per [PEP 8](https://www.python.org/dev/peps/pep-0008/#package-and-module-names)'s advice on naming modules:

> Modules should have short, all-lowercase names. Underscores can be used in the module name if it improves readability. Python packages should also have short, all-lowercase names, although the use of underscores is discouraged.

Sounds good to me. This module is all about spots, I'll call it `spot.py`. All is well. 

Later on, in some processing code, I'm filtering out spots:

```python
# processing.py

from . import spot

def filter_spots(spots):
    valid_spots = []
    for spot in spots:
        match = re.match(r'hello', spot.name)
        if match:
            valid_spots.append(spot)

    clusters = spot.find_spot_clusters(valid_spots)

    ...
```

Did you see the bug?

> Side note: I almost never read code in blog posts, I never have the energy.

We clobber the imported `spot` module with the variable `spot` in `for spot in spots`. For the rest of this function, we can no longer refer to the `spot` module.

## Potential Solutions

Let's go through the three ways I fix this, and why none of them satisfy me.

### Don't Import the Entire Module

I could just import specific features from the module, rather than the entire spot module:

```python
from .spot import Spot, find_spot_clusters
```

No more conflicts with `spot`! I don't like this solution for several reasons. 

First, keeping the module name helps me keep my code organized when a project gets bigger and bigger. When I see functions and classes without a module-prefix, I know they are local to the current module I'm reading.

Second, if I know that the module name is always used with a function, I can make shorter function names. Rather than `find_spot_clusters`, if I know that `spot.py` is only about spots, I can name it `find_clusters`. Then inside `spot.py`, it's clear that `find_clusters` is about spots, because the entire file is spot-related.
If I use the function outside `spot.py`, it's prefixed with `spot.`, and I know it's spot-related.

### Better Variable Names

Rather than `for spot in spots`, we could write `for maybe_valid_spot in spots` to clarify that our spot is not necessarily a valid spot at this point in the function. This is clearly clunky; `for <thing> in <things>` is a very typical Python pattern. 

I could also append an underscore: `for spot_ in spots`. This also feels clunky; it's expected for Python built-ins, like `exec` or `list`, but even some of the built-ins have common abbreviations like "lst" or "dct". I don't want to append underscores if I don't have to.

I could also shorten my variable name: `for sp in spot`. Sometimes though I want to rename a module, then I have to look for every variable with the same name as the module and determine if I have to change the variable name to avoid conflicts with the module. Which brings us to how to choose better module names.

### Different Module Names

Finally, I could find better names for my modules. Some of the naming strategies I've used in the past:

- Using verb gerands as module names: `analyzing.py` over `analyze.py`, for example. I find that I rarely use verb gerands as variable names, which makes them good module names. However, sometimes a module refers to a noun, not a verb, like our `spot.py` example.  
- Adding another word to the module: `spot_analysis.py` over `spot.py`. This just makes my names longer, and then I have to think of a second, equally valuable word, when in reality my module is all about spots, not spot analysis!

## Conclusion

I suck at naming Python modules. If you've suffered from this same problem and have found a good long-term solution that doesn't require a lot of thinking, please [let me know](mailto:samuel.robert.stevens@gmail.com)!
