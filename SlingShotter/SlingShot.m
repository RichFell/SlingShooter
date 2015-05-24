//
//  SlingShot.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "SlingShot.h"
#import "Pebble.h"
#import "Constants.h"

@implementation SlingShot
{
    SKShapeNode *line;
}

static CGFloat const yBuffer = 10.0;

#pragma mark - Class Initializer
+(instancetype)slingshotInRect:(CGRect)rect{

    SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed: @"Slingshot"]];
    CGSize size = CGSizeMake(80.0, 140.0);

    SlingShot *slingshot = [[SlingShot alloc]initWithTexture:texture color:[UIColor new] size:size];
    slingshot.position = CGPointMake(CGRectGetWidth(rect)/2, CGRectGetHeight(rect)/6);
    return slingshot;
}

#pragma mark - Instance Methods
-(void)firePebbleFromPosition:(CGPoint)fromPosition {
    [Pebble pebbleInScene:self.scene
                              fromPosition:CGPointMake(CGRectGetMidX(self.frame),
                                                       CGRectGetMaxY(self.frame) - yBuffer)
                                 withForce:1.0
                               inDirection:fromPosition];
    
}

-(void)drawStringToPoint:(CGPoint)controlPoint {
    if (line) {
        [self.scene removeChildrenInArray:@[line]];
    }
    line = [SKShapeNode node];

    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.frame) - CGRectGetWidth(self.frame)/3,
                                     CGRectGetMaxY(self.frame) - yBuffer);
    CGPoint endPoint = CGPointMake(CGRectGetMidX(self.frame) + CGRectGetWidth(self.frame)/3,
                                   CGRectGetMaxY(self.frame) - yBuffer);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(path, nil,
                              controlPoint.x, controlPoint.y,
                              endPoint.x, endPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    CGPathCloseSubpath(path);
    line.path = path;

    line.strokeColor = [UIColor whiteColor];
    line.lineWidth = 5.0;
    [self.scene addChild:line];

    CGPathRelease(path);
}

@end
