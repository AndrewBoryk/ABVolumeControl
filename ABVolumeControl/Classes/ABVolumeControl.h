//
//  ABVolumeControl.h
//  Pods
//
//  Created by Andrew Boryk on 2/11/17.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>

@interface ABVolumeControl : NSObject

/// Determines whether volume bar should be shown
@property BOOL dontShowVolumeBar;

/// Background for volume bar
@property (strong, nonatomic) UIView *volumeBackground;

/// Bar which shows volume level
@property (strong, nonatomic) UIView *volumeBar;

/// View which handles volume change
@property (strong, nonatomic) MPVolumeView *mpVolumeView;

/// Slider which records the user's volume level
@property (strong, nonatomic) UISlider *volumeSlider;

// Timer that when selector is performed, hides volumeBar
@property (strong, nonatomic) NSTimer *volumeTimer;

/// Shared Manager for Volume Manager
+ (id)sharedManager;

/// Hides volume bar for 2.5 seconds
- (void) dontShowVolumebar;

/// Shows volume bar
- (void) showVolumeBar;

/// Updates color for volumebar
- (void) updateVolumeBarColor;

@end
