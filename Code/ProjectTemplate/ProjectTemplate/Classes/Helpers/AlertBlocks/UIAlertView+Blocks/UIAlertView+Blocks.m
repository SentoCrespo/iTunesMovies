/******************************************************************************
 *
 * Pets APP
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2014 Vicente Crespo Penadés. All rights reserved.
 *
 ******************************************************************************/

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>

/*
 * Runtime association key.
 */
static NSString *kHandlerAssociatedKey = @"kHandlerAssociatedKey";

@implementation UIAlertView (Blocks)

#pragma mark - Showing

/*
 * Shows the receiver alert with the given handler.
 */
- (void)showWithHandler:(UIAlertViewHandler)handler {
    
    objc_setAssociatedObject(self, (__bridge const void *)(kHandlerAssociatedKey), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setDelegate:self];
    [self show];
}

#pragma mark - UIAlertViewDelegate

/*
 * Sent to the delegate when the user clicks a button on an alert view.
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIAlertViewHandler completionHandler = objc_getAssociatedObject(self, (__bridge const void *)(kHandlerAssociatedKey));
    
    if (completionHandler != nil) {
        
        completionHandler(alertView, buttonIndex);
    }
}

#pragma mark - Utility methods

/*
 * Utility selector to show an alert with a title, a message and a button to dimiss.
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
              handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert showWithHandler:handler];
}

/*
 * Utility selector to show an alert with an "Error" title, a message and a button to dimiss.
 */
+ (void)showErrorWithMessage:(NSString *)message
                     handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert showWithHandler:handler];
}

/*
 * Utility selector to show an alert with a "Warning" title, a message and a button to dimiss.
 */
+ (void)showWarningWithMessage:(NSString *)message
                       handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert showWithHandler:handler];
}

/*
 * Utility selector to show a confirmation dialog with a title, a message and two buttons to accept or cancel.
 */
+ (void)showConfirmationDialogWithTitle:(NSString *)title
                                message:(NSString *)message
                                handler:(UIAlertViewHandler)handler {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    
    [alert showWithHandler:handler];
}

@end
