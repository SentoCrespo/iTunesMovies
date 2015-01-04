/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <UIKit/UIKit.h>


enum {
    NSLocationTop = 1,
    NSLocationLeft = 2,
    NSLocationBottom = 3,
    NSLocationRight = 4
};
typedef NSInteger NSLocation;


@interface UIView (ViewExtras)

#pragma mark - Effects -

- (void) setShadowFromLocation: (NSLocation) location
                     withColor: (UIColor *) color
                    withOffset: (CGFloat) offset
              withShadowRadius: (CGFloat) shadowRadius;

- (void) setRoundedView;

- (void) setRoundedViewToRadius: (float) diameter;

- (void) setRoundAllCornersCornerRadii: (CGFloat) cornerRadii;

- (void) setRoundCornersTopLeft: (BOOL) topLeft
                       topRight: (BOOL) topRight
                     bottomLeft: (BOOL) bottomLeft
                    bottomRight: (BOOL) bottomRight
                    cornerRadii: (CGFloat) height;


#pragma mark - Utils -

- (NSArray *) allSubviews;

- (void) removeAllSubviews;

@end
