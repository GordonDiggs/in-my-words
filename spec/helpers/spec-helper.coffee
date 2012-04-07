window.context = window.describe;
window.xcontext = window.xdescribe

wipeLocalStorage = ->
  (delete localStorage[localStorage.key(i)] for i in [0..(localStorage.length-1)])

beforeEach wipeLocalStorage

beforeEach ->
  @addMatchers
    toIs: (s) -> @actual.is(s)
    toHas: (s) -> @actual.find(s).length > 0


unfakes = []
afterEach ->
  _(unfakes).each (u) -> u()
  unfakes = []

window.fakeEvent = ->
  obj = jasmine.createSpyObj('event', ['preventDefault'])
  obj.target = $('<div></div>')[0]
  obj

window.fake = (owner, thingToFake, newThing) ->
  originalThing = owner[thingToFake]
  owner[thingToFake] = newThing
  unfakes.push ->
    owner[thingToFake] = originalThing

window.fakeClass = (owner, classToFake, methodsToSpy = []) ->
  methodsToSpy = [methodsToSpy] if _(methodsToSpy).isString()

  spies = constructor: jasmine.createSpy("#{classToFake}'s constructor")
  fakeClass = class
    constructor: -> spies.constructor.apply(@, arguments)

  spies = _(methodsToSpy).reduce((memo, methodName) ->
    memo[methodName] = jasmine.createSpy("#{classToFake}##{methodName}")
    fakeClass.prototype[methodName] = -> memo[methodName].apply(@,arguments)
    memo
  , spies)
  fake(owner, classToFake, fakeClass)
  spies



