/******************************************************************************
 *
 * Categories
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/


#import "UIView+ViewExtras.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIView (ViewExtras)

#pragma mark - Effects -

- (void) setShadowFromLocation: (NSLocation) location
                     withColor: (UIColor *) color
                    withOffset: (CGFloat) offset
              withShadowRadius: (CGFloat) shadowRadius {
    
    
    // From top
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOffset = CGSizeMake(0, offset);
    self.layer.shadowOpacity = 0.9;
    self.layer.shadowColor = color.CGColor;
    CGRect sombra =  [self createFrameForShadowFromLocation:location
                                                 withOffset:offset
                                           withShadowRadius:shadowRadius];
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:sombra].CGPath;
    
}


- (CGRect) createFrameForShadowFromLocation: (NSLocation) location
                                 withOffset: (CGFloat) offset
                           withShadowRadius: (CGFloat) shadowRadius {

    switch (location) {
        case NSLocationTop:
            return CGRectMake(0 - shadowRadius,
                              0 + offset,
                              self.bounds.size.width + (shadowRadius * 2),
                              self.bounds.size.height);

            default:
            return CGRectZero;
    }
    
}

- (void) setRoundedView
{
    [self setRoundedViewToRadius:self.frame.size.width / 2];
}


- (void) setRoundedViewToRadius: (float) diameter
{
    
    self.layer.cornerRadius = diameter;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
    
}


- (void) setRoundAllCornersCornerRadii: (CGFloat) cornerRadii
{
    [self setRoundCornersTopLeft:YES
                        topRight:YES
                      bottomLeft:YES
                     bottomRight:YES
                     cornerRadii:cornerRadii];
}

- (void) setRoundCornersTopLeft: (BOOL) topLeft
                       topRight: (BOOL) topRight
                     bottomLeft: (BOOL) bottomLeft
                    bottomRight: (BOOL) bottomRight
                    cornerRadii: (CGFloat) height
{
    NSUInteger corners = 0;
    if(topLeft){ corners = UIRectCornerTopLeft;}
    if(topRight){ corners = corners | UIRectCornerTopRight;}
    if(bottomLeft){ corners = corners | UIRectCornerBottomLeft;}
    if(bottomRight){ corners = corners | UIRectCornerBottomRight;}
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(height, height)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}


#pragma mark - Utils -

- (NSArray *) allSubviews
{
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObject:self];
    for (UIView *subview in self.subviews)
    {
        [arr addObjectsFromArray:(NSArray*)[subview allSubviews]];
    }
    return arr;
}


- (void) removeAllSubviews
{
    [[self subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
