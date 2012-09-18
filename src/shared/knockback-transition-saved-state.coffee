class kb.TransitionSavedState

  # Construct optionally with the initial saved state
  #
  # @param info [Object] supplied by kb.PaneNavigator
  # @option info [element] container_el the parent container
  # @option info [element] to_el the element transitioning to
  # @option info [element] from_el the element transitioning from
  # @param el_map [Object] initial state to save
  # @option el_map [key] element_name the element to store classes and optinally css keys from
  # @option el_map [Array] css_keys the css keys to store
  constructor: (info, el_map) ->
    @el_states = []
    return unless el_map

    # initialize
    for el_key, css_keys of el_map
      @push(info[el_key], css_keys)

  push: (el, css_keys) ->
    return unless el
    state = {className: '' + el.className, css: {}}
    if css_keys
      state.css[key] = el.style[key] for key in css_keys
    @el_states.push({el: el, state: state})
    return

  restore: ->
    for entry in @el_states
      el = entry.el; state = entry.state
      continue unless el and state
      el.className = state.className if 'className' of state
      for key, value of state.css
        el.style[key] = value
    @el_states = null # restore only once
    return

####################################
# Module
####################################
# export to modules
if (typeof(exports) isnt 'undefined')
  exports.TransitionSavedState = kb.TransitionSavedState