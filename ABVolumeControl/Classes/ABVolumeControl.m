//
//  ABVolumeControl.m
//  Pods
//
//  Created by Andrew Boryk on 2/11/17.
//
//

#import "ABVolumeControl.h"

@implementation ABVolumeControl

+ (id)sharedManager {
    static ABVolumeControl *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        // Initialize caches
        
        self.mpVolumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-50, -50, 0, 0)];
        
        [[self.mpVolumeView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UISlider class]]) {
                self.volumeSlider = obj;
                *stop = YES;
            }
        }];
        
        // Notification when volume is changed
        [self.volumeSlider addTarget:self action:@selector(handleVolumeChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return self;
}

- (void) setVolumeControlStyle:(ABVolumeControlStyle)volumeControlStyle {
    _volumeControlStyle = volumeControlStyle;
    
    if ([self notNull:self.volumeBar]) {
        self.volumeBar.window.windowLevel = UIWindowLevelStatusBar-1;
        [self.volumeBar removeFromSuperview];
        self.volumeBar = nil;
    }
    
    if ([self notNull:self.volumeBackground]) {
        self.volumeBackground.window.windowLevel = UIWindowLevelStatusBar-1;
        [self.volumeBackground removeFromSuperview];
        self.volumeBackground = nil;
    }
    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow makeKeyAndVisible];
    CGRect windowFrame = currentWindow.bounds;
    CGFloat viewWidth = windowFrame.size.width;
    
    if (volumeControlStyle == ABVolumeControlStyleMinimal) {
        
        // Initialize volumeBackground
        self.volumeBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 2)];
        self.volumeBackground.backgroundColor = [self colorWithHexString:@"d4d4d4"];
        self.volumeBackground.alpha = 0;
        
        // Initialize volumeBar
        self.volumeBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        self.volumeBar.clipsToBounds = NO;
        self.volumeBar.layer.masksToBounds = NO;
        self.volumeBar.alpha = 0;
        
        // Set default theme
        [self updateVolumeBarColor];
        
        // Add views to currentWindow
        [currentWindow addSubview:self.volumeBackground];
        [currentWindow addSubview:self.volumeBar];
        
        if ([self notNull: self.mpVolumeView] && [self notNull: currentWindow]) {
            if (![currentWindow.subviews containsObject:self.mpVolumeView]) {
                [currentWindow addSubview:self.mpVolumeView];
            }
        }
    }
    else if (volumeControlStyle == ABVolumeControlStyleStatusBar) {
        // Initialize volumeBackground
        self.volumeBackground = [[UIView alloc] initWithFrame:CGRectMake(12.0f, -9.0f, viewWidth-24.0f, 2.0f)];
        self.volumeBackground.backgroundColor = [self colorWithHexString:@"d4d4d4"];
        self.volumeBackground.alpha = 1.0f;
        
        // Initialize volumeBar
        self.volumeBar = [[UIView alloc] initWithFrame:CGRectMake(12.0f, -9.0f, viewWidth-24.0f, 2.0f)];
        self.volumeBar.clipsToBounds = NO;
        self.volumeBar.layer.masksToBounds = NO;
        self.volumeBar.alpha = 1.0f;
        
        // Set default theme
        [self updateVolumeBarColor];
        
        // Add views to currentWindow
        [currentWindow addSubview:self.volumeBackground];
        [currentWindow addSubview:self.volumeBar];
        
        if ([self notNull: self.mpVolumeView] && [self notNull: currentWindow]) {
            if (![currentWindow.subviews containsObject:self.mpVolumeView]) {
                [currentWindow addSubview:self.mpVolumeView];
            }
        }
    }
    else if (volumeControlStyle == ABVolumeControlStyleNone) {
        if ([self notNull:self.mpVolumeView]) {
            [self.mpVolumeView removeFromSuperview];
        }
    }
    else if (volumeControlStyle == ABVolumeControlStyleCustom) {
        if ([self notNull: self.mpVolumeView] && [self notNull: currentWindow]) {
            if (![currentWindow.subviews containsObject:self.mpVolumeView]) {
                [currentWindow addSubview:self.mpVolumeView];
            }
        }
    }

    if ([self notNull:self.volumeBackground]) {
        [self.volumeBackground.superview bringSubviewToFront:self.volumeBackground];
    }
    
    if ([self notNull:self.volumeBar]) {
        [self.volumeBar.superview bringSubviewToFront:self.volumeBar];
    }
}

