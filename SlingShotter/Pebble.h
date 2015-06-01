//
//  Pebble.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface Pebble : SKSpriteNode

+(instancetype)placePebbleInScene:(SKScene *)scene atPoint:(CGPoint)point;
-(void)firePebbleFromPosition:(CGPoint)startingPosition towardsPosition:(CGPoint)endingPosition;

//+(void)pebbleInScene:(SKScene *)scene fromPosition:(CGPoint)position withForce:(CGFloat)force inDirection:(CGPoint)direction;
@end
