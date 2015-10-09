//
//  MyArticleViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/9.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "MyArticleViewController.h"
#import "DetailViewController.h"

@implementation MyArticleViewController

@synthesize mainTableView;
@synthesize userStatus;
@synthesize operationQueue;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"我发布的"];
    self.userStatus = [[DSXUserStatus alloc] init];
    
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 44;
    self.mainTableView = [[DSXTableView alloc] initWithFrame:frame];
    self.mainTableView.tableViewDelegate = self;
    self.mainTableView.pageSize = 20;
    [self.view addSubview:self.mainTableView];
    [self.mainTableView reloadTableViewWithData:[[NSUserDefaults standardUserDefaults] dataForKey:@"myArticle"]];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.mainTableView.waitingView startAnimating];
    [self tableViewStartLoading];
}

- (void)downloadData{
    [self.operationQueue addOperationWithBlock:^{
        NSString *urlString = [SITEAPI stringByAppendingFormat:@"&ac=my&op=article&page=%d",_page];
        NSData *data = [[DSXUtil sharedUtil] dataWithURL:urlString];
        [self performSelectorOnMainThread:@selector(reloadTableViewWithData:) withObject:data waitUntilDone:NO];
    }];
}

- (void)reloadTableViewWithData:(NSData *)data{
    if ([data length] > 2 && self.mainTableView.isRefreshing) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"myArticle"];
    }
    [self.mainTableView reloadTableViewWithData:data];
}

#pragma mark - tableView delegate
- (void)tableViewStartRefreshing{
    _page = 1;
    self.mainTableView.isRefreshing = YES;
    [self downloadData];
}

- (void)tableViewStartLoading{
    _page++;
    [self downloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myArticleCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myArticleCell"];
    }
    return cell;
}

@end
