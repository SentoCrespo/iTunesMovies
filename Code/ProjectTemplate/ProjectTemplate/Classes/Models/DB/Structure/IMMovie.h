/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface IMMovie : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSNumber * isFavorite;

@end
