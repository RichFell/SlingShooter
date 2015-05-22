//
//  CollisionManager.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "CollisionManager.h"
#import "Pebble.h"
#import "BadGuy.h"
#import "GameScene.h"
#import "Constants.h"

@implementation CollisionManager

-(void)isStillWorking {
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }

    // 2
    if ((firstBody.categoryBitMask & kPebbleCategory) != 0 &&
        (secondBody.categoryBitMask & kBadGuyCategory) != 0)
    {
        [firstBody.node removeFromParent];
        
        if ([firstBody.node isKindOfClass:[Pebble class]]) {
            NSLog(@"Pebble hit bad guy");
        }
//            [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
}


@end
