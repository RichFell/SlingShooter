//
//  LeaderBoardViewController.m
//  SlingShotter
//
//  Created by Rich Fellure on 6/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import "GameCenterManager.h"
#import "LeaderBoardTableViewCell.h"

@interface LeaderBoardViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *hsLeaderScores;

@end

@implementation LeaderBoardViewController

-(void)setHsLeaderScores:(NSArray *)hsLeaderScores {
    _hsLeaderScores = hsLeaderScores;
    if (hsLeaderScores.count <= 10) {
        [self.tableView setScrollEnabled:NO];
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[GameCenterManager sharedManager]retrieveTopTenScoresInBackground:^(NSArray *scores, NSError *error) {
        if (scores) {
            self.hsLeaderScores = scores;
        }
        if (error) {
            NSLog(@"%@", error.localizedDescription);//TODO: Add alert here
        }
    }];
}

#pragma mark - TableViewDelegate/DataSource Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeaderBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    GKScore *score = self.hsLeaderScores[indexPath.row];
    cell.playerLabel.text = score.player.alias;
    cell.scoreLabel.text = [@(score.value) stringValue];
    cell.positionLabel.text = [@(score.rank) stringValue];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hsLeaderScores.count;
}

- (IBAction)dismissVCOnTap:(UIBarButtonItem *)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
