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

There are settings available for modifying the appearance of 

```objective-c
// Changing the theme of the ABVolumeControl allows for easy access to modifying the appearance of the ABVolumeControl depending on it's surroundings (Dark backgrounds vs Light backgrounds)
[[ABVolumeControl sharedManager] setControlTheme: ABVolumeControlDarkTheme];
```

In addition to setting the controlTheme, the accent colors for the dark and light themes can be set individually

```objective-c
// Changes the accent color associated with the ABVolumeControlDarkTheme theme
[[ABVolumeControl sharedManager] setDefaultDarkColor:[UIColor blueColor]];

// Changes the accent color associated with the ABVolumeControlLightTheme theme
[[ABVolumeControl sharedManager] setDefaultLightColor:[UIColor yellowColor]];
```

***
## Delegate


## Author

andrewboryk, andrewcboryk@gmail.com

## License

ABVolumeControl is available under the MIT license. See the LICENSE file for more info.
