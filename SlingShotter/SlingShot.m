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

@interface SlingShot()

@property SKShapeNode   *line;
@property CGPoint       startPoint;
@property CGPoint       endPoint;
@property Pebble        *waitingPebble;

@end

@implementation SlingShot

static CGFloat const yBuffer =              10.0;
static NSString *const kSlingShotImage =    @"Slingshot";


#pragma mark - Class Initializer
+ (instancetype)slingshotInScene:(SKScene *)scene{

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

#pragma mark - Public Instance Methods
- (void)firePebbleFromPosition:(CGPoint)fromPosition {
    self.waitingPebble = [Pebble placePebbleInScene:self.scene atPoint:fromPosition];
    [self.waitingPebble firePebbleFromPosition:fromPosition
                          towardsPosition:CGPointMake(CGRectGetMidX(self.frame),
                                                      CGRectGetMaxY(self.frame) - yBuffer)];
    [self drawStringToPoint:CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMaxY(self.frame) - yBuffer)];
    
}

- (void)drawStringToPoint:(CGPoint)controlPoint {
    CGMutablePathRef path = CGPathCreateMutable();
    self.startPoint = CGPointMake(CGRectGetMidX(self.frame) - CGRectGetWidth(self.frame)/3,
                             CGRectGetMaxY(self.frame) - yBuffer);
    self.endPoint = CGPointMake(CGRectGetMidX(self.frame) + CGRectGetWidth(self.frame)/3,
                           CGRectGetMaxY(self.frame) - yBuffer);
    CGPathMoveToPoint(path, NULL, self.startPoint.x, self.startPoint.y);

    CGPathAddQuadCurveToPoint(path, nil,
                              controlPoint.x, controlPoint.y,
                              self.endPoint.x, self.endPoint.y);
    CGPathAddLineToPoint(path, NULL,
                         self.endPoint.x, self.endPoint.y);
    if (!self.line) {
        self.line = [SKShapeNode node];
        [self.scene addChild:self.line];
    }
    self.line.path = path;
    self.line.name = kLineName;
    self.line.strokeColor = [UIColor whiteColor];
    self.line.lineWidth = 5.0;
    SKAction *pull = [SKAction followPath:path speed:0.3];
    [SKAction runAction:pull onChildWithName:kLineName];
    CGPathRelease(path);
}

@end
