$(->
  module("knockback-pane-navigator.js")

  # import Underscore (or Lo-Dash with precedence), Backbone, Knockout, and Knockback
  _ = if not window._ and (typeof(require) isnt 'undefined') then require('underscore') else window._
  _ = _._ if _ and _.hasOwnProperty('_') # LEGACY
  Backbone = if not window.Backbone and (typeof(require) isnt 'undefined') then require('backbone') else window.Backbone
  ko = if not window.ko and (typeof(require) isnt 'undefined') then require('knockout') else window.ko
  kb = if not window.kb and (typeof(require) isnt 'undefined') then require('knockback') else window.kb
  require('knockback-pane-navigator') if (typeof(require) isnt 'undefined')

  test("TEST DEPENDENCY MISSING", ->
    ok(!!_, '_'); ok(!!Backbone, 'Backbone'); ok(!!ko, 'ko'); ok(!!kb, 'kb'); ok(!!kb.PaneNavigator, 'kb.PaneNavigator')
  )

  test("1. Basic Usage", ->
    # kb.statistics = new kb.Statistics() # turn on stats

    el = $('<div></div>')[0]
    pane_navigator = new kb.PaneNavigator(el)
    equal(el, pane_navigator.el, "container element")

    # equal(kb.statistics.registeredStatsString('all released'), 'all released', "Cleanup: stats"); kb.statistics = null
  )
)