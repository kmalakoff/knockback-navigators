# import Knockback is it exists
try (@kb = kb = if not @kb and (typeof(require) isnt 'undefined') then require('knockback') else @kb) catch e then {}
@kb or= kb or= {} # empty namesapce

isElement = (obj) -> return obj and (obj.nodeType is 1)

kb.transitions or= {}
kb.fallback_transitions or= {}

# export Knockback so it is accessible by the views
@kb = kb