extractStyles = (el) ->
  styles = {}
  for name, style of el.style
    continue unless style
    styles[name] = style
  return styles

# @private
class kb.TransitionSavedState

  # @private
  constructor: (info) ->
    @el_states = []
    for name, el of info
      not _.isElement(el) or @el_states.push({el: el, className: el.className, cssText: el.style.cssText})
    return

  # @private
  restore: ->
    for state in @el_states
      el = state.el; el.className = state.className; el.style.cssText = state.cssText
    @el_states = null # restore only once
    return

####################################
# Module
####################################
# export to modules
if (typeof(exports) isnt 'undefined')
  exports.TransitionSavedState = kb.TransitionSavedState