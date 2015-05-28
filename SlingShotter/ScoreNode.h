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

+(instancetype)addScoreBoardToScene:(SKScene *)scene;

@end
