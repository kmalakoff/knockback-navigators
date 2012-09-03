kb.override_transitions = []

kb.popOverrideTransition = ->
  if kb.override_transitions.length then kb.override_transitions.pop() else null

kb.loadUrl = (url, transition) ->
  kb.override_transitions.push(transition)
  window.location.hash = url # this is asynchronous. TODO: is this error-resistent enough?

# add a utility
kb.utils or= {}
kb.utils.wrappedPageNavigator = (el, value) ->
  return el.__kb_page_navigator if (arguments.length is 1) or (el.__kb_page_navigator is value)
  el.__kb_page_navigator.destroy() if el.__kb_page_navigator
  el.__kb_page_navigator = value