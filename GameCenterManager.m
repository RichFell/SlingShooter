//
//  GameCenterManager.m
//  SlingShotter
//
//  Created by Rich Fellure on 6/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameCenterManager.h"

@implementation GameCenterManager

+(instancetype)sharedManager {
    static GameCenterManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void)checkForAuthenticationInBackground:(void(^)(UIViewController *vc, NSError *error))complete {
    GKLocalPlayer *player = [GKLocalPlayer localPlayer];
    [player setAuthenticateHandler:^(UIViewController *vc, NSError *error) {
        if (vc) {
            complete(vc, error);
        }else {
            if ([GKLocalPlayer localPlayer].authenticated) {


                [[GKLocalPlayer localPlayer]loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    if (error) {
                        NSLog(@"%@", error.localizedDescription);
                    }else {
                        self.leaderboardIdentifier = leaderboardIdentifier;
                    }
                }];
            }
            self.gameCenterEnabled = [GKLocalPlayer localPlayer].authenticated;
        }

    }];
}

@end
