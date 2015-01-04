/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>


@interface HelperShowAlert : NSObject

#pragma mark - TSMessage -

+ (void) ShowWarning: (NSString *) title
                Text: (NSString *) text;

+ (void) ShowError: (NSString *) title
              Text: (NSString *) text;

+ (void) ShowSuccess: (NSString *) title
                Text: (NSString *) text;

#pragma mark - UIAlert -

+ (void) ShowInformationDialogWithTitle: (NSString *) title
                                   Text: (NSString *) text
                            AcceptLabel: (NSString *) acceptLabel
                              didAccept: (void(^)(void)) completionBlockAccept;


+ (void) ShowConfirmationDialogWithTitle: (NSString *) title
                                    Text: (NSString *) text
                             AcceptLabel: (NSString *) acceptLabel
                             CancelLabel: (NSString *) cancelLabel
                               didAccept: (void(^)(void)) completionBlockAccept
                               didCancel: (void(^)(void)) completionBlockCancel;



@end
