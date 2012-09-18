# Constructor for a FadeIn transition animation.
#
# @param [Object] info the hierarchy information for the transition.
# @option info [Element] container_el the parent container for the pane elements
# @option info [Element] from_el the element being transitioned from
# @option info [Element] to_el the element being transitioned to
# @option info [Function] callback the callback that must be called when the tranition animation is completed
# @param [Object] options the transition options.
# @option options [Boolean] forward play the transition animation in a forward or reverse direction
# @option options [Float] duration specify a duarion for the animation (default is 500)
kb.transistions.FadeIn = (info, options) ->
  # extract state and parameters
  initial_state = new kb.TransitionSavedState(info, {to_el: ['min-height', 'opacity'], container_el: ['overflow']})
  $to_el = $(info.to_el)
  $container_el = $(info.container_el)

  @cancel = -> $to_el.stop() # will trigger the callback
  @callback = ->
    initial_state.restore()
    info.callback()
  @start = ->
    # do animation
    $to_el.addClass('on-top')
    $to_el.css({'min-height': $container_el.height()})
    $container_el.css({'overflow': 'hidden'})
    duration = if 'duration' of options then options.duration else 500
    if options.forward
      $to_el.css({'opacity': 0})
      $to_el.animate({'opacity': 1}, 1000, 'swing', @callback)
    else # reverse
      $to_el.css({'opacity': 1})
      $to_el.animate({'opacity': 0}, 1000, 'swing', @callback)
  return