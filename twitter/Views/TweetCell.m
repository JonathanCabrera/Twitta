//
//  TweetCell.m
//  twitter
//
//  Created by Jonathan Cabrera on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)didTapReply:(id)sender {
    
}


- (IBAction)didTapRetweet:(id)sender {
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    } else {
        [sender setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
}


- (IBAction)didTapFavorite:(id)sender {
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        [sender setSelected:NO];

    } else {
        [sender setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
}


- (IBAction)didTapDirectMessage:(id)sender {
    
}



@end
