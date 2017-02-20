//
//  MOVAPI.m
//  PWEPnonsense
//
//  Created by Joel Bell on 5/4/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MOVOMDbAPIClient.h"
#import "MOVMovie.h"

@implementation MOVOMDbAPIClient

+ (void)searchOMDbAPI:(NSString *)searchString withCompletion:(void (^)(NSDictionary *, NSError *))completion
{
    
    NSString *query = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = @"https://www.omdbapi.com/?s=";
    NSString *movieType = @"&type=movie";
    NSString *urlStringWithQuery = [NSString stringWithFormat:@"%@%@%@", urlString, query, movieType];
    
    NSURL *url = [NSURL URLWithString:urlStringWithQuery];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completion([NSJSONSerialization JSONObjectWithData:data options:0 error:nil], error);
        
    }];
    
    [task resume];
    
}

+ (void)loadNextPageOfSearchResults:(NSString *)searchString
                               page:(NSUInteger)number
                     withCompletion:(void (^)(NSDictionary *, NSError *))completion
{

    NSString *query = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlString = @"https://www.omdbapi.com/?s=";
    NSString *movieType = @"&type=movie";
    NSString *pageNumber = [NSString stringWithFormat:@"&page=%lu",number];
    NSString *urlStringWithQuery = [NSString stringWithFormat:@"%@%@%@%@", urlString, query, movieType, pageNumber];
    
    NSURL *url = [NSURL URLWithString:urlStringWithQuery];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completion([NSJSONSerialization JSONObjectWithData:data options:0 error:nil], error);
        
    }];
    
    [task resume];

}

+ (void)searchOMDbAPIbyID:(NSString *)imdbID
                     plot:(MoviePlotType)type
           withCompletion:(void (^)(NSDictionary *, NSError *))completion {
    
    NSString *plotType;
    if (type == ShortPlot) {
        plotType = @"short";
    } else {
        plotType = @"full";
    }
    
    NSString *urlString = @"https://www.omdbapi.com/?i=";
    NSString *plot = @"&plot=";
    NSString *json = @"&r=json";
    NSString *urlStringWithParams = [NSString stringWithFormat:@"%@%@%@%@%@", urlString, imdbID, plot, plotType, json];
    
    NSURL *url = [NSURL URLWithString:urlStringWithParams];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completion([NSJSONSerialization JSONObjectWithData:data options:0 error:nil], error);
        
    }];
    
    [task resume];
    
}




@end
