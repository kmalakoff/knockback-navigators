# Pane Navigator that simply replaces the active page element when it changes and cleans up the previous if it exists.
#
# @note If using Knockout, 'hasHistory', 'activePage', and 'activeUrl' methods can be can be observed for changes.
#
class kb.PageNavigatorSimple

  # @param [Element] el the container element for the page navigator
  # @param [Object] options create options
  # @option options [Boolean] no_remove do not remove elements from the DOM with they are inactive. Useful if you are using a static DOM hierarchy rather than generating the elements dynamically.
  constructor: (el, @options={}) ->
    el or throwMissing(@, 'el')

    # bind functions so they can be called from templates
    _.bindAll(@, 'hasHistory', 'activePage', 'activeUrl', 'loadPage', 'dispatcher')

    # initialize state
    @el = if el.length then el[0] else el
    $(@el).addClass('page') # ensure the 'page' class exists for css
    @active_page = ko.observable()

  destroy: ->
    @destroyed = true
    @el = null; @active_page = null

  ####################################
  # Querying Page State
  ####################################

  clear: -> @loadPage(null)
  hasHistory: -> return false
  activePage: -> return @active_page()
  activeUrl: -> return if (active_page = @active_page()) then active_page.url else null

  # Load the active page
  #
  # @param info [Object|Element] used to create the pane
  # @option info [Element] el a DOM element
  # @option info [Function] create a function to create the element when the page becomes active
  loadPage: (info) ->
    info or throwMissing(@, 'page info')

    # already active
    if @activeUrl() is window.location.hash
      active_page = @activePage()
      active_page.el or pane_navigator.ensureElement(active_page)
      @el.appendChild(active_page.el) unless active_page.el.parentNode is @el
      return active_page

    # destroy previous
    previous_page.destroy(@options) if (previous_page = @activePage())

    # create a new page
    active_page = new kb.Pane(info, window.location.hash)
    active_page.activate(@el)
    @active_page(active_page)

    return active_page

  ####################################
  # Route Dispatching
  ####################################

  # Create a dispatcher function that can be bound to your router and that will correct dispatch url changes (for example, reuse a page if it is already loaded)
  dispatcher: (callback) ->
    page_navigator = @
    return ->
      # track destroy because the path libraries typically do not allow cleanup or router changing
      page_navigator.destroyed or page_navigator.routeTriggered(@, callback, arguments)
      return

  # @private
  routeTriggered: (router, callback, args) ->
    # the active page, skip
    if (active_page = @activePage()) and (active_page.url is (window.location.hash))
      @loadPage(active_page)

    # load the page
    else if callback
      callback.apply(router, args)

####################################
# Module
####################################
# export to modules
if (typeof(exports) isnt 'undefined')
  exports.PageNavigatorSimple = kb.PageNavigatorSimple