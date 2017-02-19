//
//  ABViewController.m
//  ABVolumeControl
//
//  Created by andrewboryk on 02/10/2017.
//  Copyright (c) 2017 andrewboryk. All rights reserved.
//

#import "ABViewController.h"
#import <ABVolumeControl/ABVolumeControl.h>

@interface ABViewController () <ABVolumeControlDelegate>

@end

@implementation ABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self themeSwitchChanged:nil];
        
    [[ABVolumeControl sharedManager] hideVolumeControl];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Intialize the ABVolumeControl with a style, without setting the style, there will be no visible ABVolumeControl. The first style for an ABVolumeControl is minimal, which is a 2px-tall bar that is visible at the top of the screen above the UIStatusBar.
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleMinimal];
    
    // Changing the theme of the ABVolumeControl allows for easy access to modifying the appearance of the ABVolumeControl depending on it's surroundings (Dark backgrounds vs Light backgrounds)
    [[ABVolumeControl sharedManager] setControlTheme: ABVolumeControlDarkTheme];
    
    // In addition to setting the controlTheme, the accent colors for the dark and light themes can be set individually
    
    // Changes the accent color associated with the ABVolumeControlDarkTheme theme
    [[ABVolumeControl sharedManager] setDefaultDarkColor:[self colorWithHexString:@"3498DB"]];
    
    // Changes the accent color associated with the ABVolumeControlLightTheme theme
    [[ABVolumeControl sharedManager] setDefaultLightColor:[self colorWithHexString:@"FCFCFC"]];
    
    // Set delegate for the volume control to be used for custom volume sliders
    [[ABVolumeControl sharedManager] setVolumeDelegate:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeThemeAction:(id)sender {
    if ([[ABVolumeControl sharedManager] controlTheme] == ABVolumeControlDarkTheme) {
        [[ABVolumeControl sharedManager] setControlTheme:ABVolumeControlLightTheme];
        [self.changeThemeButton setTitle:@"Set Dark Theme" forState:UIControlStateNormal];
    }
    else if ([[ABVolumeControl sharedManager] controlTheme] == ABVolumeControlLightTheme) {
        [[ABVolumeControl sharedManager] setControlTheme:ABVolumeControlDarkTheme];
        [self.changeThemeButton setTitle:@"Set Light Theme" forState:UIControlStateNormal];
    }
    
    [[ABVolumeControl sharedManager] showVolumeControl];
}

- (IBAction)removeStyleAction:(id)sender {
    // One can remove the custom ABVolumeControl by setting the volumeControlStyle to ABVolumeControlStyleNone.
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleNone];
    
    self.customVolumeSlider.hidden = YES;
    self.customStyleButton.hidden = NO;
}

- (IBAction)minimalStyleAction:(id)sender {
    // Custom Dark theme
    [[ABVolumeControl sharedManager] setDefaultDarkColor:[self colorWithHexString:@"3498DB"]];
    
    // Custom Light theme
    [[ABVolumeControl sharedManager] setDefaultLightColor:[self colorWithHexString:@"FCFCFC"]];
    
    // Set the ABVolumeControl style to Minimal
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleMinimal];
    
    self.customVolumeSlider.hidden = YES;
    self.customStyleButton.hidden = NO;
    
    [[ABVolumeControl sharedManager] showVolumeControl];
}

- (IBAction)statusBarStyleAction:(id)sender {
    // Custom Dark theme
    [[ABVolumeControl sharedManager] setDefaultDarkColor:[self colorWithHexString:@"333333"]];
    
    // Custom Light theme
    [[ABVolumeControl sharedManager] setDefaultLightColor:[self colorWithHexString:@"FCFCFC"]];
    
    // Set the ABVolumeControl style to Status Bar style. This style is similar to the 'minimal' style, with added space between the control and the top of the screen, allowing the control to cover the UIStatusBar. This makes the control more visible.
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleStatusBar];
    
    self.customVolumeSlider.hidden = YES;
    self.customStyleButton.hidden = NO;
    
    [[ABVolumeControl sharedManager] showVolumeControl];
}

- (void) fakeVolumeChange {
    // Only used to create demo video
    [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.30f];
    
    [NSTimer scheduledTimerWithTimeInterval:0.25f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.45f];
        
        [NSTimer scheduledTimerWithTimeInterval:0.25f repeats:NO block:^(NSTimer * _Nonnull timer) {
            [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.60f];
            
            [NSTimer scheduledTimerWithTimeInterval:0.25f repeats:NO block:^(NSTimer * _Nonnull timer) {
                [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.75f];
                
                [NSTimer scheduledTimerWithTimeInterval:0.25f repeats:NO block:^(NSTimer * _Nonnull timer) {
                    [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.6f];
                    
                    [NSTimer scheduledTimerWithTimeInterval:0.25f repeats:NO block:^(NSTimer * _Nonnull timer) {
                        [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.45f];
                        
                        [NSTimer scheduledTimerWithTimeInterval:0.25f repeats:NO block:^(NSTimer * _Nonnull timer) {
                            [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.3f];
                            
                            [NSTimer scheduledTimerWithTimeInterval:0.25f repeats:NO block:^(NSTimer * _Nonnull timer) {
                                [[ABVolumeControl sharedManager] updateControlForVolumeChange:0.15f];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];
}

- (IBAction)customStyleAction:(id)sender {
    // Setting the volumeControlStyle to custom ensures that the MPVolumeView is not shown, and no ABVolumeControl appears. There is a delegate available to listen to changes in the user's volume, and communicate changes in a custom volume slider to the rest of the application.
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleCustom];
    
    self.customStyleButton.hidden = YES;
    self.customVolumeSlider.hidden = NO;
    
}

- (IBAction)customVolumeSliderChanged:(id)sender {
    [[ABVolumeControl sharedManager] setVolumeLevel:self.customVolumeSlider.value];
}

- (IBAction)themeSwitchChanged:(id)sender {
    if (self.themeSwitch.selectedSegmentIndex == 0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        self.navigationController.navigationBar.backgroundColor = [self colorWithHexString:@"000000"];
        self.navigationController.navigationBar.barTintColor = [self colorWithHexString:@"000000"];
    }
    else if (self.themeSwitch.selectedSegmentIndex == 1) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        self.navigationController.navigationBar.backgroundColor = [self colorWithHexString:@"FCFCFC"];
        self.navigationController.navigationBar.barTintColor = [self colorWithHexString:@"FCFCFC"];
    }
    
    [[ABVolumeControl sharedManager] showVolumeControl];
}

#pragma mark - ABVolumeControlDelegate methods
- (void) control:(ABVolumeControl *)control didChangeVolume:(CGFloat)volumePercentage {
    [self.customVolumeSlider setValue:volumePercentage];
}

- (void) controlWillPresent:(ABVolumeControl *)control {
    NSLog(@"Control will present");
}

- (void) controlDidPresent:(ABVolumeControl *)control {
    NSLog(@"Control did present");
}

- (void) controlWillDismiss:(ABVolumeControl *)control {
    NSLog(@"Control will dismiss");
}

- (void) controlDidDismiss:(ABVolumeControl *)control {
    NSLog(@"Control did dismiss");
}

#pragma mark - Helper Methods
- (UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [hex uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
