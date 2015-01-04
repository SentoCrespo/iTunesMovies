/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import "UINavigationController+NavigationExtras.h"

#import "AppDelegate.h"

@implementation UINavigationController (NavigationExtras)

- (NSArray *) popViewControllers: (NSInteger) numberToPop
{
    return [self popViewControllers:numberToPop
                           animated:YES];
}

- (NSArray *) popViewControllers: (NSInteger) numberToPop
                        animated: (BOOL) isAnimated {

    NSInteger VCcount = self.viewControllers.count;
    if (VCcount < numberToPop) {
        numberToPop = VCcount - 1;
    }
    return [self popToViewController:self.viewControllers[VCcount - numberToPop - 1]
                            animated:YES];
    
}


- (NSArray *) popToViewControllerFromClass: (Class) classToPresent
                                  animated: (BOOL) isAnimated
{
    for (UIViewController *aViewController in self.viewControllers) {
        if ([aViewController isKindOfClass:classToPresent]) {
            return [self popToViewController:aViewController
                                    animated:isAnimated];
        }
    }
    
    return nil;
}


+ (UIViewController *) topViewController
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([mainDelegate respondsToSelector:@selector(window)]) {
        return ((UINavigationController *)mainDelegate.window.rootViewController).visibleViewController;
    }
    
    return nil;

}

- (void) enablePopGestureInViewController: (UIViewController *) viewController
{
    self.interactivePopGestureRecognizer.delegate = (id)viewController;

}


@end
