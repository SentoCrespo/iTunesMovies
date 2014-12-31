/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 - All rights reserved.
 *
 ******************************************************************************/

#import "IMMovie.h"

@interface IMMovie (Favorites)

#pragma mark - CRUD

#pragma mark Create

#pragma mark Read

+ (NSArray *) readAllFavoritesSortedByDate;

+ (NSInteger) readAllFavoritesCount;

#pragma mark Update

- (void) updateFavorite: (BOOL) isFavorite;

#pragma mark Delete

#pragma mark - Testing

#pragma mark - Utils

- (BOOL) isFavoriteBool;



@end
