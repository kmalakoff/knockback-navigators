# Constructor for a Slide transition animation.
#
# @param [Object] info the hierarchy information for the transition.
# @option info [Element] container the parent container for the pane elements
# @option info [Element] from the element being transitioned from
# @option info [Element] to the element being transitioned to
# @option info [Function] callback the callback that must be called when the tranition animation is completed
# @param [Object] options the transition options.
# @option options [Boolean] forward play the transition animation in a forward or reverse direction
# @option options [Float] duration specify a duarion for the animation (default is 500)
kb.fallback_transitions.Slide = (info, options) ->
  (info.callback(); return) unless info.from # no transition
  $to = $(info.to); $from = $(info.from)
  callback = -> $from.stop(); $to.stop(); info.callback()

  # do animation
  duration = if 'duration' of options then options.duration else FALLBACK_ANIMATION_DURATION
  width = $(info.container).width()
  if options.forward
    $from.animate({left: info.from.clientLeft-width}, duration, 'linear')
    to_left = info.to.clientLeft
    $to.css({left: to_left+width}).animate({left: to_left}, duration, 'linear', callback)
  else # reverse
    from_left = info.from.clientLeft
    $from.css({left: from_left-width}).animate({left: from_left}, duration, 'linear')
    $to.animate({left: info.to.clientLeft+width}, duration, 'linear', callback)
  $to.startTransition(callback)
	return