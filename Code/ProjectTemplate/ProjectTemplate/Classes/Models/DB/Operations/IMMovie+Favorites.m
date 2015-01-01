/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 - All rights reserved.
 *
 ******************************************************************************/

#import "IMMovie+Favorites.h"

@implementation IMMovie (Favorites)

#pragma mark - CRUD


#pragma mark Create



#pragma mark Read

+ (NSArray *) readAllFavoritesSortedByDate
{
    NSArray *items = [IMMovie MR_findByAttribute:@"isFavorite"
                                       withValue:@(YES)
                                      andOrderBy:@"date"
                                       ascending:NO];
    return items;
}

+ (NSInteger) readAllFavoritesCount;
{
    return [self readAllFavoritesSortedByDate].count;
}




#pragma mark Update

- (void) updateFavorite: (BOOL) isFavorite
{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        IMMovie *localItem = [self MR_inContext:localContext];
        localItem.isFavorite = @(isFavorite);
    }];
    
}

- (void) updateFavorite: (BOOL) isFavorite
           successBlock: (void(^)(void)) successBlock
           failureBlock: (void(^)(NSError *error)) failureBlock
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {

        IMMovie *localItem = [self MR_inContext:localContext];
        localItem.isFavorite = @(isFavorite);
        
    } completion:^(BOOL contextDidSave, NSError *error) {
        if (error) {
            failureBlock? failureBlock(error) : nil;
            return;
        }
        successBlock? successBlock() : nil;
    }];
}



#pragma mark Delete


#pragma mark - Testing


#pragma mark - Utils

- (BOOL) isFavoriteBool
{
    return [self.isFavorite boolValue];
}


@end