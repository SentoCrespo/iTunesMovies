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

@interface DetailsMovieVC ()

@end


@implementation DetailsMovieVC

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViewController];
    
}

//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    _svContent.contentSize = _viewContent.frame.size;
//}


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
    
    _lbTitle.text       = _movie.name;
    
    _lbArtist.text      = _movie.artist;
    
    _lbCategory.text    = [NSString stringWithFormat:@"(%@)",
                        _movie.category];
    
    _lbReleaseDate.text = [NSString stringWithFormat:@"%@",
                           [_movie dateFormatted]];
    
    _lbSummary.text = _movie.summary;
    
    [_imgMovie sd_setImageWithURL:[NSURL URLWithString:_movie.image]];

}


#pragma mark - IBActions



@end

