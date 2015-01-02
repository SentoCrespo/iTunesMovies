/******************************************************************************
 *
 * iTunes Movies
 *
 * Created by Vicente Crespo Penadés - vicente.crespo.penades@gmail.com
 * Copyright (c) 2015 Vicente Crespo  All rights reserved.
 *
 ******************************************************************************/

#import "ListMoviesVC.h"

#import "CellMovie.h"

#import "ManagerMovies.h"

@interface ListMoviesVC () <NSFetchedResultsControllerDelegate>

    @property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
    @property (strong, nonatomic) NSMutableArray *objectChanges;
    @property (strong, nonatomic) NSMutableArray *sectionChanges;

    @property (strong, nonatomic) UILabel *lbEmpty;

@end


@implementation ListMoviesVC


#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViewController];
    
    ManagerMovies *managerMovies = [ManagerMovies new];
    [managerMovies storeMovies:^{

    } failureBlock:^(NSError *error) {
        ;
    } completionBlock:^{
        [_cvContent reloadData];
    }];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self fetchedResultsController];
    [_cvContent reloadData];
    [_parentController.navigationController setNavigationBarHidden:NO
                                                          animated:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"Memory warning (%@)", NSStringFromClass(self.class));
}



#pragma mark - Status Bar

- (BOOL)prefersStatusBarHidden { return NO; }

- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation { return UIStatusBarAnimationFade; }

#pragma mark - Initialization

- (void) initViewController
{
    
    [self initVariables];
    [self translation];
    [self initUI];
    
}

#pragma mark Variable init

- (void) initVariables
{
    _objectChanges  = [NSMutableArray array];
    _sectionChanges = [NSMutableArray array];
}


#pragma mark Translation

- (void) translation
{
    self.title = STR(@"LATEST_MOVIES_TITLE_TAB");
    self.navigationItem.title = STR(@"LATEST_MOVIES_TITLE");
    
}


#pragma mark UI Initialization

- (void) initUI
{
    [self addImageToLeftInNavigationBar:[UIImage imageNamed:@"movieReel"]];
}




#pragma mark - UICollectionVIew

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (!self.fetchedResultsController){
        return 1;
    }
    
    return self.fetchedResultsController.sections.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(90,150);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.fetchedResultsController){
        return 0;
    }
    
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    NSInteger numberOfObjects = [sectionInfo numberOfObjects];
    return numberOfObjects;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellMovie *cell = (CellMovie *)[collectionView dequeueReusableCellWithReuseIdentifier:CellMovieIdentifier
                                                                         forIndexPath:indexPath];
    
    IMMovie *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell configureCellWithItem:item
                   forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    IMMovie *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
#warning TODO: Complete action to show details
    
}






#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    
    // Check for empty datasource
    if (![IMMovie readAllCount]) {
        
        if (!_lbEmpty) {
            _lbEmpty = [[UILabel alloc] initForAutoLayout];
            _lbEmpty.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f];
            _lbEmpty.numberOfLines = 0;
            _lbEmpty.text = STR(@"NO_DATA");
            [self.view addSubview:_lbEmpty];
            [_lbEmpty autoCenterInSuperview];
            [_lbEmpty autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0 relation:NSLayoutRelationGreaterThanOrEqual];
            [_lbEmpty autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0 relation:NSLayoutRelationGreaterThanOrEqual];
        }
        
        [self.view bringSubviewToFront:_lbEmpty];
        return nil;
    }
    
    [self.view sendSubviewToBack:_lbEmpty];
    
    
    
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [IMMovie MR_requestAllSortedBy:@"name"
                                                        ascending:YES];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:10];
    
    
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:[NSManagedObjectContext MR_defaultContext]
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    
    _fetchedResultsController = aFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error performing fetch: %@", error);
        return nil;
    }
    
    return _fetchedResultsController;
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = @(sectionIndex);
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = @(sectionIndex);
            break;
        default:
            break;
    }
    
    [_sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    NSMutableDictionary *change = [NSMutableDictionary new];
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_objectChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if ([_sectionChanges count] > 0) {
        [self.collectionView performBatchUpdates:^{
            for (NSDictionary *change in _sectionChanges) {
                [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                    
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type) {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                            break;
                        default:
                            break;
                    }
                }];
            }
        } completion:nil];
    }
    
    if ([_objectChanges count] > 0 && [_sectionChanges count] == 0) {
        
        if ([self shouldReloadCollectionViewToPreventKnownIssue] || self.collectionView.window == nil) {
            // This is to prevent a bug in UICollectionView from occurring.
            // The bug presents itself when inserting the first object or deleting the last object in a collection view.
            // http://stackoverflow.com/questions/12611292/uicollectionview-assertion-failure
            // This code should be removed once the bug has been fixed, it is tracked in OpenRadar
            // http://openradar.appspot.com/12954582
            [self.collectionView reloadData];
            
        } else {
            
            [self.collectionView performBatchUpdates:^{
                
                for (NSDictionary *change in _objectChanges) {
                    [change enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, id obj, BOOL *stop) {
                        
                        NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                        switch (type) {
                            case NSFetchedResultsChangeInsert:
                                [self.collectionView insertItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeDelete:
                                [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeUpdate:
                                [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                                break;
                            case NSFetchedResultsChangeMove:
                                [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                                break;
                        }
                    }];
                }
            } completion:nil];
        }
    }
    
    [_sectionChanges removeAllObjects];
    [_objectChanges removeAllObjects];
}

- (BOOL)shouldReloadCollectionViewToPreventKnownIssue {
    __block BOOL shouldReload = NO;
    for (NSDictionary *change in self.objectChanges) {
        [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSFetchedResultsChangeType type = [key unsignedIntegerValue];
            NSIndexPath *indexPath = obj;
            switch (type) {
                case NSFetchedResultsChangeInsert:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 0) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeDelete:
                    if ([self.collectionView numberOfItemsInSection:indexPath.section] == 1) {
                        shouldReload = YES;
                    } else {
                        shouldReload = NO;
                    }
                    break;
                case NSFetchedResultsChangeUpdate:
                    shouldReload = NO;
                    break;
                case NSFetchedResultsChangeMove:
                    shouldReload = NO;
                    break;
            }
        }];
    }
    
    return shouldReload;
}



@end
