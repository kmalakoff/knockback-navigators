kb.transistions or= {}

# only used by kb.PaneNavigator
unless _.indexOf
  _.indexOf = (array, value) -> (return index if test is value) for index, test of array; return -1

class kb.PaneNavigator
  # options
  # - no_history - default is with history
  constructor: (el, options) ->
    el or throwMissing(@, 'el')

    @[key] = value for key, value of options # mixin
    @panes = ko.observableArray()
    @el = if el and el.length then el[0] else el
    $(@el).addClass('pane-navigator') # ensure the 'pane-navigator' class exists for css

  destroy: ->
    @el = null
    @clear({silent: true})

  clear: (options={}) ->
    # cancel the transition
    @cancelTransition()

    # destroy the active pane
    active_pane.destroy(@) if (active_pane = @activePane())

    # clear silently
    array = @panes()
    panes = array.slice() # copy so triggering only happens after clearing (not for each pane)
    panes.pop() # remove the active pane, since it was destroyed
    array.splice(0, array.length) # clear

    # destroy panes
    while pane = panes.pop()
      pane.destroy(@) if pane.el

    # now trigger an update
    @panes([]) unless options.silent
    @

  activePane: -> return @paneAt(-1)
  previousPane: -> return @paneAt(-2)
  paneAt: (offset) ->
    panes = @panes()
    index = if offset < 0 then panes.length + offset else offset
    return if (index >=0 and index < panes.length) then panes[index] else null

  push: (active_pane, options={}) ->
    return unless active_pane # no pane

    # cancel the transition
    @cancelTransition()
    active_pane.transition = options.transition if 'transition' of options # override transition

    # activate and store
    active_pane.activate(@el)
    if options.silent then @panes().push(active_pane) else @panes.push(active_pane) # store new active pane

    # clean up previous
    previous_pane = @previousPane()
    clean_up_fn = =>
      @cleanupTransition()

      if previous_pane
        # no history, destroy previous
        if @no_history
          panes = @panes()
          panes.splice(_.indexOf(panes, previous_pane), 1)
          previous_pane.destroy(@)

        # history, deactivate previous
        else
          previous_pane.deactivate(@)

    # create and start a transition
    if active_pane and (active_pane.transition or @transition)
      @startTransition(active_pane, previous_pane, clean_up_fn, true)

    # clear previous now
    else
      clean_up_fn()

    return active_pane

  pop: (options={}) ->
    previous_pane = @previousPane()
    return null unless previous_pane # no where to go back to

    # cancel the transition
    @cancelTransition()

    # override the transition
    active_pane = @activePane()
    active_pane.transition = options.transition if 'transition' of options # override transition

    # activate or re-create the active pane (if it was uncached)
    @panes.pop()

    # re-activate the previous pane
    previous_pane.activate(@el)

    # deactivate the pane
    clean_up_fn = =>
      @cleanupTransition()
      active_pane.destroy(@) if active_pane

    # create and start a transition
    if active_pane and (active_pane.transition or @transition)
      @startTransition(active_pane, previous_pane, clean_up_fn, false)

    # clear previous now
    else
      clean_up_fn()

    return previous_pane

  ####################################
  # Transition Animations
  ####################################
  # @private
  startTransition: (active_pane, previous_pane, callback, forward) ->
    return unless active_pane

    # use previous in reverse
    use_previous = active_pane.transition.options.use_previous if active_pane.transition and active_pane.transition.options
    if use_previous
      [active_pane, previous_pane] = [previous_pane, active_pane]
      forward = not forward

    # resolve the transition constructor
    transition = if active_pane.transition then active_pane.transition else @transition
    return null unless transition
    transition = {name: transition} if (typeof(transition) is 'string')
    throw "transition #{transition.name} not found" unless kb.transistions[transition.name]

    # resolve the transition options
    options = {forward: forward}
    options[key] = value for key, value of transition # merge in options

    # inverse now so transition logic is kept simple
    if options.inverse
      [active_pane, previous_pane] = [previous_pane, active_pane]
      options.forward = not options.forward
    delete options.inverse

    # create the info
    info =
      container_el: @el
      from_el: if previous_pane then previous_pane.el else null
      to_el: if active_pane then active_pane.el else null
      callback: callback

    # create the transition
    @active_transition = {callback: callback, transition: new kb.transistions[transition.name](info, options)}
    @active_transition.transition.start()

  # @private
  cancelTransition: ->
    return unless @active_transition
    transition = @active_transition.transition
    @active_transition = null
    transition.cancel()

  # @private
  cleanupTransition: ->
    @active_transition = null

####################################
# Module
####################################
# export to modules
if (typeof(exports) isnt 'undefined')
  exports.PaneNavigator = kb.PaneNavigator