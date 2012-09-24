kb.SLIDE_UP_DURATION = 300

# Constructor for a SlideUp transition animation.
#
# @param [Object] info the hierarchy information for the transition.
# @option info [Element] container the parent container for the pane elements
# @option info [Element] from the element being transitioned from
# @option info [Element] to the element being transitioned to
# @option info [Function] callback the callback that must be called when the tranition animation is completed
# @param [Object] options the transition options.
# @option options [Boolean] forward play the transition animation in a forward or reverse direction
# @option options [Float] duration specify a duarion for the animation (default is 500)
kb.fallback_transitions.SlideUp = (info, options) ->
  (info.callback(); return) unless info.from # no transition
  $to = $(info.to)
  callback = -> $to.stop(); $to.off(kb.transitions.END_EVENT, callback); info.callback()

  # do animation
  height = info.container.clientHeight; top = info.to.clientTop
  if options.forward
    $to.addClass('on-top').css({top: top+height}).animate({top: top}, kb.SLIDE_UP_DURATION, 'linear', callback)
  else # reverse
    $to.addClass('on-top').animate({top: top+height}, kb.SLIDE_UP_DURATION, 'linear', callback)
  $to.one(kb.transitions.END_EVENT, callback)
  return