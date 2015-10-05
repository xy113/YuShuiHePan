//
//  ListViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "DSXCommon.h"

@implementation ListViewController
@synthesize catid;
@synthesize mainTableView;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:BGCOLOR];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    CGRect frame = self.view.frame;
    frame.size.height = SHEIGHT - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height - 10;
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tag = [[article objectForKey:@"id"] integerValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    DetailViewController *detailController = [[DetailViewController alloc] init];
    detailController.aid = cell.tag;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