- (void)handleVolumeChanged:(id)sender
{
    // Volume changed, show volumeBar
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [mainWindow makeKeyAndVisible];
    
    if ([self notNull:mainWindow]) {
        if ([self notNull: self.volumeBar] && [self notNull:self.volumeBackground]) {
            if ([mainWindow.subviews containsObject:self.volumeBar] && [mainWindow.subviews containsObject: self.volumeBackground]) {
                [self updateControlForVolumeChange:self.volumeSlider.value];
            }
            else {
                [self setVolumeControlStyle:self.volumeControlStyle];
            }
        }
        else {
            [self setVolumeControlStyle:self.volumeControlStyle];
        }
    }
    
    if ([self.volumeDelegate respondsToSelector:@selector(control:didChangeVolume:)]) {
        [self.volumeDelegate control:self didChangeVolume:self.volumeSlider.value];
    }
}

- (void) updateControlForVolumeChange:(float)value {
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [mainWindow makeKeyAndVisible];
    CGRect windowFrame = mainWindow.bounds;
    CGFloat viewWidth = windowFrame.size.width;
    
    if (self.volumeControlStyle == ABVolumeControlStyleMinimal) {
        
        self.volumeBackground.frame = CGRectMake(0, 0, viewWidth, 2);
        
        CGRect volumeBarFrame = self.volumeBar.frame;
        
        CGFloat newWidth = value * viewWidth;
        volumeBarFrame.size = CGSizeMake(newWidth, 2);
        
        [self updateVolumeBarColor];
        
        if (!self.volumeControlHidden) {
            if ([self.volumeDelegate respondsToSelector:@selector(controlWillPresent:)]) {
                [self.volumeDelegate controlWillPresent:self];
            }
            
            [UIView animateWithDuration:0.35f animations:^{
                self.volumeBar.frame = volumeBarFrame;
                self.volumeBar.alpha = 0.75f;
                self.volumeBackground.alpha = 1.0f;
                
            } completion:^(BOOL finished) {
                if ([self.volumeDelegate respondsToSelector:@selector(controlDidPresent:)]) {
                    [self.volumeDelegate controlDidPresent:self];
                }
            }];
            
            [self.volumeTimer invalidate];
            self.volumeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(volumeDone) userInfo:nil repeats:NO];
        }
        else {
            
            self.volumeBar.alpha = 0;
            self.volumeBackground.alpha = 0;
            self.volumeBar.frame = volumeBarFrame;
        }
    }
    else if (self.volumeControlStyle == ABVolumeControlStyleStatusBar) {
        
        self.volumeBackground.frame = CGRectMake(12.0f, self.volumeBackground.frame.origin.y, viewWidth-24.0f, 2.0f);
        
        CGRect volumeBarFrame = self.volumeBar.frame;
        CGRect volumeBackgroundFrame = self.volumeBackground.frame;
        
        CGFloat newWidth = value * (viewWidth - 24.0f);
        
        volumeBarFrame.size = CGSizeMake(newWidth, 2.0f);
        
        self.volumeBar.alpha = 1.0f;
        self.volumeBackground.alpha = 1.0f;
        
        [self updateVolumeBarColor];
        
        if (!self.volumeControlHidden) {
            volumeBarFrame.origin = CGPointMake(12.0f, 9.0f);
            volumeBackgroundFrame.origin = CGPointMake(12.0f, 9.0f);
            
            if ([self.volumeDelegate respondsToSelector:@selector(controlWillPresent:)]) {
                [self.volumeDelegate controlWillPresent:self];
            }
            
            [UIView animateWithDuration:0.15f animations:^{
                self.volumeBar.frame = volumeBarFrame;
                self.volumeBackground.frame = volumeBackgroundFrame;
                self.volumeBar.window.windowLevel = UIWindowLevelStatusBar;
                self.volumeBackground.window.windowLevel = UIWindowLevelStatusBar;
                
            } completion:^(BOOL finished) {
                if ([self.volumeDelegate respondsToSelector:@selector(controlDidPresent:)]) {
                    [self.volumeDelegate controlDidPresent:self];
                }
            }];
            
            [self.volumeTimer invalidate];
            self.volumeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(volumeDone) userInfo:nil repeats:NO];
        }
        else {
            volumeBarFrame.origin = CGPointMake(12.0f, -9.0f);
            volumeBackgroundFrame.origin = CGPointMake(12.0f, -9.0f);
            
            self.volumeBar.frame = volumeBarFrame;
            self.volumeBackground.frame = volumeBackgroundFrame;
        }
    }
    
    if ([self notNull:self.volumeBackground]) {
        [self.volumeBackground.superview bringSubviewToFront:self.volumeBackground];
    }
    
    if ([self notNull:self.volumeBar]) {
        [self.volumeBar.superview bringSubviewToFront:self.volumeBar];
    }
}

