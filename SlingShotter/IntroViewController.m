//
//  IntroViewController.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/28/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


+(instancetype)storyboardInstance {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"IntroViewController"];
}

- (IBAction)playGameOnTap:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.delegate introVC:self didSelectToPlayGame:true];
}

@end
