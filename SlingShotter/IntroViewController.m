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
    [self checkForAuthentication];
}

- (void)checkForAuthentication {
    [[GameCenterManager sharedManager]checkForAuthenticationInBackground:^(UIViewController *vc, NSError *error) {
        if (vc) {
            [self presentViewController:vc animated:YES completion:nil];
        }
        if (error) {
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"There was an issue signing in to Game Center."
                                                                              message:error.localizedDescription
                                                                       preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"CONTINUE" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //TODO: Need to add code for continuing, and handling playing the game w/out GameCenter.
            }]];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"TRY AGAIN" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self checkForAuthentication];
            }]];
        }
    }];
}



@end
