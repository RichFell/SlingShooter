//
//  LeaderBoardTableViewCell.h
//  SlingShotter
//
//  Created by Rich Fellure on 6/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
