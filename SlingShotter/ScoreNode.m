//
//  ScoreNode.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/22/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "ScoreNode.h"

@implementation ScoreNode

+ (instancetype)addScoreBoardToScene:(SKScene *)scene{
    CGSize size = CGSizeMake(100.0,
                             100.0);

    SKTexture *texture = [SKTexture textureWithImageNamed:@"ScoreBoard"];
    ScoreNode *node = [[ScoreNode alloc]initWithTexture:texture
                                                  color:[UIColor lightGrayColor]
                                                   size:size];

    node.scoreLabel = [SKLabelNode labelNodeWithText:@"FOOOOO"];
    node.scoreLabel.fontName = @"HelveticaNeue";
    [node.scoreLabel setText:@"0"];
    node.position = CGPointMake((size.width/2) + 10.0,
                                CGRectGetHeight(scene.frame) - (size.height/2) - 30);

    [node addChild:node.scoreLabel];
    [scene addChild:node];
    return node;
}

@end
