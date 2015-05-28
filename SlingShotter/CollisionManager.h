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

-(void)collisionManagerBadGuyHitBottom:(CollisionManager *)collisionManager;
-(void)collisionManager:(CollisionManager *)collisionManager tookOutABaddy:(BOOL)takenCare;

@end

@interface CollisionManager : NSObject<SKPhysicsContactDelegate>

@property id<CollisionManagerDelegate>delegate;

@end
