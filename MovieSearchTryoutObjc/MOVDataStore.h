//
//  MOVDataStore.h
//  PWEPnonsense
//
//  Created by Joel Bell on 5/14/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOVConstants.h"

@class MOVMovie;
@class MOVOMDbAPIClient;

@interface MOVDataStore : NSObject

@property (nonatomic, strong) NSMutableArray *movieSearchResults;
@property (nonatomic, assign) NSUInteger totalSearchResults;

+ (id)sharedManager;

- (void)searchForMovies:(NSString *)searchString withCompletion:(void(^)(BOOL isLastPage, NSError *error))completion;
- (void)loadMoreMovies:(NSString *)searchString withCompletion:(void(^)(BOOL isLastPage, NSError *error))completion;
- (void)searchMovieByID:(MOVMovie *)movie plotType:(MoviePlotType)type withCompletion:(void (^)(NSError *error))completion;

@end
