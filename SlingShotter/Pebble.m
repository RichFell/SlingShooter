//
//  Pebble.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Pebble.h"

@implementation Pebble

+(void)pebbleInScene:(SKScene *)scene fromPosition:(CGPoint)position withForce:(CGFloat)force inDirection:(CGPoint)direction{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"Spaceship"];
    CGSize size = CGSizeMake(CGRectGetWidth(scene.frame)/30, CGRectGetWidth(scene.frame)/30);
    Pebble *pebble = [[Pebble alloc]initWithTexture:texture color:[UIColor new] size:size];

    pebble.position = position;
    [scene addChild:pebble];
    [pebble firePebbleFromPosition:position towardsPosition:direction];
}

-(void)firePebbleFromPosition:(CGPoint)startingPosition towardsPosition:(CGPoint)endingPosition{
    CGPoint endingPoint = CGPointMake(endingPosition.x, endingPosition.y);
    CGVector vector = CGVectorMake(endingPosition.x - startingPosition.x,
                                   endingPosition.y - startingPosition.y);

    SKAction *actionMove = [SKAction moveTo:endingPoint duration:0.5];
    SKAction *actionMoveDone = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
}

@end
