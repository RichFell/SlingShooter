//
//  UserDefaults.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject
+(NSInteger)highScore;
+(void)setHighScore:(NSInteger)highScore;
@end
