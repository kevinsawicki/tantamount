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
