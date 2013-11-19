isEqual = require '../index'

describe 'isEqual(a, b)', ->
  it 'returns true when the elements are equal, false otherwise', ->
    expect(isEqual(null, null)).toBe true
    expect(isEqual('test', 'test')).toBe true
    expect(isEqual(3, 3)).toBe true
    expect(isEqual({a: 'b'}, {a: 'b'})).toBe true
    expect(isEqual([1, 'a'], [1, 'a'])).toBe true

    expect(isEqual(null, 'test')).toBe false
    expect(isEqual(3, 4)).toBe false
    expect(isEqual({a: 'b'}, {a: 'c'})).toBe false
    expect(isEqual({a: 'b'}, {a: 'b', c: 'd'})).toBe false
    expect(isEqual([1, 'a'], [2])).toBe false
    expect(isEqual([1, 'a'], [1, 'b'])).toBe false

    a = isEqual: (other) -> other is b
    b = isEqual: (other) -> other is 'test'
    expect(isEqual(a, null)).toBe false
    expect(isEqual(a, 'test')).toBe false
    expect(isEqual(a, b)).toBe true
    expect(isEqual(null, b)).toBe false
    expect(isEqual('test', b)).toBe true

    expect(isEqual(/a/, /a/g)).toBe false
    expect(isEqual(/a/, /b/)).toBe false
    expect(isEqual(/a/gi, /a/gi)).toBe true

  it "calls custom equality methods with stacks so they can participate in cycle-detection", ->
    class X
      isEqual: (b, aStack, bStack) ->
        isEqual(@y, b.y, aStack, bStack)

    class Y
      isEqual: (b, aStack, bStack) ->
        isEqual(@x, b.x, aStack, bStack)

    x1 = new X
    y1 = new Y
    x1.y = y1
    y1.x = x1

    x2 = new X
    y2 = new Y
    x2.y = y2
    y2.x = x2

    expect(isEqual(x1, x2)).toBe true

  it "only accepts arrays as stack arguments to avoid accidentally calling with other objects", ->
    expect(-> isEqual({}, {}, "junk")).not.toThrow()
    expect(-> isEqual({}, {}, [], "junk")).not.toThrow()
