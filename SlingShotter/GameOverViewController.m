//
//  GameOverViewController.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameOverViewController.h"
#import "UserDefaults.h"

@interface GameOverViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

@end

@implementation GameOverViewController

+(instancetype)storyboardInstance {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"GameOverViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.killCount];
    [self checkHighScore];
    self.highScoreLabel.text = [NSString stringWithFormat:@"High Score: %ld", [UserDefaults highScore]];
}

#pragma mark - IBActions
- (IBAction)restartOnTap:(UIButton *)sender {
    [self.delegate gameOverVC:self restartSelected:YES];
}

#pragma mark - Helper Methods
-(void)checkHighScore {
    if (self.killCount > [UserDefaults highScore] || ![UserDefaults highScore]) {
        [UserDefaults setHighScore:self.killCount];
    }
}

@end
