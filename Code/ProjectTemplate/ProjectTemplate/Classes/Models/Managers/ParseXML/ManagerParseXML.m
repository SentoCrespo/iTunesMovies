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

@end





#pragma mark - Init

@implementation ManagerParseXML


#pragma mark - Parse




- (void) parseMoviesXMLData: (NSData *) data
               successBlock: (void (^)(id data)) successBlock
               failureBlock: (void (^)(NSError *error)) failureBlock
{
    if (!data || !data.length) {
        failureBlock? failureBlock([NSError errorWithDomain:@"No data" code:404 userInfo:nil]) : nil;
        return;
    }
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    [self parseMoviesXMLParser:parser
                  successBlock:successBlock
                  failureBlock:failureBlock];
}


- (void) parseMoviesXMLParser: (NSXMLParser *) parser
                 successBlock: (void (^)(id data)) successBlock
                 failureBlock: (void (^)(NSError *error)) failureBlock
{
    
    if (!parser) {
        failureBlock? failureBlock([NSError errorWithDomain:@"No parser" code:404 userInfo:nil]) : nil;
        return;
    }
    
    _successBlock = successBlock;
    _failureBlock = failureBlock;

    
    _xmlParser = parser;
    _xmlParser.delegate = self;
    [_xmlParser parse];
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
}


-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    _failureBlock? _failureBlock(parseError) : nil;
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

    // Capture the identifier attribute
    else if ([elementName isEqualToString:identifierTag]) {
        NSString *identifier = attributeDict[identifierAttr];
        NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
        [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
        NSNumber *identifierNumber = [numberFormatter numberFromString:identifier];
        [_dictElement setObject:identifierNumber
                         forKey:identifierAttr];
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
