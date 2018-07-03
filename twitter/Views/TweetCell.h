//
//  TweetCell.h
//  twitter
//
//  Created by Jonathan Cabrera on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel.h>

@interface TweetCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
// Change to TTTAttributeLabel later yo!!!!!
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;



@end
