//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "ComposeViewController.h"
#import "LoginViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import <UIRefreshControl+AFNetworking.h>

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>


@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //initialize refreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    //bind action to refresh control
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];

    // add refresh control to table view
    [self.tableView insertSubview:refreshControl atIndex:0];

    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweetsDict, NSError *error) {
        if (tweetsDict) {
            
            self.tweets = tweetsDict;

        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
        [self.tableView reloadData];
        [refreshControl endRefreshing];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     UINavigationController *navigationController = [segue destinationViewController];
     ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
     composeController.delegate = self;
 }


- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweetsDict, NSError *error) {
        if (tweetsDict) {
            
            self.tweets = tweetsDict;
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
        [self.tableView reloadData];
        [refreshControl endRefreshing];
                                                
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.tweet = self.tweets[indexPath.row];
    
    User  *user = cell.tweet.user;
    cell.screenNameLabel.text = user.screenName;
    cell.userNameLabel.text = user.name;
    cell.tweetLabel.text = cell.tweet.text;
    
    [cell.favoriteBtn  setTitle:[NSString stringWithFormat:@"%d", cell.tweet.favoriteCount] forState:UIControlStateNormal];
    [cell.retweetBtn  setTitle:[NSString stringWithFormat:@"%d", cell.tweet.retweetCount] forState:UIControlStateNormal];
    if (cell.tweet.favorited) {
        [cell.favoriteBtn setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [cell.favoriteBtn setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];

    }
    if (cell.tweet.retweeted) {
        [cell.retweetBtn setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [cell.retweetBtn setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];

    }

    NSURL *profilePhotoURL = [NSURL URLWithString:user.profilePhoto];
    [cell.profileImage setImageWithURL:profilePhotoURL];
    
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (void)didTweet:(Tweet *)tweet {
    [self.tweets addObject:tweet];
    [self.tableView reloadData];
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}

@end
