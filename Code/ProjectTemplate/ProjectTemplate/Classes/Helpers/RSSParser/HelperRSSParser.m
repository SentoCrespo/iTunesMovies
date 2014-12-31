/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import "HelperRSSParser.h"



@interface HelperRSSParser()


    @property (nonatomic, copy) SuccessBlockRSS successBlockRSS;
    @property (nonatomic, copy) void(^failureBlock)(NSError *error);
    @property (nonatomic, copy) void(^completionBlock)(void);



@end


@implementation HelperRSSParser

- (void) readAndParseRSSWithURL: (NSString*) url
                   successBlock: (SuccessBlockRSS) successBlock
                   failureBlock: (void(^)(NSError *error)) failureBlock
                completionBlock: (void(^)(void)) completionBlock
{
    
}






@end
