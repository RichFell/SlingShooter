//
//  GameScene.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "GameScene.h"
#import "SlingShot.h"
#import "BadGuy.h"
#import "CollisionManager.h"
#import "Constants.h"
#import "ScoreNode.h"

@implementation GameScene
{
#pragma mark - Local Variables
    CGPoint startPull;
    BOOL isShooting;
    NSInteger spawnCount;
    SKShapeNode *line;
}

static NSString *const kBackgroundImage = @"Cornfield";

#pragma mark - static variables
static CGFloat const buffer = 50.0;
static CGFloat const pullCheck = 10.0;

#pragma mark - initializers
-(instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self addBackgroundImageForSize:size];
        self.scoreNode = [ScoreNode addScoreBoardToScene:self];
        [self setupScenePhysicsBody];
        self.slingshot = [SlingShot slingshotInRect:self.frame];
        [self addChild:self.slingshot];
        [self.slingshot drawStringToPoint:CGPointMake(CGRectGetMidX(self.slingshot.frame),
                                                      CGRectGetMaxY(self.slingshot.frame) - 10.0)];
        [BadGuy dropABadGuyOnScene:self];
        spawnCount = 0;
        self.killCount = 0;
        [self addBadGuysLoop];
    }
    return self;
}

#pragma mark - Game Loops
-(void)addBadGuysLoop {
    SKAction *wait = [SKAction waitForDuration:4.5];
    SKAction *run = [SKAction runBlock:^{
        ++spawnCount;
        for (NSInteger i = 0; i <= spawnCount; i++) {
            [self addAnotheBadguyAfterDelay:i];
        }
    }];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[wait, run]]]];
}

-(void)addAnotheBadguyAfterDelay:(NSInteger)delay {
    SKAction *wait = [SKAction waitForDuration:delay];
    SKAction *run = [SKAction runBlock:^{
        [BadGuy dropABadGuyOnScene:self];
    }];
    [self runAction:[SKAction sequence:@[wait, run]]];
}

#pragma mark - Helper Methods
-(void)addBackgroundImageForSize:(CGSize)size {
    SKSpriteNode *backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:kBackgroundImage];
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
    self.physicsBody.categoryBitMask = kBorderCategory;
    self.physicsBody.friction = 0.0f;
    self.collisionManager = [CollisionManager new]; //Using the CollisionManager to house all of the logic for how to handle collisions.
    self.collisionManager.delegate = self;
    self.physicsWorld.contactDelegate = self.collisionManager;
}

#pragma mark - Touches Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];

    //If the user touches in the frame of the slingshot, then we want to be able to fire the Pebble
    if (CGRectContainsPoint(self.slingshot.frame, [touch locationInNode:self])) {
        isShooting = true;
        startPull = [touch locationInNode:self];
        [self.slingshot drawStringToPoint:startPull];
    }
    else {
        isShooting = false;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isShooting) {
        UITouch *touch = [[touches allObjects]firstObject];
        [self.slingshot drawStringToPoint:[touch locationInNode:self]];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isShooting) {
        UITouch *lastTouch = [[touches allObjects]lastObject];
        CGFloat yPullLength = startPull.y - [lastTouch locationInNode:self].y;
        CGFloat xPullLength = startPull.x - [lastTouch locationInNode:self].x;
        if (yPullLength > pullCheck || yPullLength < -pullCheck ||
            xPullLength > pullCheck || xPullLength < -pullCheck) {
            [self.slingshot firePebbleFromPosition:[lastTouch locationInNode:self]];
        }
    }
}

#pragma mark - CollisionManagerDelegate methods
-(void)collisionManagerBadGuyHitBottom:(CollisionManager *)collisionManager {
    self.scene.view.paused = YES;
    [self.gameSceneDelegate gameScene:self shouldEndGame:YES];
}

-(void)collisionManager:(CollisionManager *)collisionManager tookOutABaddy:(BOOL)takenCare {
    [self.scoreNode.scoreLabel setText:[NSString stringWithFormat:@"%ld", (long)++self.killCount]];
}
@end
