$(document).ready( ->
  module("knockback-page-navigators-panes-amd.js")

  # Knockback and depdenencies
  require(['underscore', 'backbone', 'knockout', 'knockback', 'knockback-page-navigator-panes'], (_, Backbone, ko, kb) ->
    _ or= @_
    Backbone or= @Backbone

    test("TEST DEPENDENCY MISSING", ->
      ok(!!_, '_'); ok(!!Backbone, 'Backbone'); ok(!!ko, 'ko'); ok(!!kb, 'kb'); ok(!!kb.PageNavigatorPanes, 'kb.PageNavigatorPanes')
    )

    test("1. Basic Usage", ->
      # kb.statistics = new kb.Statistics() # turn on stats

      el = $('<div></div>')[0]
      page_navigator = new kb.PageNavigatorPanes(el)
      equal(el, page_navigator.el, "container element")

      # equal(kb.statistics.registeredStatsString('all released'), 'all released', "Cleanup: stats"); kb.statistics = null
    )
  )
)