//
//  ABViewController.m
//  ABVolumeControl
//
//  Created by andrewboryk on 02/10/2017.
//  Copyright (c) 2017 andrewboryk. All rights reserved.
//

#import "ABViewController.h"
#import <ABVolumeControl/ABVolumeControl.h>

@interface ABViewController ()

@end

@implementation ABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Intialize the ABVolumeControl with a style, without setting the style, there will be no visible ABVolumeControl. In addition, one can remove the custom ABVolumeControl by setting the volumeControlStyle to ABVolumeControlStyleNone.
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleNone];
    
    // The first style for an ABVolumeControl is minimal, which is a 2px-tall bar that is visible at the top of the screen above the UIStatusBar.
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleMinimal];
    
    // Theme can be set for the ABVolumeControl, with dark and light options.
    [[ABVolumeControl sharedManager] setControlTheme: ABVolumeControlDarkTheme];
    
    // In addition to setting the controlTheme, the accent colors for the dark and light themes can be set individually
    
    // Custom Dark theme
    [[ABVolumeControl sharedManager] setDefaultDarkColor:[self colorWithHexString:@"E74C3C"]];
    
    // Custom Light theme
    [[ABVolumeControl sharedManager] setDefaultLightColor:[self colorWithHexString:@"FCFCFC"]];
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
    
}

- (IBAction)minimalStyleAction:(id)sender {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleMinimal];
    self.view.backgroundColor = [self colorWithHexString:@"111111"];
    
    [self.changeThemeButton setTitleColor:[self colorWithHexString:@"FCFCFC"] forState:UIControlStateNormal];
    [self.minimalStyleButton setTitleColor:[self colorWithHexString:@"FCFCFC"] forState:UIControlStateNormal];
    [self.statusBarStyleButton setTitleColor:[self colorWithHexString:@"FCFCFC"] forState:UIControlStateNormal];
    
}

- (IBAction)statusBarStyleAction:(id)sender {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    [[ABVolumeControl sharedManager] setVolumeControlStyle:ABVolumeControlStyleStatusBar];
    self.view.backgroundColor = [self colorWithHexString:@"FCFCFC"];
    
    [self.changeThemeButton setTitleColor:[self colorWithHexString:@"111111"] forState:UIControlStateNormal];
    [self.minimalStyleButton setTitleColor:[self colorWithHexString:@"111111"] forState:UIControlStateNormal];
    [self.statusBarStyleButton setTitleColor:[self colorWithHexString:@"111111"] forState:UIControlStateNormal];
    
}

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
