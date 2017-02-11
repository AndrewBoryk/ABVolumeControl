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

@end
