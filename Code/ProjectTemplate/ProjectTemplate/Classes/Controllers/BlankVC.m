/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/



#import "BlankVC.h"

@interface BlankVC ()

@end


@implementation BlankVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViewController];
    
}

#pragma mark - Status Bar

- (BOOL)prefersStatusBarHidden { return NO; }

- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation { return UIStatusBarAnimationFade; }


#pragma mark - Init

- (void) initViewController
{
    [self initVariables];
    [self translate];
    [self initUI];
}


- (void) initVariables
{
    
}

- (void) translate
{
    
    
}

- (void) initUI
{

}


#pragma mark - IBActions



@end

