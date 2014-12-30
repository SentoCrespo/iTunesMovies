/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>

#import "MWFeedParser.h"

@interface HelperRSSParser : NSObject <MWFeedParserDelegate>

// Wrapper for MWFeedParser with blocks

typedef void(^SuccessBlockRSS)(MWFeedInfo *info, NSArray *data);

- (void) readAndParseRSSWithURL: (NSString*) url
                   successBlock: (SuccessBlockRSS) successBlock
                   failureBlock: (void(^)(NSError *error)) failureBlock
                completionBlock: (void(^)(void)) completionBlock;

@end
