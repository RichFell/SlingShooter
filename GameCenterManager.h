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

+(instancetype)sharedManager;
-(void)checkForAuthenticationInBackground:(void(^)(UIViewController *vc, NSError *error))complete;


@end
