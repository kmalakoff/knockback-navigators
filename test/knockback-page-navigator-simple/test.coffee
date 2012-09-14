$(document).ready( ->
  module("knockback-page-navigator-simple.js")

  # import Underscore (or Lo-Dash with precedence), Backbone, Knockout, and Knockback
  if (typeof(require) isnt 'undefined') then _ = require('underscore') else _ = window._
  _ = _._ if _ and _.hasOwnProperty('_') # LEGACY
  Backbone = if not window.Backbone and (typeof(require) isnt 'undefined') then require('backbone') else window.Backbone
  ko = if not window.ko and (typeof(require) isnt 'undefined') then require('knockout') else window.ko
  kb = if not window.kb and (typeof(require) isnt 'undefined') then require('knockback') else window.kb
  require('knockback-page-navigator-simple') if (typeof(require) isnt 'undefined')

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