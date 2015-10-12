//
//  BadGuy.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "BadGuy.h"
#import "Constants.h"
#import "CollisionManager.h"

@implementation BadGuy

static CGFloat const kSize =        70.0;
static NSString *const kImageOne =  @"MyCrow";
static NSString *const kImageTwo =  @"MyCrow2";

+ (void)dropABadGuyOnScene:(SKScene *)scene {
    SKTexture *texture = [SKTexture textureWithImageNamed:kImageOne];
    CGSize size = CGSizeMake(kSize, kSize);
    BadGuy *badGuy = [[BadGuy alloc]initWithTexture:texture
                                              color:[UIColor new]
                                               size:size];
    badGuy.name = kBadGuyName;
    [badGuy startAnimation];
    [scene addChild:badGuy];
    badGuy.position = [badGuy randomPosition];
    [badGuy moveToKill];
}

#pragma mark - Helper Methods

//Returns a random CGPoint for originally positioning the BadGuy
- (CGPoint)randomPosition {
    float width = CGRectGetWidth(self.frame);
    float val = arc4random_uniform(width)/width;
    return CGPointMake(CGRectGetWidth(self.scene.frame) * val,
                       CGRectGetHeight(self.scene.frame));
}

//Adds the physicsBody, and moves the BadGuy towards the bottom
- (void)moveToKill {
    CGPoint destination = CGPointMake(CGRectGetMidX(self.frame), 0.0);
    CGVector vector = CGVectorMake(destination.x - CGRectGetMidX(self.frame),
                                   destination.y - CGRectGetMidY(self.frame));
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size
                                                       center:self.inputView.center];
    [self addBitMasks];
    self.physicsBody.dynamic = YES;
    self.physicsBody.mass =(float)2 + arc4random_uniform(5 - 2 + 1);
    self.physicsBody.friction = 1.0;
    self.physicsBody.affectedByGravity = NO;
    [self.physicsBody applyImpulse:vector];
}

//Animation loop to show like the bird is flying
- (void)startAnimation {
    SKTexture *startingTexture = [SKTexture textureWithImageNamed:kImageOne];
    SKTexture *secondTexture = [SKTexture textureWithImageNamed:kImageTwo];
    SKAction *runAction = [SKAction animateWithTextures:@[startingTexture, secondTexture]
                                           timePerFrame:0.4];
    [self runAction:[SKAction repeatActionForever:runAction]];
}

//Setup the BitMasks for the BadGuy
- (void)addBitMasks {
    self.physicsBody.categoryBitMask =      kBadGuyCategory;
    self.physicsBody.collisionBitMask =     kPebbleCategory | kBorderCategory;
    self.physicsBody.contactTestBitMask =   kPebbleCategory | kBorderCategory;
}

@end
