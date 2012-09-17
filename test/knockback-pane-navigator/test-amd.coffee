$(->
  module("knockback-pane-navigators-amd.js")

  # library and dependencies
  require(['underscore', 'backbone', 'knockout', 'knockback', 'knockback-pane-navigator'], (_, Backbone, ko, kb) ->
    _ or= @_
    Backbone or= @Backbone

    test("TEST DEPENDENCY MISSING", ->
      ok(!!_, '_'); ok(!!Backbone, 'Backbone'); ok(!!ko, 'ko'); ok(!!kb, 'kb'); ok(!!kb.PaneNavigator, 'kb.PaneNavigator')
    )

    test("1. Basic Usage", ->
      # kb.statistics = new kb.Statistics() # turn on stats

      el = $('<div></div>')[0]
      page_navigator = new kb.PaneNavigator(el)
      equal(el, page_navigator.el, "container element")

      # equal(kb.statistics.registeredStatsString('all released'), 'all released', "Cleanup: stats"); kb.statistics = null
    )
  )
)