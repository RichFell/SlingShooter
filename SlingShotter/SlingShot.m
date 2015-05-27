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
    CGPoint startPoint;
    CGPoint endPoint;
}

static CGFloat const yBuffer = 10.0;
static NSString *const kSlingStill = @"Sling";


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
    [self drawStringToPoint:CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMaxY(self.frame) - yBuffer)];
    
}

-(void)drawStringToPoint:(CGPoint)controlPoint {
    if (!line) {
        line = [SKShapeNode node];
        [self.scene addChild:line];
    }

    CGMutablePathRef path = CGPathCreateMutable();
    startPoint = CGPointMake(CGRectGetMidX(self.frame) - CGRectGetWidth(self.frame)/3,
                             CGRectGetMaxY(self.frame) - yBuffer);
    endPoint = CGPointMake(CGRectGetMidX(self.frame) + CGRectGetWidth(self.frame)/3,
                           CGRectGetMaxY(self.frame) - yBuffer);
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(path, nil,
                              controlPoint.x, controlPoint.y,
                              endPoint.x, endPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    line.path = path;
    line.name = kLineName;
    line.strokeColor = [UIColor whiteColor];
    line.lineWidth = 5.0;
    SKAction *pull = [SKAction followPath:path speed:0.4];
    [SKAction runAction:pull onChildWithName:kLineName];
    [self addSlingForPoint:controlPoint];
    CGPathRelease(path);
}

-(void)addSlingForPoint:(CGPoint)point {
    [self checkForSling];
    CGPoint middleOfSling = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMaxY(self.frame) - yBuffer);
    SKTexture *texture;
    if (point.x == middleOfSling.x &&
        point.y == middleOfSling.y) {
        texture = [SKTexture textureWithImageNamed:kSlingStill];
    }
    SKSpriteNode *sling = [[SKSpriteNode alloc] initWithTexture:texture
                                                          color:[UIColor new]
                                                           size:CGSizeMake(50.0, 42.0)];
    sling.position = point;
    sling.name = kSlingName;
    [self.scene addChild:sling];
}

//Pointer to non-const type 'NSString *' with no explicit ownership.

-(void)checkForSling {
    SKNode *sling = [self.scene childNodeWithName:kSlingName];
    if (sling) {
        [self.scene removeChildrenInArray:@[sling]];
    }
}

@end
