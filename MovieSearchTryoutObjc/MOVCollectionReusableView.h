//
//  MOVCollectionReusableView.h
//  PWEPnonsense
//
//  Created by Joel Bell on 5/2/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOVCollectionReusableView;

@protocol MOVCollectionReusableViewDelegate <NSObject>

-(void)footerButtonPressed:(UIButton *)button;

@end


@interface MOVCollectionReusableView : UICollectionReusableView


@property (weak, nonatomic) id<MOVCollectionReusableViewDelegate> delegate;
@property (strong, nonatomic) UIButton *button;


@end
