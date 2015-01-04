/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import <UIKit/UIKit.h>

@interface DetailsMovieVC : UIViewController

#pragma mark - Properties

@property (nonatomic, strong) IMMovie *movie;


#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btFavorite;

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;

@property (weak, nonatomic) IBOutlet UIScrollView *svContent;
@property (weak, nonatomic) IBOutlet UIView *viewContent;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbArtist;
@property (weak, nonatomic) IBOutlet UIImageView *imgMovie;
@property (weak, nonatomic) IBOutlet UILabel *lbCategory;
@property (weak, nonatomic) IBOutlet UILabel *lbReleaseDate;

@property (weak, nonatomic) IBOutlet UILabel *lbSummary;


#pragma mark - IBActions

- (IBAction)btFavoriteTap:(UIBarButtonItem *)sender;

@end
