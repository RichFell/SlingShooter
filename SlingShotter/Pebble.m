//
//  Pebble.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Pebble.h"
#import "Constants.h"

@implementation Pebble

+(void)pebbleInScene:(SKScene *)scene fromPosition:(CGPoint)position withForce:(CGFloat)force inDirection:(CGPoint)direction{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"Spaceship"];
    CGSize size = CGSizeMake(CGRectGetWidth(scene.frame)/30, CGRectGetWidth(scene.frame)/30);
    Pebble *pebble = [[Pebble alloc]initWithTexture:texture color:[UIColor new] size:size];
    pebble.name = kPebbleName;
    pebble.position = direction;
    [scene addChild:pebble];
    [pebble firePebbleFromPosition:position towardsPosition:direction];
}

-(void)firePebbleFromPosition:(CGPoint)startingPosition towardsPosition:(CGPoint)endingPosition{
    CGVector vector = CGVectorMake(startingPosition.x - endingPosition.x,
                                   startingPosition.y - endingPosition.y);

    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size
                                                       center:self.inputView.center];
//    self.physicsBody.friction = 0.0;
    self.physicsBody.mass = 0.1;
//    self.physicsBody.velocity = vector;
    [self addBitMasks];
    self.physicsBody.affectedByGravity = NO;
    [self.physicsBody applyImpulse:vector];
}

-(void)addBitMasks {
    self.physicsBody.categoryBitMask = kPebbleCategory;
    self.physicsBody.collisionBitMask = kBadGuyCategory | kSceneCategory;
    self.physicsBody.contactTestBitMask = kBadGuyCategory | kSceneCategory;
}

@end
