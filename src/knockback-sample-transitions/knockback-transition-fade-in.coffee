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
  @