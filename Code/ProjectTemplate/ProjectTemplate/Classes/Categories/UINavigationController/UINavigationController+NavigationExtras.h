/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <UIKit/UIKit.h>


@interface UINavigationController (NavigationExtras)

- (NSArray *) popViewControllers: (NSInteger) numberToPop;

- (NSArray *) popViewControllers: (NSInteger) numberToPop
                        animated: (BOOL) isAnimated;


- (NSArray *) popToViewControllerFromClass: (Class) classToPresent
                                  animated: (BOOL) isAnimated;

+ (UIViewController *) topViewController;

// Add it and then just use popToViewController
- (void) enablePopGestureInViewController: (UIViewController *) viewController;


@end
