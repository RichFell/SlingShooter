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

/**
 Description: Notifies the delegate that the user has selected to restart the game.
 @param vc: The instance of GameOverViewController calling this method
 @param selection: Tells whether they selected to restart or not.
 */
-(void)gameOverVC:(GameOverViewController *)vc restartSelected:(BOOL)selection;

@end


@interface GameOverViewController : UIViewController

@property id<GameOverVCDelegate>delegate;
@property NSInteger             killCount;
@property NSDate                *gameStartDate;

@end