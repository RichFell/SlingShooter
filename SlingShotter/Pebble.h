//
//  Pebble.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface Pebble : SKSpriteNode

/**
 Description: Adds a new pebble to the scene, at a specific point.
 @param scene: The SKScene which the pebble is to be added to.
 @param point: The CGPoint where the pebble is to be added to the scene.
 */
+ (instancetype)placePebbleInScene:(SKScene *)scene atPoint:(CGPoint)point;

/**
 Description: Shoot a pebble from a position to a specified position.
 @param startingPosition: The position where the pebble is to be fired from.
 @param endingPosition: The position towards which the pebble is to be fired.
 */
- (void)firePebbleFromPosition:(CGPoint)startingPosition towardsPosition:(CGPoint)endingPosition;

@end
