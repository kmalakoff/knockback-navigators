if ko.bindingHandlers
  ko.bindingHandlers['PaneNavigator'] =
    'init': (element, value_accessor, all_bindings_accessor, view_model) ->
      options = ko.utils.unwrapObservable(value_accessor())
      options.no_remove = true unless 'no_remove' of options
      pane_navigator = new kb.PaneNavigator(element, options)

      # add to the element
      kb.utils.wrappedPaneNavigator(element, pane_navigator)
      ko.utils.domNodeDisposal.addDisposeCallback(element, ->
        kb.utils.wrappedPaneNavigator(element, null)    # release pane navigators
      )

      # ensure the class exists
      $(element).addClass('pane-navigator')