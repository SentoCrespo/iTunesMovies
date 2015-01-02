/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 - All rights reserved.
 *
 ******************************************************************************/

#import "IMMovie+Utils.h"

@implementation IMMovie (Utils)

#pragma mark - Utils

- (NSString *) dateFormatted
{
    return [NSDateFormatter localizedStringFromDate:self.releaseDate
                                          dateStyle:NSDateFormatterMediumStyle
                                          timeStyle:NSDateFormatterNoStyle];
}


@end
