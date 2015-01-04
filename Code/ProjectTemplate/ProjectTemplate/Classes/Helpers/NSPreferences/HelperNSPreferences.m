/******************************************************************************
 *
 * Helpers
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * All rights reserved
 *
 ******************************************************************************/

#import "HelperNSPreferences.h"


@interface HelperNSPreferences()

+ (NSString *) returnEmptyStringOrString: (NSString *) string;

@end


@implementation HelperNSPreferences


#pragma mark -
#pragma mark Get/Set Objects

// NSNumber
+ (NSNumber *) getNumberForKey: (NSString *) key {
    return (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void) setNSNumber: (NSNumber *) value
              forKey: (NSString *) key {
    [[NSUserDefaults standardUserDefaults] setObject:value
                                              forKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// NSString
+ (NSString *) getNSStringForKey: (NSString *) key {
    
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [self returnEmptyStringOrString:result];
}

+ (void) setNSString: (NSString *) value
              forKey: (NSString *) key {
    [[NSUserDefaults standardUserDefaults] setObject:value
                                              forKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}



// BOOL
+ (BOOL) getBoolForKey: (NSString *) key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


+ (void) setBOOL: (BOOL) value
          forKey: (NSString *) key {
    [[NSUserDefaults standardUserDefaults] setBool:value
                                            forKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


// NSInteger
+ (NSInteger) getIntegerForKey: (NSString *) key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (void) setInteger: (NSInteger) value
          forKey: (NSString *) key {
    [[NSUserDefaults standardUserDefaults] setInteger:value
                                            forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// NSDate
+ (NSDate *) getDateForKey: (NSString *) key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void) setDate: (NSDate *) value
          forKey: (NSString *) key
{
    [[NSUserDefaults standardUserDefaults] setObject:value
                                              forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}


#pragma mark - General

+ (void) removeObjectForKey: (NSString *) key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark Clear All preferences
+ (void) clearAllPreferences {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -
#pragma mark NSString treatment
+ (NSString *) returnEmptyStringOrString: (NSString *) string {
    
    if (string == nil){
        return @"";
    }
    
    return string;
}



@end
