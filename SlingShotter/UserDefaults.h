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
+(void)setHighScore:(NSInteger)highScore;
+(BOOL)hasRun;
+(void)setHasRun;
@end
