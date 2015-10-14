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
#import "UserDefaults.h"
#import "SlingShotter-Swift.h"

@interface GameScene()<GameLogicManagerDelegate>

@property CGPoint       startPull;
@property BOOL          isShooting;
@property NSInteger     spawnCount;
@property SKShapeNode   *line;
@property (nonatomic)GameLogicManager *logicManager;

@end

@implementation GameScene

#pragma mark - static variables
static CGFloat const buffer =       50.0;
static CGFloat const pullCheck =    10.0;

static NSString *const kBackgroundImage = @"Cornfield";

#pragma mark - initializers
- (instancetype)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self addBackgroundImageForSize:size];
        self.scoreNode = [ScoreNode addScoreBoardToScene:self];
        [self setupScenePhysicsBody];
        self.slingshot = [SlingShot slingshotInScene:self];
        [BadGuy dropABadGuyOnScene:self];
        [self.logicManager beginAddingCrowsToScene:self];
        [self.logicManager startTimer:YES onScene:self];
        self.logicManager.timerActive = YES;
    }
    return self;
}

- (GameLogicManager *)logicManager {
    if (!_logicManager) {
        _logicManager = [GameLogicManager sharedInstance];
        _logicManager.delegate = self;
    }
    return _logicManager;
}

#pragma mark - Private Instance methods
- (void)addBackgroundImageForSize:(CGSize)size {
    SKSpriteNode *backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:kBackgroundImage];
    backgroundNode.name = kBorderName;
    backgroundNode.position = CGPointMake(size.width/2, size.height/2);
    backgroundNode.size = size;
    [self addChild:backgroundNode];
}

- (void)setupScenePhysicsBody{

    //Add the physics body to the scene, so that there will be a boundary around the scene we can use to delete nodes, and things once they collide.
    self.scaleMode = SKSceneScaleModeFill;
    CGRect newFrame = CGRectMake(-buffer, -buffer, CGRectGetWidth(self.frame) + (buffer * 2),
                                 CGRectGetHeight(self.frame) + (buffer * 2));
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[touches allObjects] firstObject];

    //If the user touches in the frame of the slingshot, then we want to be able to fire the Pebble
    if (CGRectContainsPoint(self.slingshot.frame, [touch locationInNode:self])) {
        self.isShooting = true;
        self.startPull = [touch locationInNode:self];
        [self.slingshot drawStringToPoint:self.startPull];
    }
    else {
        self.isShooting = false;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isShooting) {
        UITouch *touch = [[touches allObjects]firstObject];
        [self.slingshot drawStringToPoint:[touch locationInNode:self]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isShooting) {
        UITouch *lastTouch = [[touches allObjects]lastObject];
        CGFloat yPullLength = self.startPull.y - [lastTouch locationInNode:self].y;
        CGFloat xPullLength = self.startPull.x - [lastTouch locationInNode:self].x;
        if (yPullLength > pullCheck || yPullLength < -pullCheck ||
            xPullLength > pullCheck || xPullLength < -pullCheck) { //Want to make sure that the slingshot has been pulled back a minimum distance before allowing the pebble to be fired
            [self.slingshot firePebbleFromPosition:[lastTouch locationInNode:self]];
        }
    }
}

#pragma mark - CollisionManagerDelegate methods
- (void)collisionManagerBadGuyHitBottom:(CollisionManager *)collisionManager {
    self.scene.view.paused = YES;
    [self.logicManager stopTimer];
    [self.gameSceneDelegate gameScene:self shouldEndGame:YES];
}

- (void)collisionManager:(CollisionManager *)collisionManager tookOutABaddy:(BOOL)takenCare {
    [self.scoreNode.scoreLabel setText:[NSString stringWithFormat:@"%ld", (long)++self.logicManager.killCount]];
}

#pragma mark - GameLogicManager
- (void)gameLogicManager:(GameLogicManager *)manager shouldShowTime:(NSString *)timeString {
    [self.scoreNode.timeLabel setText:timeString];
}

@end
