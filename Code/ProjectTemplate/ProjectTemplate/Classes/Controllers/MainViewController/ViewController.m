/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/


#import "ViewController.h"

#import "ManagerParseXML.h"


@interface ViewController ()

    @property (nonatomic, strong) ManagerParseXML *managerParse;

@end


@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self testRss];
}


- (void) testRss
{
#warning Delete
    _managerParse = [ManagerParseXML new];
    [_managerParse parseMoviesXML:^(id data) {
        [IMMovie createFromArray:data
                    successBlock:^{

                    } failureBlock:^(NSError *error) {
                        ;
                    }];
    } failureBlock:^(NSError *error) {
        ;
    } completionBlock:^{
        ;
    }];
}







@end
