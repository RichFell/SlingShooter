//
//  CollisionManager.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "CollisionManager.h"
#import "Pebble.h"
#import "BadGuy.h"
#import "GameScene.h"
#import "Constants.h"

@implementation CollisionManager

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

    if ((firstBody.categoryBitMask & kPebbleCategory) != 0){
         [firstBody.node removeFromParent];
        if ((secondBody.categoryBitMask & kBadGuyCategory) != 0) {
            [secondBody.node removeFromParent];
            [self.delegate collisionManager:self tookOutABaddy:YES];
        }
    }
    else if ((firstBody.categoryBitMask & kBadGuyCategory) != 0
             && (secondBody.categoryBitMask & kBorderCategory) )  {
        [firstBody.node removeFromParent];
        if (contact.contactPoint.y < 0.0) {
            [self.delegate collisionManagerBadGuyHitBottom:self];
        }
    }
}


@end
