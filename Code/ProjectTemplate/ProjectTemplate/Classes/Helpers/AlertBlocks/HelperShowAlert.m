/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import "HelperShowAlert.h"

#import "AppDelegate.h"
#import "TSMessage.h"
#import "UIAlertView+Blocks.h"


@implementation HelperShowAlert

void(^CBAccept)(void);
void(^CBCancel)(void);

#pragma mark - TSMessage -

+ (void) ShowWarning: (NSString *) title
                Text: (NSString *) text
{

    [TSMessage showNotificationInViewController:[self getCurrentViewController]
                                          title:title
                                       subtitle:text
                                           type:TSMessageNotificationTypeWarning];
    
}

+ (void) ShowError: (NSString *) title
              Text: (NSString *) text
{
    
    [TSMessage showNotificationInViewController:[self getCurrentViewController]
                                          title:title
                                       subtitle:text
                                           type:TSMessageNotificationTypeError];
    
}

+ (void) ShowSuccess: (NSString *) title
                Text: (NSString *) text
{ 
    [TSMessage showNotificationInViewController:[self getCurrentViewController]
                                          title:title
                                       subtitle:text
                                           type:TSMessageNotificationTypeSuccess];
    
}

#pragma mark - UIAlert -

+ (void) ShowInformationDialogWithTitle: (NSString *) title
                                   Text: (NSString *) text
                            AcceptLabel: (NSString *) acceptLabel
                              didAccept: (void(^)(void)) completionBlockAccept
{
    [self ShowConfirmationDialogWithTitle:title
                                     Text:text
                              AcceptLabel:nil
                              CancelLabel:acceptLabel
                                didAccept:nil
                                didCancel:completionBlockAccept];

}




+ (void) ShowConfirmationDialogWithTitle: (NSString *) title
                                    Text: (NSString *) text
                             AcceptLabel: (NSString *) acceptLabel
                             CancelLabel: (NSString *) cancelLabel
                               didAccept: (void(^)(void)) completionBlockAccept
                               didCancel: (void(^)(void)) completionBlockCancel
{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:text
                          delegate:nil
                          cancelButtonTitle:cancelLabel
                          otherButtonTitles:acceptLabel, nil];
    
    
    [alert showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == [alertView cancelButtonIndex]) {
            if (completionBlockCancel) {
                completionBlockCancel();
            }
        }
        else {
            if (completionBlockAccept) {
                completionBlockAccept();
            }
        }
    }];

}



#pragma mark - Utils

+ (UIViewController *) getCurrentViewController
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([mainDelegate respondsToSelector:@selector(window)]) {
        return ((UINavigationController *)mainDelegate.window.rootViewController).visibleViewController;
    }
    
    return nil;
}


@end
