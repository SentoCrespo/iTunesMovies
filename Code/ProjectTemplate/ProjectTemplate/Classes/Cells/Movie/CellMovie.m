/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "CellMovie.h"

#import "UIImageView+WebCache.h"

@interface CellMovie ()

    @property (nonatomic, strong) IMMovie *movie;

@end

@implementation CellMovie


#pragma mark - Methods

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [_imgMovie sd_cancelCurrentImageLoad];
}



- (void) configureCellWithItem: (IMMovie *) item
                  forIndexPath: (NSIndexPath *) indexPath
{
    _movie = item;
    _lbTitle.text = item.name;
    
    [_imgMovie sd_setImageWithURL:[NSURL URLWithString:item.image]
                     placeholderImage:[UIImage imageNamed:@"movieReel"]];
    
}



- (IBAction)btDeleteTap:(UIButton *)sender
{
    
    WEAKSELF(wS);
    
    [HelperShowAlert ShowConfirmationDialogWithTitle:STR(@"DELETE_CONFIRMATION_TITLE")
                                                Text:STR(@"DELETE_CONFIRMATION_TEXT")
                                         AcceptLabel:STR(@"DELETE")
                                         CancelLabel:STR(@"CANCEL")
                                           didAccept:^{
                                               [wS.movie deleteItem];
                                           } didCancel:nil];
    
}



@end
