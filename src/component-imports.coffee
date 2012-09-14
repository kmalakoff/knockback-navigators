####################################
# INTERNAL HELPERS
####################################
# @private
throwUnexpected = (instance, message) -> throw "#{instance.constructor.name}: #{message} is unexpected"

# import Knockback is it exists
try (@kb = kb = if not @kb and (typeof(require) isnt 'undefined') then require('knockback') else @kb) catch e then {}
@kb or= kb or= {} # empty namesapce

# import Knockout or provide a replacement for ko.observable and ko.observableArray
try (ko = if (typeof(require) != 'undefined') then require('knockout') else @ko) catch e then {}
ko or= {} # empty namesapce
unless ko.observable # no Knockout, make minimal fake ko.observable and and ko.observableArray for simplifying the watching API

  # lifecycle
  ko.dataFor = (el) -> null
  ko.removeNode = (el) -> $(el).remove()

  # observables
  ko.observable = (initial_value) ->
    value = initial_value
    return (new_value) -> if arguments.length then value = new_value else return value

  ko.observableArray = (initial_value) ->
    observable = ko.observable(if arguments.length then initial_value else [])
    observable.push = -> observable().push.apply(observable(), arguments)
    observable.pop = -> return observable().pop.apply(observable(), arguments)
    return observable

# import underscore or provide a replacement _.bindAll function
_ = if @_ then @_ else (if kb._ then kb._ else {}) # either window._ or Underscore.js from Knockback.js or empty namesapce
unless _.bindAll
  bind = (obj, fn_name) ->
    fn = obj[fn_name]
    return obj[fn_name] = -> fn.apply(obj, arguments)

  _.bindAll = (obj, fn_name1) ->
    bind(obj, fn_name) for fn_name in Array.prototype.slice.call(arguments, 1)
    return

unless _.isElement
  _.isElement = (obj) -> return obj and (obj.nodeType is 1)

# alias xui to $
@$ = @x$ if @x$