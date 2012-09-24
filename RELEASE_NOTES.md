Please refer to the following release notes when upgrading your version of Knockback-Navigators.js.

## 0.1.2

* introduced css optimized transitions - now the transitions module is knockback-transitions instead of knockback-sample-transitions. Removed optoins from animations -> should all be possible to set using css classes.
* made pane navigator check for DOM changes using setInterval to ensure an active element is always present.
* introduced css transitions and renamed sample-transtions-jquery to default-transitions
* made TransitionSavedState internal to pane navigators and automatically save and restore
* renamed transition animations: CoverVertical -> SlideUp and NavigationSlide -> Slide

## 0.1.1

* added AMD loader to all components.
* updated kb.loadUrl and added kb.loadUrlFn so they can be called directly from an HTML View
* renamed knockback-sample-transitions to knockback-transitions
* XUI bug fixed: reverse on panes and appending source code

## 0.1.0

* initial release