if ko and ko.bindingHandlers
  ko.bindingHandlers['PageNavigatorSimple'] =
    'init': (element, value_accessor, all_bindings_accessor, view_model) ->
      options = ko.utils.unwrapObservable(value_accessor())
      options.no_detach = true unless 'no_detach' of options
      page_navigator = new kb.PageNavigatorSimple(element, options)

      # add to the element
      kb.utils.wrappedPageNavigator(element, page_navigator)
      ko.utils.domNodeDisposal.addDisposeCallback(element, ->
        options.unloaded?(page_navigator)               # notify the caller
        kb.utils.wrappedPageNavigator(element, null)    # release page navigators
      )

      # notify the caller
      options.loaded?(page_navigator)