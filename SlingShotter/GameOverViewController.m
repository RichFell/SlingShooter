//
//  GameOverViewController.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameOverViewController.h"

@interface GameOverViewController ()

@end

@implementation GameOverViewController

+(instancetype)storyboardInstance {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"GameOverViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)restartOnTap:(UIButton *)sender {
    [self.delegate gameOverVC:self restartSelected:YES];
}

@end
