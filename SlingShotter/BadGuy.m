//
//  BadGuy.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "BadGuy.h"
#import "Constants.h"
#import "CollisionManager.h"

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
    srand48(time(0));
    float val = drand48();
    float val2 = (((float) rand() / RAND_MAX) * .25) + .75;;
    NSLog(@"val: %.0000f val2: %.0000f", val, val2);
    return CGPointMake(CGRectGetWidth(self.scene.frame) * val, CGRectGetHeight(self.scene.frame) * val2);
}

//Adds the physicsBody, and moves the BadGuy towards the bottom
-(void)moveToKill {
    CGVector vector = CGVectorMake(-2, -2);
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
