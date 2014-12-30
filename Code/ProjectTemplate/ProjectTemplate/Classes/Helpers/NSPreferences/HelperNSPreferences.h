/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>



@interface HelperNSPreferences : NSObject

#pragma mark -
#pragma mark Get/Set Objects

// NSNumber
+ (NSNumber *) getNumberForKey: (NSString *) key;

+ (void) setNSNumber: (NSNumber *) value
              forKey: (NSString *) key;

// NSString
+ (NSString *) getNSStringForKey: (NSString *) key;

+ (void) setNSString: (NSString *) value
              forKey: (NSString *) key;

// BOOL
+ (BOOL) getBoolForKey: (NSString *) key;

+ (void) setBOOL: (BOOL) value
          forKey: (NSString *) key;

// NSInteger
+ (NSInteger) getIntegerForKey: (NSString *) key;

+ (void) setInteger: (NSInteger) value
             forKey: (NSString *) key;

// NSDate
+ (NSDate *) getDateForKey: (NSString *) key;

+ (void) setDate: (NSDate *) value
          forKey: (NSString *) key;

#pragma mark - General
+ (void) removeObjectForKey: (NSString *) key;

#pragma mark - Clear All preferences
+ (void) clearAllPreferences;


@end
