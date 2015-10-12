//
//  GameOverViewController.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/23/15.
//  Copyright (c) 2015 RichFellure. All rights reserved.
//

#import "GameOverViewController.h"
#import "UserDefaults.h"
#import "GameCenterManager.h"

@interface GameOverViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;

@end

@implementation GameOverViewController

static NSString *const kBackgroundImage = @"GameOver";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameOverLabel.alpha = 0.0;
    self.highScoreLabel.alpha = 0.0;
    self.scoreLabel.alpha = 0.0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.killCount];
    [UserDefaults checkHighScoreAgainst:self.killCount];
    self.highScoreLabel.text = [NSString stringWithFormat:@"High Score: %ld", [UserDefaults highScore]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    [self animateLabels];
}

#pragma mark - IBActions
- (IBAction)restartOnTap:(UIButton *)sender {
    [self.delegate gameOverVC:self
              restartSelected:YES];
}

- (void)animateLabels {
    [UIView animateWithDuration:0.5 animations:^{
        self.gameOverLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self animateScoreLabels];
        }
    }];
}

- (void)animateScoreLabels {
    [UIView animateWithDuration:0.5 animations:^{
        self.highScoreLabel.alpha = 1.0;
        self.scoreLabel.alpha = 1.0;
    }];
}

@end
