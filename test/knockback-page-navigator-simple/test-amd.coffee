try
  require.config({
    paths:
      'underscore': "../../vendor/test/underscore-1.4.4"
      'backbone': "../../vendor/test/backbone-1.0.0"
      'knockout': "../../vendor/test/knockout-2.2.1"
      'knockback': "../../vendor/test/knockback-core-0.17.0"
      'knockback-page-navigator-simple': "../../knockback-page-navigator-simple"
    shim:
      underscore:
        exports: '_'
      backbone:
        exports: 'Backbone'
        deps: ['underscore']
      'knockback-page-navigator-simple':
        deps: ['knockback']
  })

  module_name = 'knockback-defaults'
  module_name = 'knockback' if (require.toUrl(module_name).split('./..').length is 1)

  # library and dependencies
  require ['underscore', 'backbone', 'knockout', 'knockback', 'knockback-page-navigator-simple', 'qunit_test_runner'], (_, Backbone, ko, kb, kbn, runner) ->
    window._ = window.Backbone = window.ko = null # force each test to require dependencies synchronously
    # window.kb = null # force each test to require dependencies synchronously
    require ['./build/test'], -> runner.start()