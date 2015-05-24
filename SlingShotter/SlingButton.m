//
//  SlingButton.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/24/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "SlingButton.h"

@implementation SlingButton

-(void)prepareForInterfaceBuilder {
    [self setup];
}

-(void)awakeFromNib {
    [self setup];
}

-(void)setup {
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor yellowColor].CGColor;
    [self setTintColor:[UIColor yellowColor]];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];

}

@end
