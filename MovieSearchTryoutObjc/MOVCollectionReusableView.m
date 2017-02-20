//
//  MOVCollectionReusableView.m
//  PWEPnonsense
//
//  Created by Joel Bell on 5/2/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MOVCollectionReusableView.h"

@implementation MOVCollectionReusableView


-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
    
    
}

-(void)commonInit {
    
    self.button = [[UIButton alloc] init];
    
    [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.button setTitle:@"L O A D   M O R E" forState:UIControlStateNormal];
    [self.button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.2] forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    self.button.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    
    [self addSubview:self.button];
    
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.button.topAnchor constraintEqualToAnchor:self.topAnchor constant:35].active = YES;
    [self.button.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.button.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.button.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
}

-(void)buttonPressed:(UIButton *)button {
    
    if (self.delegate) {
        [self.delegate footerButtonPressed:button];
    }
    
}



@end
