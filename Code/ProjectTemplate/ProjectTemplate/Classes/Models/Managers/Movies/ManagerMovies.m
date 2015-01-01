/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "ManagerMovies.h"

#import "ManagerParseXML.h"

@interface ManagerMovies()

    @property (nonatomic, strong) ManagerParseXML *managerParseXML;

@end





#pragma mark - Init

@implementation ManagerMovies

- (void) storeMovies: (void (^)(void)) successBlock
        failureBlock: (void (^)(NSError *error)) failureBlock
     completionBlock: (void (^)(void)) completionBlock
{
    _managerParseXML = [ManagerParseXML new];
        
    [ManagerAPI getMoviesXML:^(id data) {
        
        [_managerParseXML parseMoviesXMLParser:data
                                  successBlock:^(id data) {
                                      
                                      [IMMovie createFromArray:data
                                                  successBlock:^{
                                                      successBlock? successBlock() : nil;
                                                  } failureBlock:^(NSError *error) {
                                                      ;
                                                  }];
                                      
                                  }
                                  failureBlock:failureBlock
                               completionBlock:completionBlock];
        
    }
                failureBlock:failureBlock
             completionBlock:completionBlock];
    
}


- (void) getMovies: (void (^)(NSArray *items)) successBlock
      failureBlock: (void (^)(NSError *error)) failureBlock
   completionBlock: (void (^)(void)) completionBlock
{
 
    _managerParseXML = [ManagerParseXML new];
    
    [ManagerAPI getMoviesXML:^(id data) {
        
        [_managerParseXML parseMoviesXMLParser:data
                                  successBlock:successBlock
                                  failureBlock:failureBlock
                               completionBlock:completionBlock];
        
    } failureBlock:^(NSError *error) {
        failureBlock? failureBlock(error) : nil;
        completionBlock? completionBlock() : nil;
        
    } completionBlock:nil];
    
}



@end
