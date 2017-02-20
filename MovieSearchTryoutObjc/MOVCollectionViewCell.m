//
//  MOVCollectionViewCell.m
//  PWEPnonsense
//
//  Created by Joel Bell on 5/2/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MOVCollectionViewCell.h"
#import "MOVMovie.h"

@implementation MOVCollectionViewCell

-(void)setMovie:(MOVMovie *)movie {
    
    _movie = movie;
    
    [self resetCell];
    
    if ([movie.posterURL isEqualToString:@"N/A"]) {
        self.movieTitle.text = movie.title;
        self.movieYear.text = movie.year;
        
    } else if (movie.posterImage == nil) {
        
        [movie getMovieImageWithCompletion:^(BOOL success) {
            
            if (success && [self.delegate canUpdateImageViewOfCell:self]) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    self.movieImageView.alpha = 0;
                    self.movieImageView.image = movie.posterImage;
                    
                    [UIView animateWithDuration:0.7 animations:^{
                        self.movieImageView.alpha = 1;
                    }];
                }];
            
            }
            
        }];
 
    } else {
        
        self.movieImageView.image = movie.posterImage;
        
    }

}

-(void)resetCell {
    self.movieImageView.image = nil;
    self.movieTitle.text = nil;
    self.movieYear.text = nil;
}


@end
