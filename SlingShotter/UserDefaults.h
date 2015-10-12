//
//  UserDefaults.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject
/**
 Description: Returns the highScore for the user saved in NSUserDefaults
 */
+ (NSInteger)highScore;

/**
 Description: Checks to see if the amount of time survived is the current best, and if so will save that to UserDefaults
 @param gameStartDate: The date the current game had started.
 */
+ (void)checkTimeSurvived:(NSDate *)gameStartDate;

/**
 Description: Checks if the score passed in is higher than the currently reported high score, and if so will save the new score.
 @param score: The current score to check against the high score.
 */
+ (void)checkHighScoreAgainst:(NSInteger)score;

/**
 Description: returns a boolean telling if the program has been run on the device or not.
 */
+ (BOOL)hasRun;

/**
 Description: Call once the application has run for the first time so the intro is not shown again.
 */
+ (void)setHasRun;

/**
 Description: Sets the seconds the user had survived
 @param secondsSurvived: The number of seconds the user had survived
 */
+ (void)setSecondsSurvived:(float)secondsSurvived;

/**
 Description: Returns the highest number of seconds a user had survived. 
 */
+ (float)secondsSurvived;
@end
