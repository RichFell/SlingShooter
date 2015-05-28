//
//  GameViewController.h
//  SlingShotter
//

//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "GameOverViewController.h"

@interface GameViewController : UIViewController<GameSceneDelegate, GameOverVCDelegate>

@property GameScene *gameScene;
@end
