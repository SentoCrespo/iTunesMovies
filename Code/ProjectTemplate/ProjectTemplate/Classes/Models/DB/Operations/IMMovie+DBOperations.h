/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 - All rights reserved.
 *
 ******************************************************************************/

#import "IMMovie.h"

@interface IMMovie (DBOperations)

#pragma mark - CRUD

#pragma mark Create

+ (void) createFromArray: (NSArray *) items
            successBlock: (void(^)(void)) successBlock
            failureBlock: (void(^)(NSError *error)) failureBlock;


#pragma mark Read

+ (IMMovie *) readItemWithIdentifier: (NSInteger) identifier;

+ (void) readItemWithIdentifier: (NSInteger) identifier
                completionBlock: (void(^)(IMMovie *item)) completionBlock;


+ (NSArray *) readAllItemsSortedByDate;

+ (void) readAllItemsSortedByDate: (void(^)(NSArray *items)) completionBlock;


+ (NSInteger) readAllCount;



#pragma mark Update

#pragma mark Delete

+ (void) deleteItemWithIdentifier: (NSInteger) identifier;

+ (void) deleteItemWithIdentifier: (NSInteger) identifier
                     successBlock: (void(^)(void)) successBlock
                     failureBlock: (void(^)(NSError *error)) failureBlock;


- (void) deleteItem;

- (void) deleteItem: (void(^)(void)) successBlock
       failureBlock: (void(^)(NSError *error)) failureBlock;


+ (void) deleteAllItems;



#pragma mark - Utils -



@end
