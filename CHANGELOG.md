##v0.1.1 (2/19/17)
####Added:
* Delegate methods for knowing when ABVolumeControl of stype Minimal and StatusBar will/did present and dismiss.

####Fixed:
* Issue where ABVolumeControl was sometimes not displayed over other subviews in the key UIWindow.

####Updated:
* The following functions and variable were renamed for clarity, and still have the purpose:
  * Function 'doneShowVolumeBar' was renamed to 'hideVolumeControl'
  * Function 'showVolumeBar' was renamed to 'showVolumeControl'
  * Variable 'doneShowVolumeBar' was renamed to 'volumeBarHidden'

##v0.1.0 (2/11/17)

***Hello World!***  
This is the first version released for ABVolumeControl, on 2/11/17. Get a load of all the features that were included in this release:

* Styles! Multiple styles are available for use with ABVolumeControl, which allow for the control to be disabled, enabled, or hidden and used for its delegate.  Simply call 'setControlStyle' on ABVolumeControl's sharedManager.
  * ABVolumeControlStyleMinimal: Displays a volume bar above the UIStatusBar, 2px in height.
  * ABVolumeControlStyleStatusBar: Similar to the 'minimal' style, with added space between the control and the top of the screen, allowing the control to cover the UIStatusBar. This makes the control more visible.
  * ABVolumeControlStyleNone: This style removes the ABVolumeControl from appearing and returns the Apple provided MPVolumeView.
  * ABVolumeControlStyleCustom: Does not display an ABVolumeControl or MPVolumeView. Instead, this style allows the developer to utilize the delegate methods of ABVolumeControl to make their own custom volumeView.
* 'setControlTheme' on the ABVolumeView sharedManager to switch between two themes: Light and Dark.
* Options for customizing the Light and Dark themes, by changing the accent color defaults for the themes.
* 'setVolumeLevel' on the ABVolumeView sharedManager to set the volume of the user's device programmatically. Pairs nicely with using custom volumeSliders.
* Functions for managing ABVolumeControls hidden state.
  * 'dontShowVolumeBar': Makes sure that the volumeView is not shown for 1 second.
  * 'showVolumeBar': Shows the volumeView immediately.
  * 'setDontShowVolumeBar': Ensures that the volumeView won't be shown indefinitely, until specified otherwise.
* Delegate method 'control:didChangeVolume:' which is called when volume of the user's device is changed, and can be used for setting up one's own custom volumeView.

Tweet at me with future feature suggestions! [@TrepIsLife](https://www.twitter.com/TrepIsLife)

<kbd>
  <img src="https://cloud.githubusercontent.com/assets/5210967/23099393/97e89d66-f633-11e6-9937-519a1a704289.gif">
</kbd>
