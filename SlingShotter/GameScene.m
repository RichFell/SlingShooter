//
//  GameScene.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameScene.h"
#import "SlingShot.h"

@implementation GameScene
{
    CGPoint startPull;
    BOOL isShooting;
}

-(void)didMoveToView:(SKView *)view {
    self.slingshot = [SlingShot slingshotInRect:self.frame];
    [self addChild:self.slingshot];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    UITouch *touch = [[touches allObjects] firstObject];

    if (CGRectContainsPoint(self.slingshot.frame, [touch locationInNode:self])) {
        isShooting = true;
    }
    else {
        isShooting = false;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isShooting) {
        UITouch *lastTouch = [[touches allObjects]lastObject];
        [self.slingshot firePebbleFromPosition:[lastTouch locationInNode:self]];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
