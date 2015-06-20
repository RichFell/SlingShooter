//
//  IntroViewController.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/28/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "IntroViewController.h"
#import "GameCenterManager.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[GameCenterManager sharedManager]checkForAuthenticationInBackground:^(UIViewController *vc, NSError *error) {
        if (vc) {
            [self presentViewController:vc animated:YES completion:nil];
        }
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}



@end
