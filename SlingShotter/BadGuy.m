//
//  BadGuy.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "BadGuy.h"
#import "Constants.h"

@implementation BadGuy

+(void)dropABadGuyOnScene:(SKScene *)scene {
    SKTexture *texture = [SKTexture textureWithImageNamed:@"Spaceship"];
    CGSize size = CGSizeMake(30.0, 40.0);
    BadGuy *badGuy = [[BadGuy alloc]initWithTexture:texture color:[UIColor new] size:size];
    [scene addChild:badGuy];

    badGuy.position = [badGuy randomPosition];
    [badGuy moveToKill];
}

#pragma mark - Helper Methods

//Returns a random CGPoint for originally positioning the BadGuy
-(CGPoint)randomPosition {
    CGFloat ranX = arc4random_uniform(10);
    CGFloat ranXDen = arc4random_uniform(10);
    CGFloat ranDen = ranX/ranXDen;
    ranDen = ranDen > 1.0 ? ranDen - 1.0 : ranDen;
    return CGPointMake(CGRectGetWidth(self.scene.frame) * .5, CGRectGetHeight(self.scene.frame)*.85);
}

//Adds the physicsBody, and moves the BadGuy towards the bottom
-(void)moveToKill {
    CGVector vector = CGVectorMake(2, -4);
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size
                                                       center:CGPointMake(CGRectGetMidX(self.frame),
                                                                          CGRectGetMidY(self.frame))];
    [self addBitMasks];
    self.physicsBody.dynamic = YES;
    self.physicsBody.friction = 0.1;
    self.physicsBody.affectedByGravity = false;
    [self.physicsBody applyImpulse:vector];
}

//Setup the BitMasks for the BadGuy
-(void)addBitMasks {
    self.physicsBody.categoryBitMask = kBadGuyCategory;
    self.physicsBody.collisionBitMask = kPebbleCategory | kSceneCategory;
    self.physicsBody.contactTestBitMask = kPebbleCategory | kSceneCategory;
}
@end
