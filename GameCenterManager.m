//
//  GameCenterManager.m
//  SlingShotter
//
//  Created by Rich Fellure on 6/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameCenterManager.h"

@implementation GameCenterManager

+ (instancetype)sharedManager {
    static GameCenterManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)checkForAuthenticationInBackground:(void(^)(UIViewController *vc, NSError *error))complete {
    self.player = [GKLocalPlayer localPlayer];
    [self.player setAuthenticateHandler:^(UIViewController *vc, NSError *error) {
        if (vc) {
            complete(vc, error);
        }else {
            if ([GKLocalPlayer localPlayer].authenticated) {
                [[GKLocalPlayer localPlayer]loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    if (error) {
                        NSLog(@"%@", error.localizedDescription);
                    }else {
                        _leaderboardIdentifier = leaderboardIdentifier;//Have to access the value in order to avoid a retain cycle
                    }
                }];
            }
            _gameCenterEnabled = [GKLocalPlayer localPlayer].authenticated; //Have to access the value in order to avoid a retain cycle
        }
    }];
}

- (void)reportScore:(NSInteger)score block:(void(^)(NSError *error))complete {
    GKScore *s = [[GKScore alloc] initWithLeaderboardIdentifier:self.leaderboardIdentifier];
    s.value = score;
    [GKScore reportScores:@[s] withCompletionHandler:^(NSError *error) {
        complete(error);
    }];
}

- (void) retrieveTopTenScoresInBackground:(void(^)(NSArray *scores, NSError *error))completed {
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
    if (leaderboardRequest != nil) {
        leaderboardRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
        leaderboardRequest.identifier = self.leaderboardIdentifier;
        leaderboardRequest.range = NSMakeRange(1,10);
        [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
            completed(scores, error);
        }];
    }
}

@end
