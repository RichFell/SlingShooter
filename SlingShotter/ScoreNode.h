//
//  ScoreNode.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/22/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScoreNode : SKSpriteNode

@property SKLabelNode *scoreLabel;
@property SKLabelNode *timeLabel;

/**
 Description: Used to add the score board to the scene
 @param scene: the SKScene in which the score board is to be presented. 
 */
+ (instancetype)addScoreBoardToScene:(SKScene *)scene;

@end
