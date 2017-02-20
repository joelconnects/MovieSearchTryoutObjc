//
//  MOVCollectionViewController.m
//  PWEPnonsense
//
//  Created by Joel Bell on 5/2/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MOVCollectionViewController.h"
#import "MOVCollectionReusableView.h"
#import "MOVCollectionViewCell.h"
#import "MOVMovie.h"
#import "MOVDetailViewController.h"
#import "MOVDataStore.h"
#import "MOVConstants.h"

@interface MOVCollectionViewController () <MOVCollectionReusableViewDelegate, MOVCollectionViewCellDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSMutableArray *movies;
@property (strong, nonatomic) NSArray *searchTerms;
@property (strong, nonatomic) NSString *searchString;
@property (nonatomic) BOOL hideFooterView;
@property (nonatomic) CGFloat lastContentOffset;
@property (strong, nonatomic) MOVDataStore *dataStore;

@end


static NSString * const reuseIdentifier = @"MovieCell";
static const CGFloat imageRatio = 0.66;
static NSInteger const layoutSpacing = 35;
static NSInteger const footerViewHeight = 65;

@implementation MOVCollectionViewController

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    
}



#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell for item at index path: %li",indexPath.item);
    
    MOVCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MOVCollectionViewCell *movieCell = (MOVCollectionViewCell *)cell;
    movieCell.delegate = self;
    movieCell.placeholderImage.image = [UIImage imageNamed:@"moviePlaceholder"];
    BOOL dataArrayContainsMovies = [self.movies[indexPath.item] isKindOfClass:[MOVMovie class]];
    if (dataArrayContainsMovies) {
        movieCell.movie = self.movies[indexPath.item];
    }
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionFooter) {
        MOVCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        CGRect frame = footerView.frame;
        if (self.hideFooterView) {
            NSLog(@"hide footer view");
            footerView.button.hidden = YES;
            footerView.alpha = 0;
        } else {
            [footerView setFrame:CGRectMake(-layoutSpacing, frame.origin.y, self.view.bounds.size.width, footerViewHeight)];
            footerView.button.hidden = NO;
        }
        footerView.delegate = self;
        reusableView = footerView;
    }
    return reusableView;
    
}

#pragma mark <MOVCollectionViewCellDelegate>

-(BOOL)canUpdateImageViewOfCell:(MOVCollectionViewCell *)cell {
    
    if ([self.collectionView.visibleCells containsObject:cell]) {
        return YES;
    }
    return NO;

}

#pragma mark - Segue

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:DetailSegueIdentifier sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepare for segue");
    
    MOVDetailViewController *detailVC = (MOVDetailViewController *)segue.destinationViewController;
    NSIndexPath *path = [[self.collectionView indexPathsForSelectedItems] firstObject];
    detailVC.movie = self.movies[path.item];
    
}

#pragma mark - Search/Load Actions

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"search bar text: %@",searchBar.text);
    if (searchBar.text.length > 1) {
        self.searchString = searchBar.text;
        [self.dataStore searchForMovies:self.searchString withCompletion:^(BOOL isLastPage, NSError *error) {
            self.hideFooterView = (isLastPage) ? YES : NO;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.collectionView reloadData];
            }];
        }];
    }
    [searchBar resignFirstResponder];
}

-(void)footerButtonPressed:(UIButton *)button {
    
    NSLog(@"delegate method - footer button pressed");
    [self.dataStore loadMoreMovies:self.searchString withCompletion:^(BOOL isLastPage, NSError *error) {
        if (isLastPage) { self.hideFooterView = YES; }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

#pragma mark - Set Up

-(void)setUp {
    
    // Initial random search terms
    self.searchTerms = @[@"horror",
                         @"love",
                         @"space",
                         @"adventures",
                         @"night",
                         @"star",
                         @"show",
                         @"west",
                         @"man",
                         @"girl",
                         @"time",
                         @"blood"];
    
    // Set footer view to be unhidden
    self.hideFooterView = YES;
    
    // Add background image with blur effect
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.alpha = 1.0;
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.clipsToBounds = YES;
    self.collectionView.backgroundView = backgroundImageView;
    backgroundImageView.image = [UIImage imageNamed:@"movieMarquee"];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.collectionView.bounds;
    effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [backgroundImageView addSubview:effectView];
    
    // Layout collection view
    self.collectionView.contentInset = UIEdgeInsetsMake(layoutSpacing, layoutSpacing, 0, layoutSpacing);
    self.flowLayout.minimumLineSpacing = layoutSpacing;
    self.flowLayout.minimumInteritemSpacing = layoutSpacing;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = (screenWidth / 2) - (self.flowLayout.minimumInteritemSpacing / 2) - layoutSpacing;
    CGFloat itemHeight = itemWidth / imageRatio;
    self.flowLayout.itemSize = CGSizeMake(itemWidth,itemHeight);
    self.flowLayout.footerReferenceSize = CGSizeMake(screenWidth, footerViewHeight);
    
    // Add search bar to nav bar
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    // Initialize and assign dataStore to property
    self.dataStore = [MOVDataStore sharedManager];
    
    // Give local data array default NSNumbers to use until movie objects are received
    self.movies = [@[@1, @2, @3, @4] mutableCopy];
    
    // Perform an initial random search from self.searchTerms
    NSUInteger randomNumber = arc4random_uniform((u_int32_t)self.searchTerms.count);
    self.searchString = self.searchTerms[randomNumber];
    [self.dataStore searchForMovies:self.searchString withCompletion:^(BOOL isLastPage, NSError *error) {
        
        if (!error && self.dataStore.movieSearchResults > 0) {
            self.hideFooterView = (isLastPage) ? YES : NO;
            BOOL hasNumberObjects = [self.movies[0] isKindOfClass:[NSNumber class]];
            if (hasNumberObjects) {
                [self.movies removeAllObjects];
            }
            self.movies = self.dataStore.movieSearchResults;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.collectionView reloadData];
            }];
        }
    }];
    
}


@end


