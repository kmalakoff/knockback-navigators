if ko.bindingHandlers
  ko.bindingHandlers['PaneNavigator'] =
    'init': (element, value_accessor, all_bindings_accessor, view_model) ->
      options = ko.utils.unwrapObservable(value_accessor())
      options.no_detach = true unless 'no_detach' of options
      pane_navigator = new kb.PaneNavigator(element, options)

      # add to the element
      kb.utils.wrappedPaneNavigator(element, pane_navigator)
      ko.utils.domNodeDisposal.addDisposeCallback(element, ->
        kb.utils.wrappedPaneNavigator(element, null)    # release pane navigators
      )

      # ensure the class exists
      $(element).addClass('pane-navigator')

    'update': (element, value_accessor) ->
      checkPanesForActivate = ->
        # already has active panes
        pane_navigator = kb.utils.wrappedPaneNavigator(element)
        return if pane_navigator.activePane()
        $pane_els = $(pane_navigator.el).children().filter('.pane')
        pane_navigator.push(new kb.Pane($pane_els[0])) if $pane_els.length

      # if no childen, check after the children templates are rendered
      if element.children.length then checkPanesForActivate() else setTimeout(checkPanesForActivate, 0)