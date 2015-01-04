/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>

#import "SVProgressHUD.h"

@interface HelperProgressHud : NSObject

+ (void) configureProgreessHUD;

+ (void) show;
+ (void) showWithStatus: (NSString *) status;
+ (void) showWithProgress: (CGFloat) progress;

+ (void) dismiss;

@end
