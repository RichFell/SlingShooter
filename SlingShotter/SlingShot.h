//
//  SlingShot.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SlingShot : SKSpriteNode

/**
 Description: Instantiate a new SlingShot in the desired CGRect
 @param scene: The SKScene the slingshot is to be added.
 */
+ (instancetype)slingshotInScene:(SKScene *)scene;

/**
 Description: Tells the SlingShot that it needs to fire a Pebble from the position given. 
 @param fromPosition: The position that the player pulled the rubber band back to.
 */
- (void)firePebbleFromPosition:(CGPoint)fromPosition;

/**
 Description: Draws the string of the slighshot back to a specific point.
 @param controlPoint: The CGPoint the string is to be drawn back to. 
 */
- (void)drawStringToPoint:(CGPoint)controlPoint;

@end
