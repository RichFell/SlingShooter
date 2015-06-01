//
//  SlingShot.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "SlingShot.h"
#import "Pebble.h"
#import "Constants.h"

@implementation SlingShot
{
    SKShapeNode *line;
    CGPoint startPoint;
    CGPoint endPoint;
    Pebble *waitingPebble;
}

static CGFloat const yBuffer = 10.0;
static NSString *const kSlingShotImage = @"Slingshot";


#pragma mark - Class Initializer
+(instancetype)slingshotInScene:(SKScene *)scene{

    SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed: kSlingShotImage]];
    CGSize size = CGSizeMake(80.0, 140.0);

    SlingShot *slingshot = [[SlingShot alloc]initWithTexture:texture
                                                       color:[UIColor new]
                                                        size:size];
    
    slingshot.position = CGPointMake(CGRectGetWidth(scene.frame)/2,
                                     CGRectGetHeight(scene.frame)/6);
    [scene addChild:slingshot];
    [slingshot drawStringToPoint:CGPointMake(CGRectGetMidX(slingshot.frame),
                                             CGRectGetMaxY(slingshot.frame) - yBuffer)];
    return slingshot;
}

#pragma mark - Instance Methods
-(void)firePebbleFromPosition:(CGPoint)fromPosition {
    [waitingPebble firePebbleFromPosition:fromPosition
                          towardsPosition:CGPointMake(CGRectGetMidX(self.frame),
                                                      CGRectGetMaxY(self.frame) - yBuffer)];
    [self drawStringToPoint:CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMaxY(self.frame) - yBuffer)];
    
}

-(void)drawStringToPoint:(CGPoint)controlPoint {
    CGMutablePathRef path = CGPathCreateMutable();
    startPoint = CGPointMake(CGRectGetMidX(self.frame) - CGRectGetWidth(self.frame)/3,
                             CGRectGetMaxY(self.frame) - yBuffer);
    endPoint = CGPointMake(CGRectGetMidX(self.frame) + CGRectGetWidth(self.frame)/3,
                           CGRectGetMaxY(self.frame) - yBuffer);
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);

    CGPathAddQuadCurveToPoint(path, nil,
                              controlPoint.x, controlPoint.y,
                              endPoint.x, endPoint.y);
    CGPathAddLineToPoint(path, NULL,
                         endPoint.x, endPoint.y);
    [self movePebbleToPoint:controlPoint onPath:path];

    if (!line) {
        line = [SKShapeNode node];
        [self.scene addChild:line];
    }
    line.path = path;
    line.name = kLineName;
    line.strokeColor = [UIColor whiteColor];
    line.lineWidth = 5.0;
    SKAction *pull = [SKAction followPath:path speed:0.3];
    [SKAction runAction:pull onChildWithName:kLineName];
    CGPathRelease(path);
}

-(void)movePebbleToPoint:(CGPoint)point onPath:(CGPathRef)path {

    CGPoint middleOfSling = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMaxY(self.frame) - yBuffer);
    if (point.x == middleOfSling.x &&
        point.y == middleOfSling.y) {
        waitingPebble = [Pebble placePebbleInScene:self.scene
                                           atPoint:point];
    }
    else {
        waitingPebble.position = point;
    }
}

@end
