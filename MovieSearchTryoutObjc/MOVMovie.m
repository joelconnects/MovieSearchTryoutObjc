//
//  MOVMovie.m
//  PWEPnonsense
//
//  Created by Joel Bell on 5/3/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MOVMovie.h"

@implementation MOVMovie


-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    
    self = [super init];
    if (self) {
        
        [self updateMovieObjectFromDictionary:dictionary];
        
    }
    
    return self;
    
}


-(void)updateMovieObjectFromDictionary:(NSDictionary *)dictionary {
    
    self.posterURL = dictionary[@"Poster"];
    self.title = dictionary[@"Title"];
    self.type = dictionary[@"Type"];
    self.year = dictionary[@"Year"];
    self.imdbID = dictionary[@"imdbID"];
    self.placeholderImage = [UIImage imageNamed:@"defaultMovieReel"];
    

}

-(void)updateMovieObjectWithDetails:(NSDictionary *)details {
    
    self.actors = details[@"Actors"];
    self.director = details[@"Director"];
    self.genre = details[@"Genre"];
    self.metascore = details[@"Metascore"];
    self.plotShort = details[@"Plot"];
    self.rating = details[@"Rated"];
    self.writer = details[@"Writer"];
    self.imdbRating = details[@"imdbRating"];
    
    
}

-(void)getMovieImageWithCompletion:(void(^)(BOOL success))completion {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:self.posterURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.posterImage = [UIImage imageWithData:data];
        
        if (self.posterImage == nil) {
            completion(NO);
        } else {
            completion(YES);
        }
        
    }];
    
}


@end
