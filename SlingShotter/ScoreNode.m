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
    CGSize size = CGSizeMake(100.0, 100.0);
    CGSize labelSize = CGSizeMake(100, 50);

    SKTexture *texture = [SKTexture textureWithImageNamed:@"ScoreBoard"];
    ScoreNode *node = [[ScoreNode alloc]initWithTexture:texture
                                                  color:[UIColor lightGrayColor]
                                                   size:size];
    SKSpriteNode *scoreLabelNode = [[SKSpriteNode alloc]initWithColor:[UIColor clearColor]
                                                                 size:labelSize];
    SKSpriteNode *timeLabelNode = [[SKSpriteNode alloc]initWithColor:[UIColor clearColor]
                                                                size:labelSize];

    node.scoreLabel = [SKLabelNode labelNodeWithText:@"ScoreLabel"];
    node.scoreLabel.fontName = @"Aventir-Medium";
    [node.scoreLabel setText:@"0"];
    node.timeLabel = [SKLabelNode labelNodeWithText:@"TimeLabel"];
    node.timeLabel.fontName = @"Aventir-Medium";
    [node.timeLabel setText:@"0 sec"];
    node.position = CGPointMake((size.width/2) + 10.0,
                                CGRectGetHeight(scene.frame) - (size.height/2) - 30);
    scoreLabelNode.position = CGPointMake(0, 20);
    timeLabelNode.position = CGPointMake(0, -20);
    [node addChild:scoreLabelNode];
    [node addChild:timeLabelNode];
    [scoreLabelNode addChild:node.scoreLabel];
    [timeLabelNode addChild:node.timeLabel];
    [scene addChild:node];
    return node;
}

@end
