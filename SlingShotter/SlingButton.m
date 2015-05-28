//
//  SlingButton.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/24/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
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
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor redColor].CGColor;
    [self setTintColor:[UIColor redColor]];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue"
                                           size:25.0];
    self.backgroundColor = [UIColor blackColor];
}

@end
