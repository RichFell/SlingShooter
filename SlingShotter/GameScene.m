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
    NSInteger spawnCount;


}

static CGFloat const buffer = 50.0;

-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self addBackgroundImageForSize:size];
        [self setupScenePhysicsBody];
        self.slingshot = [SlingShot slingshotInRect:self.frame];
        [self addChild:self.slingshot];
        [BadGuy dropABadGuyOnScene:self];
        [BadGuy dropABadGuyOnScene:self];
        spawnCount = 0;
        [self addBadGuysLoop];
    }
    return self;
}

-(void)addBadGuysLoop {
    id wait = [SKAction waitForDuration:4.5];
    id run = [SKAction runBlock:^{
        ++spawnCount;
        for (NSInteger i = 0; i < spawnCount; i++) {
             NSLog(@"times ran: %ld", (long)spawnCount);
            [BadGuy dropABadGuyOnScene:self];
        }
    }];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[wait, run]]]];
}

-(void)addBackgroundImageForSize:(CGSize)size {
    SKSpriteNode *backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"field"];
    backgroundNode.name = kBorderName;
    backgroundNode.position = CGPointMake(size.width/2, size.height/2);
    backgroundNode.size = size;
    [self addChild:backgroundNode];
}
-(void)setupScenePhysicsBody{

    //Add the physics body to the scene, so that there will be a boundary around the scene we can use to delete nodes, and things once they collide.
    self.scaleMode = SKSceneScaleModeFill;
    CGRect newFrame = CGRectMake(-buffer, -buffer, CGRectGetWidth(self.frame) + (buffer * 2), CGRectGetHeight(self.frame) + (buffer * 2));
    SKPhysicsBody *border = [SKPhysicsBody bodyWithEdgeLoopFromRect:newFrame];
    self.physicsBody = border;
    self.physicsBody.contactTestBitMask = kPebbleCategory | kBadGuyCategory;
    self.physicsBody.collisionBitMask = kPebbleCategory | kBadGuyCategory;
    self.physicsBody.categoryBitMask = kSceneCategory;
    self.physicsBody.friction = 0.0f;
    self.collisionManager = [CollisionManager new]; //Using the CollisionManager to house all of the logic for how to handle collisions.
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

@end
