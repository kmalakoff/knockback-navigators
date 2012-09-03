# add a utility
kb.utils or= {}
kb.utils.wrappedPaneNavigator = (el, value) ->
  return el.__kb_pane_navigator if (arguments.length is 1) or (el.__kb_pane_navigator is value)
  el.__kb_pane_navigator.destroy() if el.__kb_pane_navigator
  el.__kb_pane_navigator = value

# custom find by path
if $.fn
  $.fn.findByPath = (path) ->
    results = []
    for el in this
      components = path.split('/')
      current_el = el
      for component in components
        if component[0] is '^'
          path = component.substring(1)
          if path
            $current_el = $(current_el).closest(path)
            current_el = if $current_el.length then $current_el[0] else null
          else
            current_el = current_el.parentNode
        else
          $current_el = $(current_el).find(component)
          current_el = if $current_el.length then $current_el[0] else null
        break unless current_el # not resolved
      results.push(current_el) if current_el
    return $(results)

  $.fn.findPaneNavigator = ->
    for el in this
      # has a path
      if path = el.getAttribute('data-path')
        $pane_navigator_el = this.findByPath(path)
        return if $pane_navigator_el.length and (pane_navigator = kb.utils.wrappedPaneNavigator($pane_navigator_el[0])) then pane_navigator else null

      else
        # look down from the first div parent's parent
        $parent = $(el).parent()
        while $parent.length and not $parent.is('div')
          $parent = $parent.parent()
        for pane_navigator_el in $parent.parent().find('.pane-navigator')
          if (pane_navigator = kb.utils.wrappedPaneNavigator(pane_navigator_el))
            return pane_navigator

        # look up
        $pane_navigator_el = $(el).closest('.pane-navigator')
        if $pane_navigator_el.length and (pane_navigator = kb.utils.wrappedPaneNavigator($pane_navigator_el[0]))
          return pane_navigator

      return null

# publish
kb.nextPane = (obj, event) ->
  el = if _.isElement(obj) then obj else (if obj.currentTarget then obj.currentTarget else event.currentTarget)
  pane_navigator = $(el).findPaneNavigator() # find pane navigator

  # no active pane
  return unless pane_navigator and (active_pane = pane_navigator.activePane())

  # push next, if it exists
  next_el = active_pane.el
  while (next_el = next_el.nextSibling)
    break if _.isElement(next_el) and $(next_el).hasClass('pane') # found it
  pane_navigator.push(new kb.Pane(next_el)) if next_el

kb.previousPane = (obj, event) ->
  el = if _.isElement(obj) then obj else (if obj.currentTarget then obj.currentTarget else event.currentTarget)
  pane_navigator = $(el).findPaneNavigator() # find pane navigator

  # pop the currently active pane
  if pane_navigator and pane_navigator.activePane()
    pane_navigator.pop()