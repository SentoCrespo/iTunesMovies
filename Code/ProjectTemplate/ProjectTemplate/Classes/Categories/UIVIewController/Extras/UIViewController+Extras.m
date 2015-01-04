/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/


#import "UIViewController+Extras.h"

#import "UIImage+Resize.h"

@implementation UIViewController (Extras)

- (void) addImageToLeftInNavigationBar: (UIImage *) image
{
    UIImage *img1 = image;
    img1 = [img1 resizedImage:CGSizeMake(20, 20) interpolationQuality:kCGInterpolationHigh];
    img1 = [img1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:img1
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:nil];
    [btn setEnabled:NO];
    self.navigationItem.leftBarButtonItem = btn;
}


@end
