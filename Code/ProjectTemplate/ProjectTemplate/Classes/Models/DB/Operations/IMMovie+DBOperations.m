/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 - All rights reserved.
 *
 ******************************************************************************/

#import "IMMovie+DBOperations.h"

@implementation IMMovie (DBOperations)

#pragma mark - CRUD


#pragma mark Create

+ (void) createFromArray: (NSArray *) items
            successBlock: (void(^)(void)) successBlock
            failureBlock: (void(^)(NSError *error)) failureBlock
{

    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [IMMovie MR_importFromArray:items
                          inContext:localContext];
        
    } completion:^(BOOL contextDidSave, NSError *error) {
        
        if (error) {
            failureBlock? failureBlock(error) : nil;
            return;
        }
        successBlock? successBlock() : nil;
        
    }];
    
    
    
}


#pragma mark Read

+ (IMMovie *) readItemWithIdentifier: (NSInteger) identifier
{
    
    return [IMMovie MR_findFirstByAttribute:@"identifier"
                                 withValue:@(identifier)];
    
}


+ (NSArray *) readAllItemsSortedByDate
{
    NSArray *items = [IMMovie MR_findAllSortedBy:@"releaseDate"
                                        ascending:NO];
    
    return items;
    
}


+ (NSInteger) readAllCount
{
    return [IMMovie MR_countOfEntities];
}


#pragma mark Update

#pragma mark Delete

+ (void) deleteItemWithIdentifier: (NSInteger) identifier
{
    IMMovie *item = [IMMovie readItemWithIdentifier:identifier];
    [item deleteItem];
}

- (void) deleteItem
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        IMMovie *localItem = [self MR_inContext:localContext];
        [localItem MR_deleteEntity];
    } completion:^(BOOL contextDidSave, NSError *error) {
        nil;
    }];
}

+ (void) deleteAllItems
{
    [IMMovie MR_truncateAll];
}



#pragma mark - Utils -






@end
