$(document).ready( ->
  module("knockback-page-navigators-simple-amd.js")

  # Knockback and depdenencies
  require(['underscore', 'backbone', 'knockout', 'knockback', 'knockback-page-navigator-simple'], (_, Backbone, ko, kb) ->
    _ or (_ = kb._)
    Backbone or (Backbone = kb.Backbone)

    test("TEST DEPENDENCY MISSING", ->
      ok(!!_, '_'); ok(!!Backbone, 'Backbone'); ok(!!ko, 'ko'); ok(!!kb, 'kb'); ok(!!kb.PageNavigatorSimple, 'kb.PageNavigatorSimple')
    )

    test("1. Basic Usage", ->
      # kb.statistics = new kb.Statistics() # turn on stats

      el = $('<div></div>')[0]
      page_navigator = new kb.PageNavigatorSimple(el)
      equal(el, page_navigator.el, "container element")

      # equal(kb.statistics.registeredStatsString('all released'), 'all released', "Cleanup: stats"); kb.statistics = null
    )
  )
)