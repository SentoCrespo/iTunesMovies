/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import "HelperProgressHud.h"


@implementation HelperProgressHud

+ (void) configureProgreessHUD
{
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.140 green:0.349 blue:0.602 alpha:1.000]];
    [SVProgressHUD setForegroundColor:[UIColor colorWithWhite:0.926 alpha:1.000]];
    [SVProgressHUD setRingThickness:2.0];

}

+ (void) show
{
    if (![[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication].delegate window].rootViewController.view setUserInteractionEnabled:NO];
        [SVProgressHUD show];
    });
}

+ (void) showWithStatus: (NSString *) status
{
    if (![[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication].delegate window].rootViewController.view setUserInteractionEnabled:NO];
        [SVProgressHUD showWithStatus:status];
    });
    
}

+ (void) showWithProgress: (CGFloat) progress
{
    if (![[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIApplication sharedApplication].delegate window].rootViewController.view setUserInteractionEnabled:NO];
        [SVProgressHUD showProgress:progress];
    });
}

+ (void) dismiss
{
    if (![[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
    [[[UIApplication sharedApplication].delegate window].rootViewController.view setUserInteractionEnabled:YES];
        [SVProgressHUD dismiss];
    });
}

@end
