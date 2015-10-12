//
//  CollisionManager.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
@class CollisionManager, BadGuy;

@protocol CollisionManagerDelegate <NSObject>

/**
 Description: Is called to notify the delegate that a BadGuy object has hit the bottom barrier
 @param collisionManager: The CollisionManager object which is reporting this
 */
- (void)collisionManagerBadGuyHitBottom:(CollisionManager *)collisionManager;

/**
 Description: Is called when the CollisionManager has detected that a BadGuy object has been hit by a Pebble object.
 @param collisionManager: The CollisionManager object making this call
 @param takenCar: BOOL indicating whether the BadGuy had been hit or not
 */
- (void)collisionManager:(CollisionManager *)collisionManager tookOutABaddy:(BOOL)takenCare;

@end

@interface CollisionManager : NSObject<SKPhysicsContactDelegate>

@property id<CollisionManagerDelegate>delegate;

@end
