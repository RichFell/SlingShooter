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

@property BOOL          isAuthenticated;
@property BOOL          gameCenterEnabled;
@property NSString      *leaderboardIdentifier;
@property GKLocalPlayer *player;

/**
 Description: Returns the singleton GameCenterManager.
 */
+ (instancetype)sharedManager;

/**
 Description: Checks for Game Center authentication, and if not will display the Game Center sign up/log in view.
 @param complete: Completion block returned once the operation has been completed
 */
- (void)checkForAuthenticationInBackground:(void(^)(UIViewController *vc, NSError *error))complete;

/**
 Description: Reports the user's score to Game Center to be saved
 @param score: The score to be reported to Game Center
 @param complete: The completion block that will return an error if there was an error with the call to Game Center
 */
- (void)reportScore:(NSInteger)score block:(void(^)(NSError *error))complete;

/**
Description: Makes a call to Game Center in order to retrieve data for the top 10 scores saved to the system
 @param completed: The completion block for when the operation finished. Returns the array of scores, or an error if there was an error with the network call.
 */
- (void)retrieveTopTenScoresInBackground:(void(^)(NSArray *scores, NSError *error))completed;

@end
