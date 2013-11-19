_ = require 'underscore'

_isEqual = _.isEqual

isEqual = (a, b, aStack=[], bStack=[]) ->
  return _isEqual(a, b) if a is b
  return _isEqual(a, b) if _.isFunction(a) or _.isFunction(b)

  stackIndex = aStack.length
  while stackIndex--
    return bStack[stackIndex] is b if aStack[stackIndex] is a
  aStack.push(a)
  bStack.push(b)

  return a.isEqual(b, aStack, bStack) if _.isFunction(a?.isEqual)
  return b.isEqual(a, bStack, aStack) if _.isFunction(b?.isEqual)

  equal = false
  if _.isArray(a) and _.isArray(b) and a.length is b.length
    equal = true
    for aElement, i in a
      unless isEqual(aElement, b[i], aStack, bStack)
        equal = false
        break
  else if _.isRegExp(a) and _.isRegExp(b)
    equal = _isEqual(a, b)
  else if _.isObject(a) and _.isObject(b)
    aCtor = a.constructor
    bCtor = b.constructor
    aCtorValid = _.isFunction(aCtor) and aCtor instanceof aCtor
    bCtorValid = _.isFunction(bCtor) and bCtor instanceof bCtor
    if aCtor isnt bCtor and not (aCtorValid and bCtorValid)
      equal = false
    else
      aKeyCount = 0
      equal = true
      for key, aValue of a
        continue unless _.has(a, key)
        aKeyCount++
        unless _.has(b, key) and isEqual(aValue, b[key], aStack, bStack)
          equal = false
          break
      if equal
        bKeyCount = 0
        for key, bValue of b
          bKeyCount++ if _.has(b, key)
        equal = aKeyCount is bKeyCount
  else
    equal = _isEqual(a, b)

  aStack.pop()
  bStack.pop()
  equal

module.exports = (a, b, aStack, bStack) ->
  if _.isArray(aStack) and _.isArray(bStack)
    isEqual(a, b, aStack, bStack)
  else
    isEqual(a, b)
