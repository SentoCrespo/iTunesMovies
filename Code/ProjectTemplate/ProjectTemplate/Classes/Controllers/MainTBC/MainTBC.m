/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "MainTBC.h"

#import "ListMoviesVC.h"

@interface MainTBC ()

@end

@implementation MainTBC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    
    [self styleTabBar];
    [self initViewControllers];

    [self setSelectedIndex:0];
}



#pragma mark - Init

- (void) styleTabBar
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                             forState:UIControlStateSelected];
}

- (void) initViewControllers
{
   
    for (UINavigationController *v in self.viewControllers) {
        
        UIViewController *vc = [v.viewControllers firstObject];
        
        
        if ([vc isKindOfClass:ListMoviesVC.class]) {

            ListMoviesVC *listMoviesVC = (ListMoviesVC *)vc;
            
            listMoviesVC.title = STR(@"LATEST_TITLE");
            listMoviesVC.parentController = self;
        }
        
#warning TODO: Second controller
              
    }

}




@end
