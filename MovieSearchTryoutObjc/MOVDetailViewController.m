//
//  MOVDetailViewController.m
//  PWEPnonsense
//
//  Created by Joel Bell on 5/18/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MOVDetailViewController.h"
#import "MOVMovie.h"
#import "MOVDataStore.h"

@interface MOVDetailViewController()

@property (weak, nonatomic) IBOutlet UIImageView *posterBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (strong, nonatomic) UIButton *favoriteButton;


@end

@implementation MOVDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [[MOVDataStore sharedManager] searchMovieByID:self.movie plotType:ShortPlot withCompletion:^(NSError *error) {
        
        if (!error) {
            
            NSLog(@"genre: %@", self.movie.genre);
        }
        
    }];
    
    if (![self.movie.posterURL isEqualToString:@"N/A"]) {
        
        self.posterBgImageView.image = self.movie.posterImage;
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = self.posterBgImageView.bounds;
        effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.posterBgImageView addSubview:effectView];
        
        self.posterImageView.image = self.movie.posterImage;
        
    }
    
    NSInteger clipLength = 26;
    if (self.movie.title.length > clipLength) {
        self.navigationItem.title = [[NSString stringWithFormat:@"%@...", [self.movie.title substringToIndex:clipLength]] uppercaseString];
    } else {
        self.navigationItem.title = [self.movie.title uppercaseString];
    }
    
    
    
    
    
    
    
    
    NSLog(@"end of view did load");
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.favoriteButton = [[UIButton alloc] init];
    self.favoriteButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.favoriteButton setImage:[UIImage imageNamed:@"favorites"] forState:UIControlStateNormal];
    [self.favoriteButton setImage:[UIImage imageNamed:@"favoritesHighlighted"] forState:UIControlStateHighlighted];
    [self.favoriteButton addTarget:self action:@selector(didSelectFavorite:) forControlEvents:UIControlEventTouchUpInside];
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.favoriteButton];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    CGRect navFrame = self.navigationController.navigationBar.bounds;
    
    CGFloat padding = 7.0;
    CGFloat width = navFrame.size.height - padding * 2;
    
    self.favoriteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.favoriteButton.topAnchor constraintEqualToAnchor:navBar.topAnchor constant:padding].active = YES;
    [self.favoriteButton.trailingAnchor constraintEqualToAnchor:navBar.trailingAnchor constant:-(padding*1.5)].active = YES;
    [self.favoriteButton.widthAnchor constraintEqualToConstant:width].active = YES;
    [self.favoriteButton.heightAnchor constraintEqualToConstant:width].active = YES;
    
    self.favoriteButton.alpha = 0;
    
    [UIView animateWithDuration:0.6 animations:^{
        
        self.favoriteButton.alpha = 1;
        
    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.favoriteButton removeFromSuperview];
    
}

-(void)didSelectFavorite:(UIButton *)button {
    
    NSLog(@"favorite selected");
    
}




@end
