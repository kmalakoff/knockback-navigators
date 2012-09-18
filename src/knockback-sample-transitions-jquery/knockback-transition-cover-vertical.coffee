# Constructor for a CoverVertical transition animation.
#
# @param [Object] info the hierarchy information for the transition.
# @option info [Element] container_el the parent container for the pane elements
# @option info [Element] from_el the element being transitioned from
# @option info [Element] to_el the element being transitioned to
# @option info [Function] callback the callback that must be called when the tranition animation is completed
# @param [Object] options the transition options.
# @option options [Boolean] forward play the transition animation in a forward or reverse direction
# @option options [Float] duration specify a duarion for the animation (default is 500)
kb.transistions.CoverVertical = (info, options) ->
  # extract state and parameters
  initial_state = new kb.TransitionSavedState(info, {to_el: ['min-height', 'bottom'], container_el: ['overflow']})
  $to_el = $(info.to_el)
  $container_el = $(info.container_el)
  container_height = $container_el.height()
  duration = if 'duration' of options then options.duration else 500

  @cancel = -> $to_el.stop() # will trigger the callback
  @callback = ->
    initial_state.restore()
    info.callback()
  @start = ->
    (info.callback(); return) unless info.from_el # no from, no transition

    # do animation
    $to_el.addClass('on-top')
    $to_el.css({'min-height': container_height})
    $container_el.css({'overflow': 'hidden'})
    if options.forward
      $to_el.css({bottom: -container_height})
      $to_el.animate({bottom: '0px'}, duration, 'linear', @callback)
    else # reverse
      $to_el.css({bottom: '0px'})
      $to_el.animate({bottom: -container_height}, duration, 'linear', @callback)
  return