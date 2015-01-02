/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/

#import <UIKit/UIKit.h>



static NSString *CellMovieIdentifier = @"CellMovie";


@interface CellMovie : UICollectionViewCell


#pragma mark - Outlets

@property (weak, nonatomic) IBOutlet UIView *viewContent;

@property (weak, nonatomic) IBOutlet UIImageView *imgMovie;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UIButton *btFavorite;

#pragma mark - IBActions

- (IBAction)btDeleteTap:(UIButton *)sender;



#pragma mark - Methods


- (void) configureCellWithItem: (IMMovie *) item
                  forIndexPath: (NSIndexPath *) indexPath;





@end