- (void) hideVolumeControl {
    if ([self.volumeDelegate respondsToSelector:@selector(controlWillDismiss:)]) {
        [self.volumeDelegate controlWillDismiss:self];
    }
    
    self.volumeBar.alpha = 0;
    self.volumeBackground.alpha = 0;
    self.volumeControlHidden = true;
    
    if ([self.volumeDelegate respondsToSelector:@selector(controlDidDismiss:)]) {
        [self.volumeDelegate controlDidDismiss:self];
    }
    
    [self performSelector:@selector(showVolumeBar) withObject:nil afterDelay:1.0f];
}

- (void) showVolumeControl {
    self.volumeControlHidden = false;
    [self handleVolumeChanged:self.volumeSlider];
}

- (void) showVolumeBar {
    self.volumeControlHidden = false;
}

- (void) volumeDone {
    // Hide volumeBar after animation
    if (self.volumeControlStyle == ABVolumeControlStyleMinimal) {
        if ([self.volumeDelegate respondsToSelector:@selector(controlWillDismiss:)]) {
            [self.volumeDelegate controlWillDismiss:self];
        }
        
        [UIView animateWithDuration:0.35f animations:^{
            self.volumeBar.alpha = 0;
            self.volumeBackground.alpha = 0;
        } completion:^(BOOL finished) {
            if ([self.volumeDelegate respondsToSelector:@selector(controlDidDismiss:)]) {
                [self.volumeDelegate controlDidDismiss:self];
            }
        }];
    }
    else if (self.volumeControlStyle == ABVolumeControlStyleStatusBar) {
        CGRect volumeBarFrame = self.volumeBar.frame;
        CGRect volumeBackgroundFrame = self.volumeBackground.frame;
        
        volumeBarFrame.origin = CGPointMake(12.0f, -9.0f);
        volumeBackgroundFrame.origin = CGPointMake(12.0f, -9.0f);
        
        if ([self.volumeDelegate respondsToSelector:@selector(controlWillDismiss:)]) {
            [self.volumeDelegate controlWillDismiss:self];
        }
        
        [UIView animateWithDuration:0.15f animations:^{
            self.volumeBar.frame = volumeBarFrame;
            self.volumeBackground.frame = volumeBackgroundFrame;
            self.volumeBar.window.windowLevel = UIWindowLevelStatusBar-1;
            self.volumeBackground.window.windowLevel = UIWindowLevelStatusBar-1;
            
        } completion:^(BOOL finished) {
            if ([self.volumeDelegate respondsToSelector:@selector(controlDidDismiss:)]) {
                [self.volumeDelegate controlDidDismiss:self];
            }
        }];
    }
}

- (void) updateVolumeBarColor {
    if (self.controlTheme == ABVolumeControlLightTheme) {
        self.volumeBar.backgroundColor = [self lightColor];
        self.volumeBackground.backgroundColor = [UIColor darkGrayColor];
    }
    else if (self.controlTheme == ABVolumeControlDarkTheme) {
        self.volumeBar.backgroundColor = [self darkColor];
        self.volumeBackground.backgroundColor = [self colorWithHexString:@"d4d4d4"];
    }
    
    if ([self notNull:self.volumeBar]) {
        self.volumeBar.layer.shadowColor = [UIColor blackColor].CGColor;
        self.volumeBar.layer.shadowOffset = CGSizeMake(0, 0);
        self.volumeBar.layer.shadowOpacity = 1.0f;
        self.volumeBar.layer.shadowRadius = 0.25f;
    }
    
}

- (void) setControlTheme:(ABVolumeControlTheme)controlTheme {
    _controlTheme = controlTheme;
    
    [self updateVolumeBarColor];
}

- (UIColor *) lightColor {
    if ([self notNull:self.defaultLightColor]) {
        return self.defaultLightColor;
    }
    
    return [UIColor whiteColor];
}

- (UIColor *) darkColor {
    if ([self notNull:self.defaultDarkColor]) {
        return self.defaultDarkColor;
    }
    
    return [self colorWithHexString:@"262626"];
}

- (void) setVolumeLevel:(float)volumeLevel {
    if (volumeLevel < 0) {
        volumeLevel = 0;
    }
    else if (volumeLevel > 1) {
        volumeLevel = 1;
    }
    
    if ([self notNull: self.volumeSlider]) {
        
        [self.volumeSlider setValue:volumeLevel animated:NO];
        [self.volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (BOOL)notNull:(id)object {
    if ([object isEqual:[NSNull null]] || [object isKindOfClass:[NSNull class]] || object == nil) {
        return false;
    }
    else {
        return true;
    }
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
