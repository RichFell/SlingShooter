//
//  GameCenterManager.h
//  SlingShotter
//
//  Created by Rich Fellure on 6/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface GameCenterManager : NSObject

typedef void(^GameScoreBlock)(NSArray *scores, NSError *error);
typedef void(^ReportScoreBlock)(BOOL outcome ,NSError *error);

@property BOOL          isAuthenticated;
@property BOOL          gameCenterEnabled;
@property NSString      *leaderboardIdentifier;
@property GKLocalPlayer *player;

/**
Returns the singleton GameCenterManager.
 */
+ (instancetype)sharedManager;

/**
Checks for Game Center authentication, and if not will display the Game Center sign up/log in view.
 @param complete: Completion block returned once the operation has been completed
 */
- (void)checkForAuthenticationInBackground:(void(^)(UIViewController *vc, NSError *error))complete;

/**
Reports the user's score to Game Center to be saved
 @param score: The score to be reported to Game Center
 @param complete: The completion block that will return an error if there was an error with the call to Game Center
 */
- (void)reportScore:(NSInteger)score block:(ReportScoreBlock)complete;

/**
Makes a call to Game Center in order to retrieve data for the top 10 scores saved to the system
 @param completed: The completion block for when the operation finished. Returns the array of scores, or an error if there was an error with the network call.
 */
- (void)retrieveTopTenScoresInBackground:(GameScoreBlock)completed;

/**
Makes a call to GameCenter in order to retrieve the data for the top 10 longest times survived in game.
 @param completed: The GameScoreBlock completion to be called once the operation has finished.
 */
- (void)retrieveTopTenTimesInBackground:(GameScoreBlock)completed;

/**
 Reports the user's time survived to the GameCenter in order to be saved
 @param timePlayed: Total amount of time that the player had survived
 @param complete: ReportScoreBlock completion block called once the operation has finished. 
 */
- (void)reportTimePlayed:(NSInteger)timePlayed block:(ReportScoreBlock)complete;

@end
