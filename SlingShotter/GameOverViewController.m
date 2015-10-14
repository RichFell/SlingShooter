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
#import "SlingShotter-Swift.h"

@interface GameOverViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longestTimeLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;


@property GameLogicManager *logicManager;

@end

@implementation GameOverViewController

static float const LabelStartingAlpha = 0.0;
static float const LabelEndingAlpha =   1.0;

static NSString *const kBackgroundImage = @"GameOver";

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UILabel *label in self.labels) {
        label.alpha = LabelStartingAlpha;
    }
    self.gameOverLabel.alpha = LabelStartingAlpha;

    self.logicManager = [GameLogicManager sharedInstance];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.logicManager.killCount];
    [UserDefaults checkHighScoreAgainst:self.logicManager.killCount];
    self.highScoreLabel.text = [NSString stringWithFormat:@"High Score: %ld", [UserDefaults highScore]];
    self.lastTimeLabel.text = [NSString stringWithFormat:@"Current Time: %ld sec", (long)self.logicManager.timeRan];
    self.longestTimeLabel.text = [NSString stringWithFormat:@"Longest Time: %ld sec", [UserDefaults longestTimeSurvived]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
    [self animateLabels];
}

#pragma mark - IBActions
- (IBAction)restartOnTap:(UIButton *)sender {
    [[GameLogicManager sharedInstance]reset];
    [self.delegate gameOverVC:self
              restartSelected:YES];
}

- (void)animateLabels {
    [UIView animateWithDuration:0.5 animations:^{
        self.gameOverLabel.alpha = LabelEndingAlpha;
    } completion:^(BOOL finished) {
        if (finished) {
            [self animateScoreLabels];
        }
    }];
}

- (void)animateScoreLabels {
    [UIView animateWithDuration:0.5 animations:^{
        for (UILabel *label in self.labels) {
            label.alpha = LabelEndingAlpha;
        }
    }];
}

@end
