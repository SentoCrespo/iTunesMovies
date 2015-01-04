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

+ (void) readItemWithIdentifier: (NSInteger) identifier
                completionBlock: (void(^)(IMMovie *item)) completionBlock
{
    
    
    [self backgroundFetchWithBlock:^NSArray *(NSManagedObjectContext *context) {
        
        return @[[IMMovie MR_findFirstByAttribute:@"identifier"
                                        withValue:@(identifier)
                                        inContext:context]];
        
    } successBlock:^(NSArray *items) {
        completionBlock? completionBlock(items.firstObject) : nil;
    }];
    
}



+ (NSArray *) readAllItemsSortedByDate
{
    NSArray *items = [IMMovie MR_findAllSortedBy:@"releaseDate"
                                        ascending:NO];
    
    return items;
    
}

+ (void) readAllItemsSortedByDate: (void(^)(NSArray *items)) completionBlock
{
    [self backgroundFetchWithBlock:^NSArray *(NSManagedObjectContext *context) {
        
        return @[[IMMovie MR_findAllSortedBy:@"releaseDate"
                                   ascending:NO
                                   inContext:context]];
        
    } successBlock:^(NSArray *items) {
        completionBlock? completionBlock(items.firstObject) : nil;
    }];
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

+ (void) deleteItemWithIdentifier: (NSInteger) identifier
                     successBlock: (void(^)(void)) successBlock
                     failureBlock: (void(^)(NSError *error)) failureBlock
{
    [IMMovie readItemWithIdentifier:identifier
                    completionBlock:^(IMMovie *item) {
                        
                        [item deleteItem:successBlock
                            failureBlock:failureBlock];
                        
                    }];
}




- (void) deleteItem
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        IMMovie *localItem = [self MR_inContext:localContext];
        [localItem MR_deleteEntity];
    }];
}


- (void) deleteItem: (void(^)(void)) successBlock
       failureBlock: (void(^)(NSError *error)) failureBlock
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        IMMovie *localItem = [self MR_inContext:localContext];
        [localItem MR_deleteEntity];
        
    } completion:^(BOOL contextDidSave, NSError *error) {
        if (error) {
            failureBlock? failureBlock(error) : nil;
            return;
        }
        successBlock? successBlock() : nil;
    }];
}




+ (void) deleteAllItems
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [IMMovie MR_truncateAllInContext:localContext];
    }];
    
}



#pragma mark - Utils -

+ (void) backgroundFetchWithBlock: (NSArray *(^)(NSManagedObjectContext *context)) fetchItemsBlock
                     successBlock: (void(^)(NSArray *items)) successBlock {
    
    NSManagedObjectContext *privateContext = [NSManagedObjectContext MR_context];
    [privateContext performBlock:^{
        
        NSArray *privateObjects = fetchItemsBlock(privateContext);
        
        NSArray *privateObjectIDs = [privateObjects valueForKey:@"objectID"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSPredicate *mainPredicate = [NSPredicate predicateWithFormat:@"self IN %@", privateObjectIDs];
            NSArray *finalResults = [IMMovie MR_findAllWithPredicate:mainPredicate];
            successBlock? successBlock(finalResults) : nil;
        });
    }];
}


@end
