//
//  SlingShot.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SlingShot : SKSpriteNode

/**
 Description: Instantiate a new SlingShot in the desired CGRect
 */
+(instancetype)slingshotInRect:(CGRect)rect;

/**
 Description: Tells the SlingShot that it needs to fire a Pebble from the position given. 
 :fromPosition: The position that the player pulled the rubber band back to.
 */
-(void)firePebbleFromPosition:(CGPoint)fromPosition;

-(void)drawStringToPoint:(CGPoint)controlPoint;
@end
