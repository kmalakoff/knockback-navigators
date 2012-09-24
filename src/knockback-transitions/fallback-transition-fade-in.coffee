kb.FADE_IN_DURATION = 300

# Constructor for a FadeIn transition animation.
#
# @param [Object] info the hierarchy information for the transition.
# @option info [Element] container the parent container for the pane elements
# @option info [Element] from the element being transitioned from
# @option info [Element] to the element being transitioned to
# @option info [Function] callback the callback that must be called when the tranition animation is completed
# @param [Object] options the transition options.
# @option options [Boolean] forward play the transition animation in a forward or reverse direction
# @option options [Float] duration specify a duarion for the animation (default is 500)
kb.fallback_transitions.FadeIn = (info, options) ->
  $to = $(info.to)
  callback = -> $to.stop(); $to.off(kb.transitions.END_EVENT, callback); info.callback()

  # do animation
  $to.css({'min-height': $(info.container).height()})
  if options.forward
    $to.css({'opacity': 0})
    $to.animate({'opacity': 1}, kb.FADE_IN_DURATION, 'swing', info.callback)
  else # reverse
    $to.css({'opacity': 1})
    $to.animate({'opacity': 0}, kb.FADE_IN_DURATION, 'swing', info.callback)
  $to.one(kb.transitions.END_EVENT, callback)
  return