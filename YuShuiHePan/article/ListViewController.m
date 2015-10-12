//
//  ListViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "DSXNavigationController.h"
#import "LoginViewController.h"
#import "PublishViewController.h"

@implementation ListViewController
@synthesize catid;
@synthesize mainTableView;
@synthesize userStatus;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGCOLOR];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleAdd target:self action:@selector(addnew)];
    
    self.userStatus = [[DSXUserStatus alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userStatusChanged) name:UserStatusChangedNotification object:nil];
    
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 60;
    self.mainTableView = [[DSXTableView alloc] initWithFrame:frame];
    self.mainTableView.tableViewDelegate = self;
    self.mainTableView.pageSize = 20;
    [self.view addSubview:self.mainTableView];
    
    _keyName = [NSString stringWithFormat:@"article_list_%ld",(long)self.catid];
    [self reloadTableViewWithData:[[NSUserDefaults standardUserDefaults] dataForKey:_keyName]];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.mainTableView.waitingView startAnimating];
    [self tableViewStartRefreshing];
}

- (void)downloadData{
    [self.operationQueue addOperationWithBlock:^{
        NSString *urlString = [SITEAPI stringByAppendingFormat:@"&ac=list&catid=%d&page=%d",(int)self.catid,_page];
        NSData *data = [[DSXUtil sharedUtil] dataWithURL:urlString];
        [self performSelectorOnMainThread:@selector(reloadTableViewWithData:) withObject:data waitUntilDone:YES];
    }];
}

- (void)reloadTableViewWithData:(NSData *)data{
    if ([data length]>2 && self.mainTableView.isRefreshing) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:_keyName];
    }
    [self.mainTableView reloadTableViewWithData:data];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addnew{
    if (self.userStatus.isLogined) {
        PublishViewController *publishView = [[PublishViewController alloc] init];
        publishView.catid = self.catid;
        [self.navigationController pushViewController:publishView animated:YES];
    }else {
        LoginViewController *loginView = [[LoginViewController alloc] init];
        DSXNavigationController *nav = [[DSXNavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)userStatusChanged{
    self.userStatus = [[DSXUserStatus alloc] init];
}

#pragma mark - tableview delegate
- (void)tableViewStartRefreshing{
    _page = 1;
    [self downloadData];
}

- (void)tableViewEndRefreshing{
    
}

- (void)tableViewStartLoading{
    _page++;
    [self downloadData];
}

- (void)tableViewEndLoading{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellForArticle"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellForArticle"];
    }
    NSDictionary *article = [self.mainTableView.rows objectAtIndex:indexPath.row];
    cell.textLabel.text = [article objectForKey:@"title"];
    cell.textLabel.font = [UIFont fontWithName:DSXFontStyleDemilight size:18.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tag = [[article objectForKey:@"id"] integerValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    DetailViewController *detailController = [[DetailViewController alloc] init];
    detailController.aid = cell.tag;
    detailController.articleTitle = cell.textLabel.text;
    detailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
