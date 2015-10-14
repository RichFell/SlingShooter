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

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *hsLeaderScores;

typedef void(^ScoresBlock)(NSArray *array, NSError *error);

@end

@implementation LeaderBoardViewController

#pragma mark - Setters/Getters
- (void)setHsLeaderScores:(NSArray *)hsLeaderScores {
    _hsLeaderScores = hsLeaderScores;
    if (hsLeaderScores.count <= 10) {
        [self.tableView setScrollEnabled:NO];
    }
    [self.tableView reloadData];
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self selectedListToDisplay:self.segmentedControl];
}

#pragma mark - TableViewDelegate/DataSource Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeaderBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    GKScore *score = self.hsLeaderScores[indexPath.row];
    cell.playerLabel.text = score.player.alias;
    cell.scoreLabel.text = [@(score.value) stringValue];
    cell.positionLabel.text = [@(score.rank) stringValue];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hsLeaderScores.count;
}

#pragma mark - Actions
- (IBAction)dismissVCOnTap:(UIBarButtonItem *)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectedListToDisplay:(UISegmentedControl *)sender {

    void (^Scores)(NSArray *scores, NSError *error) = ^(NSArray *scores, NSError *error) {
        if (scores) {
            self.hsLeaderScores = scores;
        } else {
            self.hsLeaderScores = @[];
        }
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
    };
    switch (sender.selectedSegmentIndex) {
        case 0:
            [[GameCenterManager sharedManager]retrieveTopTenScoresInBackground:Scores];
            break;
        case 1:
            [[GameCenterManager sharedManager]retrieveTopTenTimesInBackground:Scores];
        default:
            break;
    }
}

@end
