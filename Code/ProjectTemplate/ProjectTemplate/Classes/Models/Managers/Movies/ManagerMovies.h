/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/



#import <Foundation/Foundation.h>


@interface ManagerMovies : NSObject

#pragma mark - Properties


#pragma mark - Parse Movies

/**
 *  Downloads + parses + stores the movies from iTunes (for DB use)
 *
 *  @param successBlock
 *  @param failureBlock    Contains the error
 *  @param completionBlock Called when the method has ended
 */

- (void) storeMovies: (void (^)(void)) successBlock
        failureBlock: (void (^)(NSError *error)) failureBlock
     completionBlock: (void (^)(void)) completionBlock;


/**
 *  Downloads and parses the movies URL from iTunes (for memmory use)
 *
 *  @param successBlock    Returns the movies parsed
 *  @param failureBlock    Contains the error
 *  @param completionBlock Called when the method has ended
 */

- (void) getMovies: (void (^)(NSArray *items)) successBlock
      failureBlock: (void (^)(NSError *error)) failureBlock
   completionBlock: (void (^)(void)) completionBlock;



@end
