//
//  SlingShot.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "SlingShot.h"
#import "Pebble.h"
#import "Constants.h"

@implementation SlingShot

#pragma mark - Class Initializer
+(instancetype)slingshotInRect:(CGRect)rect{

    SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed: @"Slingshot"]];
    CGSize size = CGSizeMake(80.0, 140.0);

    SlingShot *slingshot = [[SlingShot alloc]initWithTexture:texture color:[UIColor new] size:size];
    slingshot.position = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect)/6);
    return slingshot;
}

#pragma mark - Instance Methods
-(void)firePebbleFromPosition:(CGPoint)fromPosition {
    [Pebble pebbleInScene:self.scene
                              fromPosition:CGPointMake(CGRectGetMidX(self.frame),
                                                       CGRectGetMidY(self.frame))
                                 withForce:1.0
                               inDirection:fromPosition];
    
}

@end
