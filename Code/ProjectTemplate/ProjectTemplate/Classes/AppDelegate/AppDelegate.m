/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "AppDelegate.h"

#import "UIKit+AFNetworking.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // It would be nice to include in a real world app something that:
    // * Defines the environment [dev | prod].
    // * If it's prod, doesn't print any NSLog to the console.
    // * ManagerAPI is based on it to fetch the urls.
    
 
    // Core Data
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelError];
    
    
    // Shows Internet Activity indicator when AFNetworking is doing tasks
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // Version tracking
    [GBVersionTracking track];
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
}

@end
