//
//  GameScene.h
//  SlingShotter
//

//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CollisionManager.h"
@class SlingShot, ScoreNode, GameScene;

@protocol GameSceneDelegate <NSObject>

-(void)gameScene:(GameScene *)gameScene shouldEndGame:(BOOL)shouldEnd;

@end

@interface GameScene : SKScene<CollisionManagerDelegate>

@property id<GameSceneDelegate>gameSceneDelegate;
@property SlingShot *slingshot;
@property CollisionManager *collisionManager;
@property ScoreNode *scoreNode;
@property NSInteger killCount;

@end
