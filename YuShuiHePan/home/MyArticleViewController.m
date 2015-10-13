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
@synthesize tableViewData;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"我发布的"];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    //self.navigationItem.rightBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleAdd target:self action:@selector(addnew)];
    self.userStatus = [[DSXUserStatus alloc] init];
    
    CGRect frame = self.view.frame;
    self.mainTableView = [[DSXTableView alloc] initWithFrame:frame];
    self.mainTableView.tableViewDelegate = self;
    self.mainTableView.pageSize = 20;
    [self.view addSubview:self.mainTableView];
    
    self.tableViewData = [[NSUserDefaults standardUserDefaults] dataForKey:@"myArticle"];
    [self.mainTableView reloadTableViewWithData:self.tableViewData];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.mainTableView.waitingView startAnimating];
    [self tableViewStartRefreshing];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addnew{
    
}

- (void)downloadData{
    [self.operationQueue addOperationWithBlock:^{
        NSString *urlString = [SITEAPI stringByAppendingFormat:@"&ac=my&op=article&uid=%ld&page=%d",(long)self.userStatus.uid,_page];
        self.tableViewData = [[DSXUtil sharedUtil] dataWithURL:urlString];
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
    }];
}

- (void)reloadTableView{
    if ([self.tableViewData length] > 2 && self.mainTableView.isRefreshing) {
        [[NSUserDefaults standardUserDefaults] setObject:self.tableViewData forKey:@"myArticle"];
    }
    [self.mainTableView reloadTableViewWithData:self.tableViewData];
}

#pragma mark - tableView delegate
- (void)tableViewStartRefreshing{
    _page = 1;
    self.mainTableView.isRefreshing = YES;
    [self downloadData];
}

- (void)tableViewEndRefreshing{
    if ([self.mainTableView.rows count] == 0) {
        [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDefault Message:@"你还没有发表过文章"];
    }
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
    NSDictionary *article = [self.mainTableView.rows objectAtIndex:indexPath.row];
    cell.textLabel.text = [article objectForKey:@"title"];
    cell.textLabel.font = [UIFont fontWithName:DSXFontStyleDemilight size:18.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tag = [[article objectForKey:@"id"] intValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    DetailViewController *detailView = [[DetailViewController alloc] init];
    detailView.aid = cell.tag;
    [detailView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailView animated:YES];
}

@end
