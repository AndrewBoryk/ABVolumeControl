<p align="center">
  <img src="https://github.com/AndrewBoryk/ABVolumeControl/blob/master/ABVolumeControlLogo.png" alt="ABVolumeControl custom logo"/>
</p>

[![Version](https://img.shields.io/cocoapods/v/ABVolumeControl.svg?style=flat)](http://cocoapods.org/pods/ABVolumeControl)
[![License](https://img.shields.io/cocoapods/l/ABVolumeControl.svg?style=flat)](http://cocoapods.org/pods/ABVolumeControl)
[![Platform](https://img.shields.io/cocoapods/p/ABVolumeControl.svg?style=flat)](http://cocoapods.org/pods/ABVolumeControl)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Screenshots

<kbd>
  <img src="https://raw.githubusercontent.com/AndrewBoryk/ABVolumeControl/master/ABVolumeControlScreenshot.gif">
</kbd>

## Description

A custom volume control that replaces MPVolumeView. There are several styles for ABVolumeControl, along with a delegate for creating one's own custom volume slider.

## Requirements

* Requires iOS 8.0 or later
* Requires Automatic Reference Counting (ARC)
* Requires MediaPlayer framework

## Installation

ABVolumeControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ABVolumeControl"
```

## Initialization

ABVolumeControl is initialized by calling 'setVolumeControlStyle:' on the sharedManager for ABVolumeControl. There are several different settings available for the style of an ABVolumeControl. Without setting the style of the control, there will be no visible ABVolumeControl.

```objective-c
// The first style for an ABVolumeControl is minimal, which is a 2px-tall bar that is visible at the top of the screen above the UIStatusBar.
[[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleMinimal];

// Set the ABVolumeControl style to Status Bar style. This syle is similar to the 'minimal' style, with added space between the control and the top of the screen, allowing the control to cover the UIStatusBar. This makes the control more visible.
[[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleStatusBar];

// One can remove the custom ABVolumeControl by setting the volumeControlStyle to ABVolumeControlStyleNone. This would bring back the original MPVolumeView.
[[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleNone];

// Setting the volumeControlStyle to custom ensures that the MPVolumeView is not shown, and no ABVolumeControl appears. There is a delegate available to listen to changes in the user's volume, and communicate changes in a custom volume slider to the rest of the application.
[[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleCustom];
```


***
## Customization

There are settings available for modifying the appearance of an ABVolumeControl, allowing the change of color for the ABVolumeControl easily.

```objective-c
// Changing the theme of the ABVolumeControl allows for easy access to modifying the appearance of the ABVolumeControl depending on it's surroundings (Dark backgrounds vs Light backgrounds)
[[ABVolumeControl sharedManager] setControlTheme: ABVolumeControlDarkTheme];
```

In addition to setting the controlTheme, the accent colors for the dark and light themes can be set individually.

```objective-c
// Changes the accent color associated with the ABVolumeControlDarkTheme theme
[[ABVolumeControl sharedManager] setDefaultDarkColor:[UIColor blueColor]];

// Changes the accent color associated with the ABVolumeControlLightTheme theme
[[ABVolumeControl sharedManager] setDefaultLightColor:[UIColor yellowColor]];
```

The volume of the user's device can be adjusted progamically with the call of the class method 'setVolumeLevel:'.

```objective-c
[ABVolumeControl setVolumeLevel:0.5f];
```

The volume bar can be manually hidden and shown using the 'dontShowVolumebar' and 'showVolumeBar' methods. 'dontShowVolumeBar' hides the ABVolumeControl immediately, and ensures that it won't be shown for 1 second after being called. 'showVolumeBar' displays the ABVolumeControl with animation. There is also a variable 'dontShowVolumeBar' that sets the ABVolumeControl not to show indefinitely.

```objective-c
// Ensures that the ABVolumeControl will not be shown for 1 second time, and hides it immediately
[[ABVolumeControl sharedManager] dontShowVolumeBar];

// Displays the ABVolumeControl with animation
[[ABVolumeControl sharedManager] showVolumeBar];

// Makes sure that the ABVolumeControl will not be displayed until specified otherwise.
[[ABVolumeControl sharedManager] setDontShowVolumeBar: YES];
```


***
## Delegate

When using ABVolumeControlStyleCustom or just looking to monitor the current volume level of the user's device easily, you can use the delegate provided:

```objective-c
// Set delegate for the volume control to be used for custom volume sliders
[[ABVolumeControl sharedManager] setVolumeDelegate:self];
    
// Volume did change in the ABVolumeControl to the value 'volumePercentage' (0.0 - 1.0)
- (void)control:(ABVolumeControl *)control didChangeVolume:(CGFloat)volumePercentage;
```

## Author

andrewboryk, andrewcboryk@gmail.com

Reach out to me on Twitter [![alt text][1.2]][1]

[1.2]: http://i.imgur.com/wWzX9uB.png (twitter icon without padding)
[1]: http://www.twitter.com/trepislife

## License

ABVolumeControl is available under the MIT license. See the LICENSE file for more info.
