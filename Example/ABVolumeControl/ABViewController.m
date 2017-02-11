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
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [[ABVolumeControl sharedManager] showVolumeBar];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeThemeAction:(id)sender {
    if ([[ABVolumeControl sharedManager] controlTheme] == ABVolumeControlDarkTheme) {
        [[ABVolumeControl sharedManager] setControlTheme:ABVolumeControlLightTheme];
        self.view.backgroundColor = [UIColor blackColor];
        [self.changeThemeButton setTitle:@"Set Dark Theme" forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
    else if ([[ABVolumeControl sharedManager] controlTheme] == ABVolumeControlLightTheme) {
        [[ABVolumeControl sharedManager] setControlTheme:ABVolumeControlDarkTheme];
        self.view.backgroundColor = [UIColor whiteColor];
        [self.changeThemeButton setTitle:@"Set Light Theme" forState:UIControlStateNormal];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
}
@end
