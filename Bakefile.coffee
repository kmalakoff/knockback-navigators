module.exports =
  knockback_page_navigator_panes:
    join: 'knockback-page-navigator-panes.js'
    wrapper: 'src/knockback-page-navigator-panes/module-loader.js'
    compress: true
    files: [
      'src/component-imports.coffee'
      'src/knockback-page-navigator-panes/knockback-page-navigator-panes.coffee'
      'src/knockback-page-navigator-panes/knockout-bindings.coffee'

      # bundle with pane navigator
      'src/knockback-pane-navigator/knockback-pane-navigator.coffee'
      'src/knockback-pane-navigator/knockback-pane-navigator-helpers.coffee'
      'src/knockback-pane-navigator/knockout-bindings.coffee'
      'src/shared/knockback-page-navigator-helpers.coffee'
      'src/shared/knockback-pane.coffee'
      'src/shared/knockback-transition-saved-state.coffee'
    ]

  knockback_page_navigator_simple:
    join: 'knockback-page-navigator-simple.js'
    wrapper: 'src/knockback-page-navigator-simple/module-loader.js'
    compress: true
    files: [
      'src/component-imports.coffee'
      'src/knockback-page-navigator-simple/knockback-page-navigator-simple.coffee'
      'src/knockback-page-navigator-simple/knockout-bindings.coffee'
      'src/shared/knockback-page-navigator-helpers.coffee'
      'src/shared/knockback-pane.coffee'
    ]

  knockback_pane_navigator:
    join: 'knockback-pane-navigator.js'
    wrapper: 'src/knockback-pane-navigator/module-loader.js'
    compress: true
    files: [
      'src/component-imports.coffee'
      'src/knockback-pane-navigator/knockback-pane-navigator.coffee'
      'src/knockback-pane-navigator/knockback-pane-navigator-helpers.coffee'
      'src/knockback-pane-navigator/knockout-bindings.coffee'
      'src/shared/knockback-pane.coffee'
      'src/shared/knockback-transition-saved-state.coffee'
    ]

  knockback_sample_transitions_jquery:
    join: 'knockback-sample-transitions-jquery.js'
    wrapper: 'src/knockback-sample-transitions-jquery/module-loader.js'
    output: 'lib'
    compress: true
    files: [
      'src/knockback-sample-transitions-jquery/component-imports.coffee'
      'src/knockback-sample-transitions-jquery/knockback-transition-helpers.coffee'
      'src/knockback-sample-transitions-jquery/knockback-transition-cover-vertical.coffee'
      'src/knockback-sample-transitions-jquery/knockback-transition-fade-in.coffee'
      'src/knockback-sample-transitions-jquery/knockback-transition-navigation-slide.coffee'
    ]

  publishing:
    _build:
      commands: [
        # create docs
        'codo src'

        # npm
        'cp README.md packages/npm/README.md'

        'cp knockback-navigators.css packages/npm/knockback-navigators.css'
        'cp knockback-page-navigator-panes.js packages/npm/knockback-page-navigator-panes.js'
        'cp knockback-page-navigator-panes.min.js packages/npm/knockback-page-navigator-panes.min.js'
        'cp knockback-page-navigator-simple.js packages/npm/knockback-page-navigator-simple.js'
        'cp knockback-page-navigator-simple.min.js packages/npm/knockback-page-navigator-simple.min.js'
        'cp knockback-pane-navigator.js packages/npm/knockback-pane-navigator.js'
        'cp knockback-pane-navigator.min.js packages/npm/knockback-pane-navigator.min.js'
        'cp lib/knockback-sample-transitions-jquery.js packages/npm/lib/knockback-sample-transitions-jquery.js'
        'cp lib/knockback-sample-transitions-jquery.min.js packages/npm/lib/knockback-sample-transitions-jquery.min.js'

        # nuget
        'cp knockback-navigators.css packages/nuget/Content/Scripts/knockback-navigators.css'
        'cp knockback-page-navigator-panes.js packages/nuget/Content/Scripts/knockback-page-navigator-panes.js'
        'cp knockback-page-navigator-panes.min.js packages/nuget/Content/Scripts/knockback-page-navigator-panes.min.js'
        'cp knockback-page-navigator-simple.js packages/nuget/Content/Scripts/knockback-page-navigator-simple.js'
        'cp knockback-page-navigator-simple.min.js packages/nuget/Content/Scripts/knockback-page-navigator-simple.min.js'
        'cp knockback-pane-navigator.js packages/nuget/Content/Scripts/knockback-pane-navigator.js'
        'cp knockback-pane-navigator.min.js packages/nuget/Content/Scripts/knockback-pane-navigator.min.js'
        'cp lib/knockback-sample-transitions-jquery.js packages/nuget/Content/Scripts/lib/knockback-sample-transitions-jquery.js'
        'cp lib/knockback-sample-transitions-jquery.min.js packages/nuget/Content/Scripts/lib/knockback-sample-transitions-jquery.min.js'
      ]

  tests:
    _build:
      output: 'build'
      directories: [
        'test/knockback-page-navigator-panes'
        'test/knockback-page-navigator-simple'
        'test/knockback-pane-navigator'
      ]
      commands: [
        'mbundle test/packaging/bundle-config.coffee'
      ]
    _test:
      command: 'phantomjs'
      runner: 'phantomjs-qunit-runner.js'
      files: '**/*.html'
      directories: [
        'test/knockback-page-navigator-panes'
        'test/knockback-page-navigator-simple'
        'test/knockback-pane-navigator'
        'test/packaging'
      ]

  _postinstall:
    commands: [
      # tests
      'cp -v knockback/knockback-core-stack.js test/vendor/knockback-core-stack.js'

      # examples
      'cp -v knockback/knockback-core-stack.js examples/vendor/knockback-core-stack.js'
      'cp -v knockout-client/knockout.debug.js examples/vendor/knockout.js'
      'cp -v backbone examples/vendor/backbone/backbone.js'
      'cp -v underscore examples/vendor/backbone/underscore.js'
    ]