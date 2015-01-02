/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/



#import <Foundation/Foundation.h>

#import "AFNetworking.h"


@interface ManagerAPI : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

#pragma mark - Properties



#pragma mark - Shared Instance

+ (ManagerAPI *) sharedInstance;


#pragma mark - API Methods

/**
 *  Downloads the movies XML from Apple
 *  (AFNetworking)
 *
 *  @param successBlock Contains the NXSMLParser
 *  @param failureBlock
 *  @param completionBlock
 */
+ (void) getMoviesXML: (void(^)(id data)) successBlock
         failureBlock: (void(^)(NSError *error)) failureBlock
      completionBlock: (void(^)(void)) completionBlock;


#pragma mark - RAW Data Download

/**
 *  Creates the url and checks if it's a valid one.
 *  Downloads the given data and checks for errors.
 *  (NSURL)
 *
 *  @param urlString       Url String
 *  @param successBlock
 *  @param failureBlock
 *  @param completionBlock 
 */
+ (void) downloadDataFromURL: (NSString *) urlString
                successBlock: (void (^)(id data)) successBlock
                failureBlock: (void (^)(NSError *error)) failureBlock
             completionBlock: (void (^)(void)) completionBlock;


#pragma mark - General operations

+ (void) clearCookies;

+ (void) cancelAllOperations;


@end
