kb.MAX_TRANSITION = 800 # TODO: find a more reliable way to trigger transition end events

# CSS TRANSITION SUPPORT (http://www.modernizr.com/)
kb.transitions.END_EVENT = (->
  el = document.createElement('knockback')
  END_EVENT_NAMES =
    'WebkitTransition' : 'webkitTransitionEnd'
    'MozTransition'    : 'transitionend'
    'OTransition'      : 'oTransitionEnd otransitionend'
    'msTransition'     : 'MSTransitionEnd'
    'transition'       : 'transitionend'
  for style, event of END_EVENT_NAMES
    return event if el.style[style] isnt undefined
  return 'kbTransitionEnd'
)()

# get active set
kb.active_transitions = (if kb.transitions.END_EVENT is 'kbTransitionEnd' then kb.fallback_transitions else kb.transitions)

$.fn.startTransition = (classes, callback) ->
  (callback = classes; classes = null) if typeof(classes) is 'function'

  # end transition
  cleanupCallback = =>
    @off(kb.transitions.END_EVENT, cleanupCallback);
    not callback or callback()

  # start transition
  @one(kb.transitions.END_EVENT, cleanupCallback)
  @addClass(classes)

  # timeout for too long
  setTimeout(cleanupCallback, kb.MAX_TRANSITION)

  return

$.fn.stopTransition = ->
  @trigger(kb.transitions.END_EVENT)
  return