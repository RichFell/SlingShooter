//
//  GameScene.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameScene.h"
#import "SlingShot.h"
#import "BadGuy.h"
#import "CollisionManager.h"
#import "Constants.h"

@implementation GameScene
{
    CGPoint startPull;
    BOOL isShooting;
}

//static CGFloat const buffer = 0.0;

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self setupScenePhysicsBody];
        self.slingshot = [SlingShot slingshotInRect:self.frame];
        [self addChild:self.slingshot];
        self.collisionManager = [CollisionManager new];
        [BadGuy dropABadGuyOnScene:self];
        [BadGuy dropABadGuyOnScene:self];
    }
    return self;
}



-(void)setupScenePhysicsBody {
//    self.scaleMode = SKSceneScaleModeAspectFill;
//    CGRect newFrame = CGRectMake(-buffer, -buffer, CGRectGetWidth(self.frame) + buffer, CGRectGetHeight(self.frame) + buffer);
//    SKPhysicsBody *border = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
//    self.physicsBody = border;
//    self.physicsBody.contactTestBitMask = kPebbleCategory | kBadGuyCategory;
//    self.physicsBody.collisionBitMask = kPebbleCategory | kBadGuyCategory;
//    self.physicsBody.categoryBitMask = kSceneCategory;
//    self.physicsBody.friction = 0.0f;
    self.physicsWorld.contactDelegate = self.collisionManager;
}

#pragma mark - Touches Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];

    //If the user touches in the frame of the slingshot, then we want to be able to fire the Pebble
    if (CGRectContainsPoint(self.slingshot.frame, [touch locationInNode:self])) {
        isShooting = true;
    }
    else {
        isShooting = false;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isShooting) {
        UITouch *lastTouch = [[touches allObjects]lastObject];
        [self.slingshot firePebbleFromPosition:[lastTouch locationInNode:self]];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
