class kb.Pane
  constructor: (info, url) ->
    @url = url if arguments.length
    @setInfo(info)

  destroy: (options={}) ->
    # deactivate and remove from DOM
    @deactivate(options)
    @removeElement(options, true) # force
    @create = null
    @el = null

  # @private
  setInfo: (info) ->
    # an element
    if _.isElement(info)
      @el = info
    else
      @[key] = value for key, value of info # mixin
    $(@el).addClass('pane') if @el # ensure the 'pane' class exists for css
    return

  # @private
  ensureElement: ->
    return @el if @el
    @create or throwMissing(@, 'create')
    info = @create.apply(@, @args)
    @setInfo(info)  if info
    @el or throwMissing(@, 'element')
    $(@el).addClass('pane') if @el # ensure the 'pane' class exists for css
    return

  # @private
  removeElement: (options={}, force) ->
    return @ unless @el
    return if options.no_remove

    # dispose of the node
    if force or (@create and not options.no_destroy)
      ko.removeNode(@el)
      @el = null

    # just remove from the DOM (may reuse later)
    else if @el.parentNode
      @el.parentNode.removeChild(@el)
    return

  activate: (container_el) ->
    # append to container
    @ensureElement()
    return if $(@el).hasClass('active') # already active
    $(@el).addClass('active')
    container_el.appendChild(@el) unless @el.parentNode is container_el

    # notifications - activate
    view_model = if @view_model then @view_model else ko.dataFor(@el)
    view_model.activate(@) if view_model and view_model.activate
    return

  deactivate: (options={}) ->
    return unless (@el and $(@el).hasClass('active')) # not active
    $(@el).removeClass('active')

    # notifications - deactivate
    view_model = if @view_model then @view_model else ko.dataFor(@el)
    view_model.deactivate(@) if view_model and view_model.deactivate

    # remove from DOM
    @removeElement(options)
    return

####################################
# Module
####################################
# export to modules
if (typeof(exports) isnt 'undefined')
  exports.Pane = kb.Pane