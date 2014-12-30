/******************************************************************************
 *
 * Pets APP
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2014 Vicente Crespo Penadés. All rights reserved.
 *
 ******************************************************************************/

#import "TSBlurView.h"
#import <QuartzCore/QuartzCore.h>

@interface TSBlurView ()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation TSBlurView


- (UIToolbar *)toolbar
{
    if (_toolbar == nil) {
        _toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        _toolbar.userInteractionEnabled = NO;
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        [_toolbar setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; // remove background set through the appearence proxy
#endif
        [self addSubview:_toolbar];
    }

    return _toolbar;
}

- (void)setBlurTintColor:(UIColor *)blurTintColor
{
    if ([self.toolbar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.toolbar performSelector:@selector(setBarTintColor:) withObject:blurTintColor];
    }
}

- (UIColor *)blurTintColor
{
    if ([self.toolbar respondsToSelector:@selector(barTintColor)]) {
        return [self.toolbar performSelector:@selector(barTintColor)];
    }
    return nil;
}

@end