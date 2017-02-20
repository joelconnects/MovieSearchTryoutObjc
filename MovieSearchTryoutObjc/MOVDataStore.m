//
//  MOVDataStore.m
//  PWEPnonsense
//
//  Created by Joel Bell on 5/14/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MOVDataStore.h"
#import "MOVOMDbAPIClient.h"
#import "MOVMovie.h"

@implementation MOVDataStore

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MOVDataStore *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _movieSearchResults = [NSMutableArray new];
        
    }
    return self;
}


#pragma mark Search & Load Methods

- (void)searchForMovies:(NSString *)searchString withCompletion:(void(^)(BOOL, NSError *))completion {
        
    [MOVOMDbAPIClient searchOMDbAPI:searchString withCompletion:^(NSDictionary *results, NSError *error) {
        
        [self.movieSearchResults removeAllObjects];
        
        self.totalSearchResults = [results[@"totalResults"] integerValue];
        
        NSArray *resultsArray = results[@"Search"];
        
        for (NSDictionary *dictionary in resultsArray) {
            
            MOVMovie *movie = [[MOVMovie alloc] initWithDictionary:dictionary];
            
            [self.movieSearchResults addObject:movie];
            
        }
        
        BOOL isLastPage = (self.totalSearchResults / 10) < 1;
        
        completion(isLastPage, error);
        
    }];
    
    
}

- (void)loadMoreMovies:(NSString *)searchString withCompletion:(void(^)(BOOL, NSError *))completion {
    
    NSUInteger pageNumber = (self.movieSearchResults.count / 10) + 1;
    
    BOOL isLastPage = (self.totalSearchResults - self.movieSearchResults.count) < 10;
    
    [MOVOMDbAPIClient loadNextPageOfSearchResults:searchString
                                             page:pageNumber
                                   withCompletion:^(NSDictionary *pageResults, NSError *error) {
                                       
           NSArray *resultsArray = pageResults[@"Search"];
           
           for (NSDictionary *dictionary in resultsArray) {
               
               MOVMovie *movie = [[MOVMovie alloc] initWithDictionary:dictionary];
               
               [self.movieSearchResults addObject:movie];
               
           }
                                       
           completion(isLastPage, error);
                                       
    }];
    
    
}

- (void)searchMovieByID:(MOVMovie *)movie plotType:(MoviePlotType)type withCompletion:(void (^)(NSError *))completion
{
    
    MOVMovie *movieToUpdate = movie;
    
        [MOVOMDbAPIClient searchOMDbAPIbyID:movie.imdbID plot:type withCompletion:^(NSDictionary *details, NSError *error) {
            
            [movieToUpdate updateMovieObjectWithDetails:details];
            
            completion(error);
            
        }];
    
}



@end
