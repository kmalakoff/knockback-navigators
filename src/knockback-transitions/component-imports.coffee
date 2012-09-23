# import Knockback is it exists
try (@kb = kb = if not @kb and (typeof(require) isnt 'undefined') then require('knockback') else @kb) catch e then {}
@kb or= kb or= {} # empty namesapce

kb.transitions or= {}
kb.fallback_transitions or= {}
