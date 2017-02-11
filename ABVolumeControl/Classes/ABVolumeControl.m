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
        
        UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow makeKeyAndVisible];
        CGRect windowFrame = currentWindow.bounds;
        CGFloat viewWidth = windowFrame.size.width;
        self.volumeBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 2)];
        
        self.volumeBackground.backgroundColor = [UIColor darkGrayColor];
        self.volumeBackground.alpha = 0;
        
        self.volumeBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        
        self.controlTheme = ABVolumeControlDarkTheme;
        
        [self updateVolumeBarColor];
        
        self.volumeBar.clipsToBounds = NO;
        self.volumeBar.layer.masksToBounds = NO;
        
        self.volumeBar.layer.shadowColor = [UIColor blackColor].CGColor;
        self.volumeBar.layer.shadowOffset = CGSizeMake(0, 0);
        self.volumeBar.layer.shadowOpacity = 0.5f;
        self.volumeBar.layer.shadowRadius = 1.0f;
        self.volumeBar.alpha = 0;
        
        self.mpVolumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-50, -50, 0, 0)];
        
        [[self.mpVolumeView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UISlider class]]) {
                self.volumeSlider = obj;
                *stop = YES;
            }
        }];
        
        // Notification when volume is changed
        [self.volumeSlider addTarget:self action:@selector(handleVolumeChanged:) forControlEvents:UIControlEventValueChanged];
        
        [currentWindow addSubview:self.volumeBackground];
        [currentWindow addSubview:self.volumeBar];
        
        NSLog(@"MPVolumeView %@", self.mpVolumeView);
        NSLog(@"Current Window %@", currentWindow);
        
        if (self.mpVolumeView && currentWindow) {
            [currentWindow addSubview:self.mpVolumeView];
        }
        
    }
    return self;
}

- (void)handleVolumeChanged:(id)sender
{
    
    // Handles a change in volume, and adjusts the width of the volumeBar accordingly
    
    //    [Utils printString:[NSString stringWithFormat:@"%s - %f", __PRETTY_FUNCTION__, volumeSlider.value]];
    
    // Volume changed, show volumeBar
    
    UIWindow *mainWinow = [UIApplication sharedApplication].keyWindow;
    CGRect windowFrame = mainWinow.bounds;
    CGFloat viewWidth = windowFrame.size.width;
    self.volumeBackground.frame = CGRectMake(0, 0, viewWidth, 2);
    
    CGRect volumeBarFrame = self.volumeBar.frame;
    
    CGFloat previousWidth = volumeBarFrame.size.width;
    
    CGFloat newWidth = (self.volumeSlider.value/1.0f) * viewWidth;
    
    newWidth = (self.volumeSlider.value/1.0f) * viewWidth;
    volumeBarFrame.size = CGSizeMake(newWidth, 2);
    
    [self updateVolumeBarColor];
    
    self.volumeBackground.backgroundColor = [UIColor darkGrayColor];
    
    if ((newWidth != previousWidth || newWidth >= viewWidth || newWidth <= 0) && !self.dontShowVolumeBar) {
        
        [UIView animateWithDuration:0.35f animations:^{
            self.volumeBar.frame = volumeBarFrame;
            self.volumeBar.alpha = 0.75f;
            self.volumeBackground.alpha = 1.0f;
            
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

- (void) dontShowVolumebar {
    self.volumeBar.alpha = 0;
    self.volumeBackground.alpha = 0;
    self.dontShowVolumeBar = true;
    
    [self performSelector:@selector(showVolumeBar) withObject:nil afterDelay:1.0f];
}

- (void) showVolumeBar {
    self.dontShowVolumeBar = false;
}

- (void) volumeDone {
    // Hide volumeBar after animation
    [UIView animateWithDuration:0.35f animations:^{
        self.volumeBar.alpha = 0;
        self.volumeBackground.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void) updateVolumeBarColor {
    if (self.controlTheme == ABVolumeControlLightTheme) {
        self.volumeBar.backgroundColor = [self lightColor];
    }
    else {
        self.volumeBar.backgroundColor = [self darkColor];
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
    
    return [self colorWithHexString:@"FFFFFF"];
}

- (UIColor *) darkColor {
    if ([self notNull:self.defaultDarkColor]) {
        return self.defaultDarkColor;
    }
    
    return [self colorWithHexString:@"2ECC71"];
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
