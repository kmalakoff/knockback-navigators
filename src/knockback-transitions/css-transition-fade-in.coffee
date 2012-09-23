# FadeIn transition animation.
#
# @param [Object] info the hierarchy information for the transition.
# @option info [Element] container the parent container for the pane elements
# @option info [Element] from the element being transitioned from
# @option info [Element] to the element being transitioned to
# @option info [Function] callback the callback that must be called when the tranition animation is completed
# @param [Object] options the transition options.
# @option options [Boolean] forward play the transition animation in a forward or reverse direction
# @option options [Float] duration specify a duarion for the animation (default is 500)
kb.transitions.FadeIn = (info, options) ->
	$to = $(info.to).css({'min-height': $(info.container).height()})
	$to.startTransition((if options.forward then 'on-top fade in' else 'on-top fade out'), info.callback)
	return