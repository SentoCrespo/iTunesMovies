/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/

#import <UIKit/UIKit.h>

@interface ListMoviesVC : UICollectionViewController


#pragma mark - Properties



#pragma mark - Outlets

@property (weak, nonatomic) IBOutlet UISegmentedControl *scSelector;


#pragma mark - Actions

- (IBAction)scSelectorChanged:(UISegmentedControl *)sender;

- (IBAction)btRefreshTap:(UIBarButtonItem *)sender;


#pragma mark - Methods




@end
