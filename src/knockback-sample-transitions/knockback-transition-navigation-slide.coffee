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