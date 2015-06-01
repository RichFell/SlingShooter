//
//  IntroViewController.h
//  SlingShotter
//
//  Created by Rich Fellure on 5/28/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IntroViewController;

@protocol IntroVCDelegate <NSObject>

-(void)introVC:(IntroViewController *)vc didSelectToPlayGame:(BOOL)shouldPlay;

@end

@interface IntroViewController : UIViewController

@property id<IntroVCDelegate>delegate;

+(instancetype)storyboardInstance;

@end
