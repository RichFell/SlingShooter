//
//  GameScene.h
//  SlingShotter
//

//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class SlingShot, CollisionManager;

@interface GameScene : SKScene

@property SlingShot *slingshot;
@property CollisionManager *collisionManager;

@end
