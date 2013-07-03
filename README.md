# Tantamount

This Node module is port to CoffeeScript of the old `isEqual` implementation
from [underscore](http://underscorejs.org/#isEqual) that was removed in
[this commit](https://github.com/documentcloud/underscore/commit/f97783bd177e9f2fad49eadf1ae19c303150c647).

It is basically the same as underscore's current `isEqual` function except that
it uses either value's `isEqual` function when available.

## Installing

```sh
npm install tantamount
```

## Using

```coffeescript
isEqual = require 'tantamount'
```

### isEqual(a, b)

Tests if `a` is equal to `b`.

`a` - A value to test.

`b` - A value to test.

Returns `true` if the two objects are equal, `false` otherwise.
