//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import <UIRefreshControl+AFNetworking.h>

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;

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

    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweetsDict, NSError *error) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)loadMoreData{
//    
//    // ... Create the NSURLRequest (myRequest) ...
//    
//    // Configure session so that completion handler is executed on main UI thread
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    NSURLSession *session  = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//    
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *requestError) {
//        if (requestError != nil) {
//            
//        }
//        else
//        {
//            // Update flag
//            self.isMoreDataLoading = false;
//            
//            // ... Use the new data to update the data source ...
//            
//            // Reload the tableView now that there is new data
//            [self.tableView reloadData];
//        }
//    }];
//    [task resume];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (!self.isMoreDataLoading) {
//        int scrollViewContentHeight = self.tableView.contentSize.height;
//        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
//        
//        // When the user has scrolled past the threshold, start requesting
//        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
//            self.isMoreDataLoading = true;
//            
//        }
//    }
//}
//

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    // Create NSURL and NSURLRequest
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                
                                                // ... Use the new data to update the data source ...
                                                
                                                // Reload the tableView now that there is new data
                                                [self.tableView reloadData];
                                                
                                                // Tell the refreshControl to stop spinning
                                                [refreshControl endRefreshing];
                                                
                                            }];
    
    [task resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    NSLog(@"%@", tweet.text);
    User  *user = tweet.user;
    cell.screenNameLabel.text = user.screenName;
    cell.userNameLabel.text = user.name;
    cell.tweetLabel.text = tweet.text;
    
    NSURL *profilePhotoURL = [NSURL URLWithString:user.profilePhoto];
    [cell.profileImage setImageWithURL:profilePhotoURL];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
