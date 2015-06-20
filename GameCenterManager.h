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

@property BOOL isAuthenticated;
@property BOOL gameCenterEnabled;
@property NSString * leaderboardIdentifier;
@property GKLocalPlayer *player;

+(instancetype)sharedManager;
-(void)checkForAuthenticationInBackground:(void(^)(UIViewController *vc, NSError *error))complete;
-(void)reportScore:(NSInteger)score block:(void(^)(NSError *error))complete;
-(void)retrieveTopTenScoresInBackground:(void(^)(NSArray *scores, NSError *error))completed;

@end
