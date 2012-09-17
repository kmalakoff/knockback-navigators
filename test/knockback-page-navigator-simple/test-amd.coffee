$(->
  module("knockback-page-navigators-simple-amd.js")

  # library and dependencies
  require(['underscore', 'backbone', 'knockout', 'knockback', 'knockback-page-navigator-simple'], (_, Backbone, ko, kb) ->
    _ or= @_
    Backbone or= @Backbone

    test("TEST DEPENDENCY MISSING", ->
      ok(!!_, '_'); ok(!!Backbone, 'Backbone'); ok(!!ko, 'ko'); ok(!!kb, 'kb'); ok(!!kb.PageNavigatorSimple, 'kb.PageNavigatorSimple')
    )

    test("1. Basic Usage", ->
      el = $('<div></div>')[0]
      page_navigator = new kb.PageNavigatorSimple(el)
      equal(el, page_navigator.el, "container element")
    )

    test("2. Click-Based navigation", ->
      # onclick
      el = $("""
        <a onclick="kb.loadUrl('test1', {name: 'NavigationSlide', inverse: true})">Examples</a>
      """)[0]
      window.location.hash = ''
      equal(window.location.hash, '', "onclick: no location hash")
      $(el).click()
      equal(window.location.hash, '#test1', "onclick: test1 location hash")
      equal(kb.popOverrideTransition().name, 'NavigationSlide', "onclick: transition found")

      # bound view model
      el = $("""
        <a data-bind="click: kb.loadUrlFn('test1', {name: 'NavigationSlide', inverse: true})">Examples</a>
      """)[0]
      ko.applyBindings({}, el)
      window.location.hash = ''
      equal(window.location.hash, '', "onclick: no location hash")
      $(el).click()
      equal(window.location.hash, '#test1', "onclick: test1 location hash")
      equal(kb.popOverrideTransition().name, 'NavigationSlide', "onclick: transition found")
    )
  )
)