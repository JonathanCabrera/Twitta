//
//  TweetCell.m
//  twitter
//
//  Created by Jonathan Cabrera on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//- (IBAction)didTapReply:(id)sender {
//
//}


// Try creating a refreshData() method in your cell that updates all of your views, i.e.
// sets the labels to their respective text, etc.


// Code below can def be cleaned up

- (IBAction)didTapRetweet:(id)sender {
    if (![sender isSelected]) {
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            [sender setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
            [sender setSelected:YES];
            self.tweet.retweeted = YES;
            self.tweet.retweetCount += 1;
            [self.retweetBtn setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount] forState:UIControlStateNormal];
        }];
    } else {
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            [sender setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            self.tweet.retweeted = NO;
            self.tweet.retweetCount -= 1;
            [self.retweetBtn setTitle:[NSString stringWithFormat:@"%d", self.tweet.retweetCount] forState:UIControlStateNormal];
        }];

    }

}

- (IBAction)didTapFavorite:(id)sender {

    if (![sender isSelected]) {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            [sender setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
            [sender setSelected:YES];
            self.tweet.favorited = YES;
            self.tweet.favoriteCount += 1;
            [self.favoriteBtn  setTitle:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] forState:UIControlStateNormal];
        }];
    } else {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            [sender setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
            [sender setSelected:NO];
            self.tweet.favorited = NO;
            self.tweet.favoriteCount -= 1;
            [self.favoriteBtn  setTitle:[NSString stringWithFormat:@"%d", self.tweet.favoriteCount] forState:UIControlStateNormal];
        }];
    }
}

//- (IBAction)didTapDirectMessage:(id)sender {
//
//}



@end
