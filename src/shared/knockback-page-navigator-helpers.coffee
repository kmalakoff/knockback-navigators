kb.override_transitions = []

# @private
kb.popOverrideTransition = ->
  if kb.override_transitions.length then kb.override_transitions.pop() else null

# Use a known dispatcher to route a url. Default is setting the window.location.hash.
# If you require supporting for a different router, override/replace this method.
kb.dispatchUrl = (url) ->
  window.location.hash = url # TODO: this is asynchronous...is this error-resistent enough?
  if window.Backbone and window.Backbone.History.started
    window.Backbone.history.loadUrl(url)
  else if window.Path
    window.Path.dispatch(url)

# Helper to load a url.
#
# @param [String] url the url to load
# @param [String|Object] transition transition options. Either a name or `{name: 'TransitionName', option1: option2: ...}`
kb.loadUrl = (url, transition) ->
  kb.override_transitions.push(transition)
  kb.dispatchUrl(url)

# Helper that creates a function that can be used in your HTML bindings for loading a url. Use this when you need to declare the loadUrl function but you are not calling it immediately
#
# @param [String] url the url to load
# @param [String|Object] transition transition options. Either a name or `{name: 'TransitionName', option1: option2: ...}`
kb.loadUrlFn = (url, transition) ->
  return (vm, event) ->
    kb.loadUrl(url, transition)

    # stop the event handling chains
    (not vm or not vm.stopPropagation) or (event = vm) # not a ViewModel, but an event
    if event and event.stopPropagation
      event.stopPropagation()
      event.preventDefault()

# utilities namespace
kb.utils or= {}

# Dual-purpose getter/setter for retrieving and storing a kb.PageNavigatorSimple or kb.PageNavigatorPanes on an element.
#
# @return [kb.PageNavigatorSimple|kb.PageNavigatorPanes] the page navigator
# @example
#   page_navigator = kb.utils.wrappedPageNavigator(element)
kb.utils.wrappedPageNavigator = (el, value) ->
  return el.__kb_page_navigator if (arguments.length is 1) or (el.__kb_page_navigator is value)
  el.__kb_page_navigator.destroy() if el.__kb_page_navigator
  el.__kb_page_navigator = value
  return value