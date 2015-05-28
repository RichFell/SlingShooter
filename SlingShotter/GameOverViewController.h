//
//  GameOverViewController.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameOverViewController;

@protocol GameOverVCDelegate <NSObject>

-(void)gameOverVC:(GameOverViewController *)vc restartSelected:(BOOL)selection;

@end

@interface GameOverViewController : UIViewController

@property id<GameOverVCDelegate>delegate;
+(instancetype)storyboardInstance;
@property NSInteger killCount;
@end
