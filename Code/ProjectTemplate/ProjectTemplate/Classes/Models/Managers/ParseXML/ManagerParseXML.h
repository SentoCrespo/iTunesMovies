/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/



#import <Foundation/Foundation.h>


@interface ManagerParseXML : NSObject

#pragma mark - Properties


#define elementNameTag @"entry"

    #define titleTag         @"im:name"
    #define summaryTag       @"summary"
    #define imageTag         @"im:image"
    #define artistTag        @"im:artist"
    #define releaseDateTag   @"im:releaseDate"
    #define categoryTag      @"category"
    #define categoryTermAttr @"label"




#pragma mark - Parse Movies

/**
 *  Downloads and parses the movies URL from iTunes
 *
 *  @param successBlock    Returns the data parsed
 *  @param failureBlock    Contains the error
 *  @param completionBlock Called when the method has ended
 */
- (void) parseMoviesXML: (void (^)(id data)) successBlock
           failureBlock: (void (^)(NSError *error)) failureBlock
        completionBlock: (void (^)(void)) completionBlock;

/**
 *  Same as before but it parses the NSData given
 *
 *  @param data            XML in NSData format
 *  @param successBlock    Returns the data parsed
 *  @param failureBlock    Contains the error
 *  @param completionBlock Called when the method has ended
 */
- (void) parseMoviesXMLData: (NSData *) data
               successBlock: (void (^)(id data)) successBlock
               failureBlock: (void (^)(NSError *error)) failureBlock
            completionBlock: (void (^)(void)) completionBlock;


/**
 *  Same as before but it parses the NSXMLParser given
 *
 *  @param data            XML in NSXMLParser format
 *  @param successBlock    Returns the data parsed
 *  @param failureBlock    Contains the error
 *  @param completionBlock Called when the method has ended
 */
- (void) parseMoviesXMLParser: (NSXMLParser *) parser
                 successBlock: (void (^)(id data)) successBlock
                 failureBlock: (void (^)(NSError *error)) failureBlock
              completionBlock: (void (^)(void)) completionBlock;


@end
