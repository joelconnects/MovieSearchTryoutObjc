//
//  MOVCollectionViewCell.h
//  PWEPnonsense
//
//  Created by Joel Bell on 5/2/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOVMovie;

@class MOVCollectionViewCell;

@protocol MOVCollectionViewCellDelegate <NSObject>

@required

-(BOOL)canUpdateImageViewOfCell:(MOVCollectionViewCell *)cell;

@end

@interface MOVCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *placeholderImage;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieYear;
@property (strong, nonatomic) MOVMovie *movie;

@property (weak, nonatomic) id<MOVCollectionViewCellDelegate> delegate;

@end
