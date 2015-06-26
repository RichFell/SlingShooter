//
//  UserDefaults.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "UserDefaults.h"
#import "GameCenterManager.h"

@implementation UserDefaults

static NSString *const kHighScoreKey = @"HighScore";
static NSString *const kHasRunKey = @"HasRun";
static NSString *const kSecondsSurvivedKey = @"SecondsSurvived";

+(void)checkHighScoreAgainst:(NSInteger)score {
    if (score > [UserDefaults highScore] || ![UserDefaults highScore]) {
        [[GameCenterManager sharedManager] reportScore:score block:^(NSError *error) {
            if (error) {
                NSLog(@"%@",error.localizedDescription);
            }
        }];
        [UserDefaults setHighScore:score];
    }
}

+(void)checkTimeSurvived:(NSDate *)gameStartDate {
    float timeSurvived = -[gameStartDate timeIntervalSinceNow];
    if (timeSurvived > [UserDefaults secondsSurvived]) {
        [UserDefaults setSecondsSurvived:timeSurvived];
    }
}

+(NSInteger)highScore {
    return [[[NSUserDefaults standardUserDefaults]objectForKey:kHighScoreKey]integerValue];
}

+(void)setHighScore:(NSInteger)highScore {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(highScore) forKey:kHighScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)hasRun {
    return [[[NSUserDefaults standardUserDefaults]objectForKey:kHasRunKey] boolValue];
}

+(void)setHasRun {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(YES) forKey:kHasRunKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(float)secondsSurvived {
    return [[[NSUserDefaults standardUserDefaults]objectForKey:kSecondsSurvivedKey] floatValue];
}

+(void)setSecondsSurvived:(float)secondsSurvived {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(secondsSurvived) forKey:kSecondsSurvivedKey];
    [defaults synchronize];
}
@end
