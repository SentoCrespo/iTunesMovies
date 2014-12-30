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


    @property (nonatomic, strong) MWFeedParser *feedParser;
    @property (nonatomic, strong) MWFeedInfo *feedInfo;
    @property (nonatomic, strong) NSMutableArray *feedItems;

@end


@implementation HelperRSSParser


- (void) readAndParseRSSWithURL: (NSString*) url
                   successBlock: (SuccessBlockRSS) successBlock
                   failureBlock: (void(^)(NSError *error)) failureBlock
                completionBlock: (void(^)(void)) completionBlock
{
    _successBlockRSS    = [successBlock copy];
    _failureBlock       = failureBlock;
    _completionBlock    = completionBlock;
    
    _feedItems = [NSMutableArray new];
    
    NSURL *feedURL = [NSURL URLWithString:url];
    _feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    
    _feedParser.delegate = self;
    
    _feedParser.feedParseType = ParseTypeFull;
    
    _feedParser.connectionType = ConnectionTypeAsynchronously;
    
    [_feedParser parse];
    
}



#pragma mark - RSS Parse delegate

// Called when data has downloaded and parsing has begun
- (void)feedParserDidStart:(MWFeedParser *)parser
{
    
}

// Provides info about the feed
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
    _feedInfo = info;
}

// Provides info about a feed item
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    if (item) {
        [_feedItems addObject:item];
    }
}

// Parsing complete or stopped at any time by stopParsing
- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    _successBlockRSS? _successBlockRSS(_feedInfo, _feedItems) : nil;
    _completionBlock? _completionBlock() : nil;
}


// Parsing failed
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    _failureBlock? _failureBlock(error) : nil;
    _completionBlock? _completionBlock() : nil;
}


@end
