//
//  GameViewController.m
//  SlingShotter
//
//  Created by Rich Fellure on 5/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "GameViewController.h"
#import "GameOverViewController.h"

@implementation GameViewController

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self showGameScene];
}

#pragma mark - Present GameScene
-(void)showGameScene {

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        skView.showsPhysics = NO;

        // Create and configure the scene.
        self.gameScene = [GameScene sceneWithSize:skView.bounds.size];
        self.gameScene.scaleMode = SKSceneScaleModeAspectFill;
        self.gameScene.gameSceneDelegate = self;

        // Present the scene.
        [skView presentScene:self.gameScene];
    }
}

#pragma mark - Public Instance methods
-(void)transitionToANewScene {
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionRight duration:0.2];
    transition.pausesIncomingScene = YES;
    transition.pausesOutgoingScene = YES;
    self.gameScene = nil;
    self.gameScene = [GameScene sceneWithSize:self.view.bounds.size];
    self.gameScene.gameSceneDelegate = self;
    self.gameScene.scaleMode = SKSceneScaleModeFill;
    SKView *skView = (SKView *)self.view;
    skView.paused = NO;
    [skView presentScene:self.gameScene transition:transition];
}

#pragma mark - GameSceneDelegate Method
-(void)gameScene:(GameScene *)gameScene shouldEndGame:(BOOL)shouldEnd {
    if (shouldEnd) {
        GameOverViewController *gameOVC = [GameOverViewController storyboardInstance];
        gameOVC.delegate = self;
        gameOVC.killCount = self.gameScene.killCount;
        [self presentViewController:gameOVC animated:true completion:^{
        }];
    }
}

#pragma mark - GameOverSceneDelegate Method
-(void)gameOverVC:(GameOverViewController *)vc restartSelected:(BOOL)selection {
    if (selection) {
        [vc dismissViewControllerAnimated:YES completion:^{
            [self transitionToANewScene];
        }];
    }
}

@end
