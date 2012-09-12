# Constructor for a NavigationSlide transition animation.
#
# @param [Object] info the hierarchy information for the transition.
# @option info [Element] container_el the parent container for the pane elements
# @option info [Element] from_el the element being transitioned from
# @option info [Element] to_el the element being transitioned to
# @option info [Function] callback the callback that must be called when the tranition animation is completed
# @param [Object] options the transition options.
# @option options [Boolean] forward play the transition animation in a forward or reverse direction
# @option options [Float] duration specify a duarion for the animation (default is 500)
kb.transistions.NavigationSlide = (info, options) ->
  # extract state and parameters
  initial_state = new kb.TransitionSavedState(info, {to_el: ['left'], from_el: ['left'], container_el: ['overflow']})
  $from_el = $(info.from_el)
  $to_el = $(info.to_el)
  $container_el = $(info.container_el)
  width = $container_el.width()
  duration = if 'duration' of options then options.duration else 500

  @cancel = -> $to_el.stop() # will trigger the callback
  @callback = ->
    initial_state.restore()
    info.callback()
  @start = ->
    (info.callback(); return) unless info.from_el

    # do animation
    if options.forward
      $from_el.css({left: '0px'})
      $from_el.animate({left: -width}, duration, 'linear')
      $to_el.css({left: width})
      $to_el.animate({left: '0px'}, duration, 'linear', @callback)
    else # reverse
      $from_el.css({left: -width})
      $from_el.animate({left: '0px'}, duration, 'linear')
      $to_el.css({left: '0px'})
      $to_el.animate({left: width}, duration, 'linear', @callback)
  @