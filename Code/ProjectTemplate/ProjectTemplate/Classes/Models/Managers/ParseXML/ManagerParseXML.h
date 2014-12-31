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



#pragma mark - Parse Movies

- (void) parseMoviesXML: (void (^)(id data)) successBlock
           failureBlock: (void (^)(NSError *error)) failureBlock
        completionBlock: (void (^)(void)) completionBlock;



@end
