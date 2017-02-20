//
//  MOVMovie.h
//  PWEPnonsense
//
//  Created by Joel Bell on 5/3/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MOVMovie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *posterURL;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *imdbID;

@property (strong, nonatomic) NSString *actors;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *writer;
@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) NSString *rating;

@property (strong, nonatomic) NSString *metascore;
@property (strong, nonatomic) NSString *imdbRating;

@property (strong, nonatomic) NSString *plotShort;
@property (strong, nonatomic) NSString *plotFull;

@property (strong, nonatomic) UIImage *placeholderImage;
@property (strong, nonatomic) UIImage *posterImage;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(void)getMovieImageWithCompletion:(void(^)(BOOL success))completion;
-(void)updateMovieObjectWithDetails:(NSDictionary *)details;



@end
