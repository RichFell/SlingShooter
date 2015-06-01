//
//  UserDefaults.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

static NSString *const kHighScoreKey = @"HighScore";
static NSString *const kHasRunKey = @"HasRun";

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
@end
