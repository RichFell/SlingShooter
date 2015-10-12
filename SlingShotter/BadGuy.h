//
//  BadGuy.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BadGuy : SKSpriteNode


/**
 Description: Adds the BadGuy to the Scene, and sends him towards the bottom.
 @param scene: The SKScene the BadGuy is going to be added to.
 */
+ (void)dropABadGuyOnScene:(SKScene *)scene;

@end
