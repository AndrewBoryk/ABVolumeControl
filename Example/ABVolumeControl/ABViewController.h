//
//  ABViewController.h
//  ABVolumeControl
//
//  Created by andrewboryk on 02/10/2017.
//  Copyright (c) 2017 andrewboryk. All rights reserved.
//

@import UIKit;

@interface ABViewController : UIViewController

/// Button to change themes
@property (strong, nonatomic) IBOutlet UIButton *changeThemeButton;

/// Button to set volumeControl style to ABVolumeControlStyleMinimal
@property (strong, nonatomic) IBOutlet UIButton *minimalStyleButton;

/// Button to set volumeControl style to ABVolumeControlStyleStatusBar
@property (strong, nonatomic) IBOutlet UIButton *statusBarStyleButton;

/// Switch to adjust theme
@property (strong, nonatomic) IBOutlet UISegmentedControl *themeSwitch;

/// Change the theme between dark and light
- (IBAction)changeThemeAction:(id)sender;

/// Set volumeControl style to ABVolumeControlStyleMinimal
- (IBAction)minimalStyleAction:(id)sender;

/// Set volumeControl style to ABVolumeControlStyleStatusBar
- (IBAction)statusBarStyleAction:(id)sender;

/// Switched themes for ABVolumeControl
- (IBAction)themeSwitchChanged:(id)sender;

@end
