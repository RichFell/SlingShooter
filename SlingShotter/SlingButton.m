//
//  SlingButton.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/24/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "SlingButton.h"

IB_DESIGNABLE
@implementation SlingButton

-(void)prepareForInterfaceBuilder {
    [self setup];
}

-(void)awakeFromNib {
    [self setup];
}

-(void)setup {
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    [self setTintColor:[UIColor blackColor]];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
    self.backgroundColor = [UIColor whiteColor];
}

@end
