//
//  MOVDetailViewController.h
//  PWEPnonsense
//
//  Created by Joel Bell on 5/18/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOVMovie;
@class MOVDataStore;

@interface MOVDetailViewController : UIViewController

@property (strong, nonatomic) MOVMovie *movie;

@end
