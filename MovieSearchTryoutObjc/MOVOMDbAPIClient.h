//
//  MOVAPI.h
//  PWEPnonsense
//
//  Created by Joel Bell on 5/4/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOVConstants.h"

@interface MOVOMDbAPIClient : NSObject

+ (void)searchOMDbAPI:(NSString *)searchString
       withCompletion:(void (^)(NSDictionary *results, NSError *error))completion;

+ (void)loadNextPageOfSearchResults:(NSString *)searchString
                               page:(NSUInteger)number
                     withCompletion:(void (^)(NSDictionary *pageResults, NSError *error))completion;

+ (void)searchOMDbAPIbyID:(NSString *)imdbID
                     plot:(MoviePlotType)type
           withCompletion:(void (^)(NSDictionary *details, NSError *error))completion;



@end
