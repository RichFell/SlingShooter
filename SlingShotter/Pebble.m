//
//  Pebble.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "Pebble.h"
#import "Constants.h"

@implementation Pebble

static NSString *const kImageName = @"Pebble";
static CGFloat const kSize =        20.0;

#pragma mark - Public Class methods
+ (instancetype)placePebbleInScene:(SKScene *)scene atPoint:(CGPoint)point{
    SKTexture *texture = [SKTexture textureWithImageNamed:kImageName];
    CGSize size = CGSizeMake(kSize, kSize);
    Pebble *pebble = [[Pebble alloc]initWithTexture:texture
                                              color:[UIColor new]
                                               size:size];
    pebble.position = point;
    [scene addChild:pebble];
    return pebble;
}

#pragma mark - Public Instance methods
- (void)firePebbleFromPosition:(CGPoint)startingPosition towardsPosition:(CGPoint)endingPosition{
    CGVector vector = CGVectorMake(endingPosition.x - startingPosition.x,
                                   endingPosition.y - startingPosition.y);

    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size
                                                       center:self.inputView.center];
    self.physicsBody.mass = 0.1;
    [self addBitMasks];
    self.physicsBody.affectedByGravity = NO;
    [self.physicsBody applyImpulse:vector];
}

- (void)addBitMasks {//Add the bitmasks for the object, and the objects which to notify when it contacts.
    self.physicsBody.categoryBitMask = kPebbleCategory;
    self.physicsBody.collisionBitMask = kBadGuyCategory | kBorderCategory;
    self.physicsBody.contactTestBitMask = kBadGuyCategory | kBorderCategory;
}

@end
