[![Build Status](https://secure.travis-ci.org/kmalakoff/knockback-navigators.png)](http://travis-ci.org/kmalakoff/knockback-navigators)

KnockbackNavigators.js provides page navigators, a pane navigator, and transition animations to help you make dynamic, single-page applications. They are platform-agnostic so you can even use them without using Knockback.js or Knockout.js!

### API Documentation: kmalakoff.github.com/knockback-navigators/api.html

### Examples: kmalakoff.github.com/knockback-navigators/examples.html

### Dependencies

* You will need to provide a DOM manipulation library like [jQuery][10] or [Zepto][11].

kb.PageNavigatorPanes
-----------------------

This component provides a page navigator with history and optional transition animations. If you are using Knockout.js or Knockback.js, you can observe changes to the active page (for example, to update menu links).

#You can get it here:

* [Development version][5]
* [Production version][6]

**Note**: this bundles knockback-pane-navigator.js so no need to include knockback-pane-navigator.js separately.

#Requirements:

* You will need to provide a routing solution like [Backbone.Router][12], [PathJS][13], etc

#Usage

In order to filter loading of page URLs (eg. not reloading the active page if the URL hasn't changed) and to manage history (eg. going back if the previous page matches the URL), kb.PageNavigatorPanes provides a 'dispatcher(callback)' that is only called when a cached page is not available.

###Basic Usage (Static Pages)

If you want to bind  to a static page, you should provide the '{no_detach: true}' option so if only hides, but does not detach elements when a page is deactivated.

BackboneJS:
```
var page_navigator = new kb.PageNavigatorPanes($('#app')[0], {no_detach: true});
var router = new Backbone.Router()
router.route('', null, page_navigator.dispatcher(function(){ page_navigator.loadPage($('#main')[0]); }));
router.route('page1', null, page_navigator.dispatcher(function(){ page_navigator.loadPage($('#page1')[0]); }));
router.route('page2', null, page_navigator.dispatcher(function(){ page_navigator.loadPage($('#page2')[0]); }));
Backbone.history.start({hashChange: true});
```

PathJS:
```
var page_navigator = new kb.PageNavigatorPanes($('#app')[0], {no_detach: true});
Path.map('').to(page_navigator.dispatcher(function(){ page_navigator.loadPage($('#main')[0]); }));
Path.map('#page1').to(page_navigator.dispatcher(function(){ page_navigator.loadPage($('#page1')[0]); }));
Path.map('#page2').to(page_navigator.dispatcher(function(){ page_navigator.loadPage($('#page2')[0]); }));
Path.listen();
Path.dispatch(window.location.hash);
```

###Dynamic Pages using Knockback.js

You can dynamic pages either by hand or using Knockback.js's 'kb.renderAutoReleasedTemplate(template_name, view_model, options)' function.

```
...
router.route('', null, page_navigator.dispatcher(function(){
  page_navigator.loadPage( kb.renderAutoReleasedTemplate('page', new PageViewModel(pages.get('main'))) );
}));
...
```

You can also force pages to unload when they are not active, but supplying a 'create' function rather than an element.

```
...
router.route('', null, page_navigator.dispatcher(function(){
  create: function() { return kb.renderAutoReleasedTemplate('page', new PageViewModel(pages.get('page1'))) }
}));
...
```

#Adding Transition Animations

You can provide transition animations either during routing (assymetic reverse transitions will not work if the page can be reloaded) or during button clicks.

Transitions during routing:

```
...
router.route('', null, page_navigator.dispatcher(function(){
  page_navigator.loadPage({
    el: kb.renderAutoReleasedTemplate('page', new PageViewModel(pages.get('main'))),
    transition: 'FadeIn'
  });
}));
...
```

With buttons (HTML):

```
<button class='btn btn-small' onclick="kb.loadUrl('#page1', {name: 'NavigationSlide', inverse: true})"> Back</button>
```

With buttons (Knockout):

```
<button class='btn btn-small' data-bind="click: function(){ kb.loadUrl('#page1', {name: 'NavigationSlide', inverse: true}) }"><span> Back</span></button>
```

#Embedding using Knockout.js bindings:

If you are using KnockoutJS or KnockbackJS, you can actually bind a page navigator in the HTML using 'ko.bindings' and receive a callback to set up routing.

```
<div data-bind="PageNavigatorPanes: {loaded: loaded}"></div>

ko.applyBindings({
  loaded: function(page_navigator) {
    var router = new Backbone.Router()
    router.route('', null, page_navigator.dispatcher(function(){ page_navigator.loadPage($('#main')[0]); }));
    router.route('page1', null, page_navigator.dispatcher(function(){ page_navigator.loadPage($('#page1')[0]); }));
    router.route('page2', null, page_navigator.dispatcher(function(){ page_navigator.loadPage($('#page2')[0]); }));
  }
});
Backbone.history.start({hashChange: true});
```

kb.PageNavigatorSimple
-----------------------

This component provides a page navigator with no history and no transitions. In addition to adding a little structure to your application, if you are using Knockout.js or Knockback.js, you can observe changes to the active page (for example, to update menu links).

#You can get it here:

* [Development version][3]
* [Production version][4]

#Requirements:

* You will need to provide a routing solution like [Backbone.Router][12], [PathJS][13], etc

#Usage

The usage is similar to kb.PageNavigatorSimple except you cannot supply transition animations and create functions (there is no history).


kb.PaneNavigator
-----------------------

This component provides a way to embed moveable panes within you HTML (for example, sliding between items one at a time) with or without transition animations and provides the page transition functionality to kb.PageNavigatorPanes.

#You can get it here:

* [Development version][1]
* [Production version][2]

#Usage

You can manually bind a pane-navigator:

```
<div class='pane-navigator'>
  <div class='pane cell'>
    <p>Pane1</p>
  </div>
  <div class='pane cell'>
    <p>Pane2</p>
  </div>
  <div class='pane cell'>
    <p>Pane3</p>
  </div>
</div>

var pane_navigator_el = $('.pane-navigator')[0];
var pane_navigator = new kb.PaneNavigator(pane_navigator_el, {no_detach: true, transition: 'NavigationSlide'});
kb.utils.wrappedPaneNavigator(pane_navigator_el, pane_navigator);
pane_navigator.push(new kb.Pane(pane_navigator_el.children[0]));
```

#Optional Knockout.js bindings:

```
<div class='pane-navigator' data-bind="PaneNavigator: {transition: 'NavigationSlide'}">
  <div class='pane cell'>
    <p>Pane1</p>
  </div>
  <div class='pane cell'>
    <p>Pane2</p>
  </div>
  <div class='pane cell'>
    <p>Pane3</p>
  </div>
</div>

ko.applyBindings({});
```

Transition Animations
-----------------------

If you would like to have great transition animations between your panes or pages, you need to expose add them to the kb.transitions object.

```
# info [Object] provides the following properties: container_el, to_el, from_el
# options [Object] along with your custom options, it provides the following properties: forward
kb.transitions['YourTransition'] = function(info, options) {
};
```

You can use kb.TransitionSavedState to store and restore element classes and css classes before and after your animation.

```
// save to_el and container_el element classes and css 'min-height' and 'overflow' properties.
state = new kb.TransitionSavedState(info, {to_el: ['min-height'], container_el: ['overflow']});

// DO STUFF: update the min-height, overflow, and any element classes

// all saved state will be restored when fadeIn is done
$(info.to_el).hide().fadeIn(500, state.callback);
```

#There are some sample animations here, but they are only for reference:

* [Development version][7]

If you have some production quality transitions that you'd like to submit to the library, please [let me know](http://kmalakoff.github.com/knockback/issues).

Note on Lifecycle Management
-----------------------

# Releasing View Models
KnockbackNavigators.js uses an implicit memory management model based on Knockback.js conventions (based on Knockout.js functionality). When an element is created, Knockback binds Knockout's dispose node callback:

```
// binds a callback to the node that releases the view model when the node is removed using ko.removeNode
ko.utils.domNodeDisposal.addDisposeCallback(node, function() { kb.release(view_model)} );
```

There are three ways to do this in Knockback:

```
// Auto-released Template
var el = kb.renderAutoReleasedTemplate('template_name', view_model, options);

// OR: When applying bindings
kb.applyBindings(view_model, el);

// OR: Manually
kb.releaseOnNodeRemove(view_model, el);
```

# Notifications
KnockbackNavigators.js provides hooks to receive notifications when an element is activated and deactivated so you can have fine-grained control (for example, to stop background page processing) when your element is detached ($(el).detach()) rather than removed (ko.removeNode(el)). It uses two conventions to provide the notifications:

```
// created manually or through page_navigator.loadPaga({el: el, view_model: view_model})
var pane = kb.Pane({el: el, view_model: view_model});
...
pane.view_model.activate(el);

// created manually or through page_navigator.loadPaga({el: el, view_model: view_model})
var pane = kb.Pane({el: el});
...
var view_model = ko.dataFor(pane.el); // get the ViewModel from the bound element
view_model.activate(el);
```

# Not Using Knockback.js or Knockout.js
If you do not use Knockback.js or Knockout.js, you may want to provide custom memory management hooks instead of these defaults:

```
ko.dataFor = function(el) { return null; };
ko.removeNode = function(el) { $(el).remove(); };
```

For example:

```
ko.dataFor = function(el) { return {activate: function(el) { /* do something with el */ }}; };
```

Building, Running and Testing the library
-----------------------

###Installing:

1. install node.js: http://nodejs.org
2. install node packages: 'npm install'

###Commands:

Look at: https://github.com/kmalakoff/easy-bake

[1]: https://raw.github.com/kmalakoff/knockback-navigators/0.1.0/knockback-pane-navigator.js
[2]: https://raw.github.com/kmalakoff/knockback-navigators/0.1.0/knockback-pane-navigator.min.js
[3]: https://raw.github.com/kmalakoff/knockback-navigators/0.1.0/knockback-page-navigator-panes.js
[4]: https://raw.github.com/kmalakoff/knockback-navigators/0.1.0/knockback-page-navigator-panes.min.js
[5]: https://raw.github.com/kmalakoff/knockback-navigators/0.1.0/knockback-page-navigator-simple.js
[6]: https://raw.github.com/kmalakoff/knockback-navigators/0.1.0/knockback-page-navigator-simple.min.js
[7]: https://raw.github.com/kmalakoff/knockback-navigators/0.1.0/knockback-sample-transitions.js

[10]: http://jquery.com/
[11]: http://zepto.com/
[12]: http://backbonejs.org/
[13]: http://pathjs.com/
