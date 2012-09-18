kb.transistions or= {}

# add animation $.fn.stop to Zepto.
# Note: this code is not guaranteed to work under all circumstances since it is a Monkey-Patch.
# If someone has a proper $.fn.stop implementation, please let me know.
if @Zepto

  wrapAnimCallback = (el, properties, callback) ->
    el.__kb_zepto_endEvent = if (typeof properties == 'string') then $.fx.animationEnd else $.fx.transitionEnd
    el.__kb_zepto_callback = ->
      return unless el.__kb_zepto_endEvent # already called
      delete el.__kb_zepto_endEvent
      delete el.__kb_zepto_callback
      not callback or callback.call(@)
    return el.__kb_zepto_callback

  _anim_fn = $.fn.anim
  $.fn.anim = (properties, duration, ease, callback) ->
    for el in @
      replacement_callback = wrapAnimCallback(el, properties, callback) # wrap the callback so it can be cancelled
    _anim_fn.call(@, properties, duration, ease, replacement_callback)
    return @

  $.fn.stop = ->
    for el in @
      $(el).trigger(el.__kb_zepto_endEvent) if el.__kb_zepto_endEvent # trigger the end
    return @