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
    CGSize size = CGSizeMake(50.0, 50.0);
    BadGuy *badGuy = [[BadGuy alloc]initWithTexture:texture
                                              color:[UIColor new]
                                               size:size];
    badGuy.name = kBadGuyName;
    [scene addChild:badGuy];

    badGuy.position = [badGuy randomPosition];
    [badGuy moveToKill];
}

#pragma mark - Helper Methods

//Returns a random CGPoint for originally positioning the BadGuy
-(CGPoint)randomPosition {
    srand48(time(0));
    NSArray *xArray = @[@.75, @.50, @.85, @.65, @.95, @.45, @.25, @.90, @.10];
    NSArray *yArray = @[@.75, @.80, @.90, @.85, @.95];
    float val = [xArray[arc4random_uniform(8)]floatValue];
    float val2 = [yArray[arc4random_uniform(5)]floatValue];
    NSLog(@"val: %.0000f val2: %.0000f", val, val2);
    return CGPointMake(CGRectGetWidth(self.scene.frame) * val,
                       CGRectGetHeight(self.scene.frame) * val2);
}

-(float)randomY {
    NSArray *floatArray = @[@.75, @.80, @.90, @.85, @.95];
    return [floatArray[arc4random_uniform(5)]floatValue];
}

-(float)randomX {
    NSArray *floatArray = @[@.75, @.50, @.85, @.65, @.95, @.45, @.25, @.90, @.10];
    return [floatArray[arc4random_uniform(8)]floatValue];
}

//Adds the physicsBody, and moves the BadGuy towards the bottom
-(void)moveToKill {
    CGPoint destination = CGPointMake(CGRectGetMidX(self.frame), 0.0);
    CGVector vector = CGVectorMake(destination.x - CGRectGetMidX(self.frame),
                                   destination.y - CGRectGetMidY(self.frame));
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size
                                                       center:self.inputView.center];
    [self addBitMasks];
    self.physicsBody.dynamic = YES;
    self.physicsBody.mass = 4.0;
    self.physicsBody.friction = 5.0;
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
