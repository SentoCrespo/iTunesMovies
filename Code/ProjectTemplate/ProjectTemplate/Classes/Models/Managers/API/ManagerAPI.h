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

+ (void) getMovies: (void(^)(NSInteger numberItems)) successBlock
      failureBlock: (void(^)(NSError *error)) failureBlock
   completionBlock: (void(^)(void)) completionBlock;



#pragma mark - General operations

+ (void) clearCookies;

+ (void) cancelAllOperations;


@end
