//
//  GameScene.h
//  SlingShotter
//

//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CollisionManager.h"
@class SlingShot;

@interface GameScene : SKScene<CollisionManagerDelegate>

@property SlingShot *slingshot;
@property CollisionManager *collisionManager;

@end
