/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>

@interface HelperRSSParser : NSObject

// Wrapper for MWFeedParser with blocks

typedef void(^SuccessBlockRSS)(NSDictionary *info, NSArray *data);

- (void) readAndParseRSSWithURL: (NSString*) url
                   successBlock: (SuccessBlockRSS) successBlock
                   failureBlock: (void(^)(NSError *error)) failureBlock
                completionBlock: (void(^)(void)) completionBlock;

@end
