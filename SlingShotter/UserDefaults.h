//
//  UserDefaults.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject
+(NSInteger)highScore;
+(void)checkTimeSurvived:(NSDate *)gameStartDate;
+(void)checkHighScoreAgainst:(NSInteger)score;
+(BOOL)hasRun;
+(void)setHasRun;
+(void)setSecondsSurvived:(float)secondsSurvived;
+(float)secondsSurvived;
@end
