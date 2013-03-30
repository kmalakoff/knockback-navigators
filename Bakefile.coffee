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
    ]

  knockback_transitions:
    join: 'knockback-transitions.js'
    wrapper: 'src/knockback-transitions/module-loader.js'
    compress: true
    files: [
      'src/knockback-transitions/component-imports.coffee'
      'src/knockback-transitions/transition-helpers.coffee'
      'src/knockback-transitions/transition-saved-state.coffee'
      'src/knockback-transitions/css-transition-slide-up.coffee'
      'src/knockback-transitions/css-transition-fade-in.coffee'
      'src/knockback-transitions/css-transition-slide.coffee'
      'src/knockback-transitions/fallback-transition-helpers.coffee'
      'src/knockback-transitions/fallback-transition-slide-up.coffee'
      'src/knockback-transitions/fallback-transition-fade-in.coffee'
      'src/knockback-transitions/fallback-transition-slide.coffee'
    ]

  knockback_navigators_css:
    commands: [
      'stylus --use nib --out . src/knockback-transitions/knockback-transitions.styl'
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
        'cp knockback-transitions.js packages/npm/knockback-transitions.js'
        'cp knockback-transitions.min.js packages/npm/knockback-transitions.min.js'
        'cp knockback-transitions.css packages/npm/knockback-transitions.css'

        # nuget
        'cp knockback-navigators.css packages/nuget/Content/Scripts/knockback-navigators.css'
        'cp knockback-page-navigator-panes.js packages/nuget/Content/Scripts/knockback-page-navigator-panes.js'
        'cp knockback-page-navigator-panes.min.js packages/nuget/Content/Scripts/knockback-page-navigator-panes.min.js'
        'cp knockback-page-navigator-simple.js packages/nuget/Content/Scripts/knockback-page-navigator-simple.js'
        'cp knockback-page-navigator-simple.min.js packages/nuget/Content/Scripts/knockback-page-navigator-simple.min.js'
        'cp knockback-pane-navigator.js packages/nuget/Content/Scripts/knockback-pane-navigator.js'
        'cp knockback-pane-navigator.min.js packages/nuget/Content/Scripts/knockback-pane-navigator.min.js'
        'cp knockback-transitions.js packages/nuget/Content/Scripts/knockback-transitions.js'
        'cp knockback-transitions.min.js packages/nuget/Content/Scripts/knockback-transitions.min.js'
        'cp knockback-transitions.css packages/nuget/Content/Scripts/knockback-transitions.css'
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
      'cp -v knockback/knockback-core-stack.js vendor/test/knockback-core-stack.js'

      # examples
      'cp -v knockback/knockback-core-stack.js examples/vendor/knockback-core-stack.js'
      'cp knockout/build/output/knockout-latest.debug.js examples/vendor/knockout-2.2.1.js'
      'cp -v backbone examples/vendor/backbone/backbone.js'
      'cp -v underscore examples/vendor/backbone/underscore.js'

      # amd tests
      'cp -v underscore vendor/test/underscore.js'
      'cp -v backbone vendor/test/backbone.js'
      'cp knockout/build/output/knockout-latest.debug.js vendor/test/knockout-2.2.1.js'
      'cp -v knockback/knockback-core.js vendor/test/knockback-core.js'
    ]