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

+ (NSArray *) readAllItemsSortedByDate;

+ (NSInteger) readAllCount;

#pragma mark Update

#pragma mark Delete

+ (void) deleteItemWithIdentifier: (NSInteger) identifier;

- (void) deleteItem;

+ (void) deleteAllItems;

#pragma mark - Utils -



@end
