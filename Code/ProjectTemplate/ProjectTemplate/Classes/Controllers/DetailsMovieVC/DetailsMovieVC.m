/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "DetailsMovieVC.h"

#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"


@interface DetailsMovieVC ()

@end


@implementation DetailsMovieVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViewController];
    

}


- (void)viewDidLayoutSubviews
{
    // Adjust the scrollview y0
    CGFloat topBarOffset = self.topLayoutGuide.length;
    _svContent.contentInset = UIEdgeInsetsMake(topBarOffset, 0, 0, 0);
}

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
    
    [self fillMovieData];
    
    [self setFavoriteStatus];
    
    [self fillBackgroundBlurredImage];

}


#pragma mark - Data Fill

- (void) fillMovieData
{
    _lbTitle.text       = _movie.name;
    _lbArtist.text      = _movie.artist;
    _lbCategory.text    = [NSString stringWithFormat:@"(%@)",
                           _movie.category];
    _lbReleaseDate.text = [NSString stringWithFormat:@"%@",
                           [_movie dateFormatted]];
    _lbSummary.text = _movie.summary;
    [_imgMovie sd_setImageWithURL:[NSURL URLWithString:_movie.image]];
}

- (void) setFavoriteStatus
{
    UIImage *btImage = [_movie imageFavorite];
    [_btFavorite setImage:btImage];
}

- (void) fillBackgroundBlurredImage
{
    WEAKSELF(wS);
    [_imgBackground sd_setImageWithURL:[NSURL URLWithString:_movie.image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIImage *newImage = [image resizedImage:_imgBackground.size
                           interpolationQuality:kCGInterpolationHigh];
        
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = _imgBackground.bounds;
        
        wS.imgBackground.image = newImage;
        
        [wS.imgBackground addSubview:visualEffectView];
        
    }];

}

#pragma mark - IBActions



- (IBAction)btFavoriteTap:(UIBarButtonItem *)sender
{
    [_movie updateFavorite:![_movie isFavoriteBool]];
    [_btFavorite setImage:[_movie imageFavorite]];
}
@end

