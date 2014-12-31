/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "ManagerParseXML.h"

#import "GTMNSString+HTML.h"

@interface ManagerParseXML() <NSXMLParserDelegate>

    @property (nonatomic, strong) NSXMLParser *xmlParser;
    @property (nonatomic, strong) NSMutableArray *dataParsed;

    // Temporary structs to parse XML
    @property (nonatomic, strong) NSMutableDictionary *dictElement;
    @property (nonatomic, strong) NSString *currentElement;
    @property (nonatomic, strong) NSMutableString *foundValue;

    @property (nonatomic, copy) void(^successBlock)(id data);
    @property (nonatomic, copy) void(^failureBlock)(NSError *error);
    @property (nonatomic, copy) void(^completionBlock)(void);

@end


#define elementNameTag @"entry"

    #define titleTag        @"title"
    #define summaryTag      @"summary"
    #define imageTag        @"im:image"
    #define artistTag       @"im:artist"
    #define releaseDateTag  @"im:releaseDate"
    #define categoryTag     @"category"
    #define categoryTermAttr @"label"


#pragma mark - Init

@implementation ManagerParseXML


#pragma mark - Parse

- (void) parseMoviesXML: (void (^)(id data)) successBlock
           failureBlock: (void (^)(NSError *error)) failureBlock
        completionBlock: (void (^)(void)) completionBlock
{
    
    _successBlock = successBlock;
    _failureBlock = failureBlock;
    _completionBlock = completionBlock;
    
    
    WEAKSELF(wS);
    [ManagerAPI getMoviesXML:^(id data) {

        wS.xmlParser = (NSXMLParser *) data;
        wS.xmlParser.delegate = self;
        [wS.xmlParser parse];
        
    } failureBlock:^(NSError *error) {
        failureBlock? failureBlock(error) : nil;
        completionBlock? completionBlock() : nil;
        
    } completionBlock:nil];
    

}


#pragma mark - NSXML Delegate -


-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    _dataParsed = [NSMutableArray new];
    _foundValue = [NSMutableString new];

}


-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    _successBlock? _successBlock(_dataParsed) : nil;
    _completionBlock? _completionBlock() : nil;
}


-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    _failureBlock? _failureBlock(parseError) : nil;
    _completionBlock? _completionBlock() : nil;

}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // Starting a new item
    if ([elementName isEqualToString:elementNameTag]) {
        _dictElement = [NSMutableDictionary new];
    }
    
    // Capture the category label attribute
    else if ([elementName isEqualToString:categoryTag]) {
        [_dictElement setObject:[self stringByUnescapingAndCollapsingSpaces:attributeDict[categoryTermAttr]]
                         forKey:categoryTag];
    }
    
    _currentElement = elementName;
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
{
    
    // All data from element is parsed
    if ([elementName isEqualToString:elementNameTag]) {
        [_dataParsed addObject:_dictElement];
    }
    
    
    // Add data to current parsed element
    else if ([elementName isEqualToString:titleTag]) {
        [_dictElement setObject:[self stringByUnescapingAndCollapsingSpaces:_foundValue]
                         forKey:titleTag];
    }
    
    else if ([elementName isEqualToString:summaryTag]) {
        [_dictElement setObject:[self stringByUnescapingAndCollapsingSpaces:_foundValue]
                         forKey:summaryTag];
    }

    else if ([elementName isEqualToString:artistTag]) {
        [_dictElement setObject:[self stringByUnescapingAndCollapsingSpaces:_foundValue]
                         forKey:artistTag];
    }
    
    else if ([elementName isEqualToString:releaseDateTag]) {
        [_dictElement setObject:[self stringByUnescapingAndCollapsingSpaces:_foundValue]
                         forKey:releaseDateTag];
    }

    // There are several image sizes (60, 170, ...)
    // This will take the last node, the largest one as we want
    else if ([elementName isEqualToString:imageTag]) {
        [_dictElement setObject:[self stringByUnescapingAndCollapsingSpaces:_foundValue]
                         forKey:imageTag];
    }

    [_foundValue setString:@""];
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if ([_currentElement isEqualToString:titleTag]      ||
        [_currentElement isEqualToString:summaryTag]    ||
        [_currentElement isEqualToString:imageTag]      ||
        [_currentElement isEqualToString:artistTag]     ||
        [_currentElement isEqualToString:releaseDateTag]) {
        
        if (![string isEqualToString:@"\n"]) {
            [_foundValue appendString:string];
        }
    }
    
    
}


#pragma mark - Utils

- (NSString *) stringByUnescapingAndCollapsingSpaces: (NSString *) originalString
{
    NSString *newString = [[originalString gtm_stringByUnescapingFromHTML] copy];
    newString = [newString stringByCollapsingBlankSpaces];
    return newString;
}


@end
