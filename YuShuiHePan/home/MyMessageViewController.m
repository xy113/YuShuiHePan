//
//  MyMessageViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/10/12.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "MyMessageViewController.h"
#import "ShowMessageViewController.h"

@implementation MyMessageViewController
@synthesize mainTableView;
@synthesize userStatus;
@synthesize operationQueue;
@synthesize tableViewData;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"消息中心"];
    self.navigationItem.leftBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleBack target:self action:@selector(back)];
    self.userStatus = [[DSXUserStatus alloc] init];
    
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 108;
    self.mainTableView = [[DSXTableView alloc] initWithFrame:frame];
    self.mainTableView.tableViewDelegate = self;
    self.mainTableView.pageSize = 20;
    [self.view addSubview:self.mainTableView];
    
    self.tableViewData = [[NSUserDefaults standardUserDefaults] dataForKey:@"myMessage"];
    [self.mainTableView reloadTableViewWithData:self.tableViewData];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.mainTableView.waitingView startAnimating];
    [self tableViewStartRefreshing];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadData{
    [self.operationQueue addOperationWithBlock:^{
        NSString *urlString = [SITEAPI stringByAppendingFormat:@"&ac=my&op=message&uid=%ld&page=%d",(long)self.userStatus.uid,_page];
        self.tableViewData = [[DSXUtil sharedUtil] dataWithURL:urlString];
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
    }];
}

- (void)reloadTableView{
    if ([self.tableViewData length] > 2 && self.mainTableView.isRefreshing) {
        [[NSUserDefaults standardUserDefaults] setObject:self.tableViewData forKey:@"myMessage"];
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
    if ([self.tableViewData length] < 3) {
        [[DSXUI sharedUI] showPopViewWithStyle:DSXPopViewStyleDefault Message:@"暂无信息"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myMessageCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myMessageCell"];
    }
    NSDictionary *article = [self.mainTableView.rows objectAtIndex:indexPath.row];
    cell.textLabel.text = [article objectForKey:@"message"];
    cell.textLabel.font = [UIFont fontWithName:DSXFontStyleMedinum size:16.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tag = [[article objectForKey:@"mid"] intValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    ShowMessageViewController *showMessageView = [[ShowMessageViewController alloc] init];
    showMessageView.mid = cell.tag;
    [self.navigationController pushViewController:showMessageView animated:YES];
}

@end
