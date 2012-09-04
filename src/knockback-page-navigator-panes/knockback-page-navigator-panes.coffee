class kb.PageNavigatorPanes

  # @option options [Object] {no_remove: boolean}
  constructor: (el, options={}) ->
    el or throwMissing(@, 'el')

    # bind functions so they can be called from templates
    _.bindAll(@, 'hasHistory', 'activePage', 'previousPage', 'activeUrl', 'loadPage', 'goBack', 'dispatcher')

    # initialize state
    @el = if el.length then el[0] else el
    $(@el).addClass('page') # ensure the 'page' class exists for css
    @pane_navigator = new kb.PaneNavigator(el, options)

  destroy: ->
    @destroyed = true
    @el = null
    @pane_navigator.destroy(); @pane_navigator = null

  ####################################
  # Querying Page State
  # - If using Knockout, these methods can be can be observed for changes
  ####################################
  hasHistory: -> return not @pane_navigator.no_history
  activePage: -> return @pane_navigator.activePane()
  activeUrl: -> return if (active_page = @pane_navigator.activePane()) then active_page.url else null
  previousPage: -> return @pane_navigator.previousPane()
  previousUrl: -> return if (previous_page = @pane_navigator.previousPage()) then previous_page.url else null

  # Load the active page
  #
  # @param info [Object|Element] used to create the pane
  # @option info [Element] el a DOM element
  # @option info [Function] create a function to create the element when the page becomes active
  # @option info [Object|String] transition a transition name or Object with name key and option keys
  loadPage: (info) ->
    throw 'missing page info' unless info
    transition = kb.popOverrideTransition()

    # already active
    if @activeUrl() is window.location.hash
      active_page = @activePage()
      active_page.el or pane_navigator.ensureElement(active_page)
      $(@el).append(active_page.el) unless active_page.el.parentNode is @el
      return active_page

    # add to the pane manager
    return @pane_navigator.push(new kb.Pane(info, window.location.hash), if transition then {transition: transition} else null)

  goBack: ->
    transition = kb.popOverrideTransition()
    @pane_navigator.pop()
    not (active_page = @pane_navigator.activePane()) or kb.loadUrl(active_page.url)
    return active_page

  ####################################
  # Route Dispatching
  ####################################
  dispatcher: (callback) ->
    page_navigator = @
    return ->
      return if page_navigator.destroyed # the path libraries typically do not allow cleanup or router changing
      page_navigator.routeTriggered(@, callback, arguments)

  # @private
  routeTriggered: (router, callback, args) ->
    url = window.location.hash

    # the active page, skip
    if (active_page = @activePage()) and (active_page.url is (window.location.hash))
      @loadPage(active_page)

    # the previous page, go back
    else if (previous_page = @previousPage()) and (previous_page.url is url)
      @goBack()

    # load the page
    else if callback
      callback.apply(router, args)

####################################
# Module
####################################
# export to modules
if (typeof(exports) isnt 'undefined')
  exports.PageNavigatorPanes = kb.PageNavigatorPanes
