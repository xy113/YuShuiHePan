//
//  WxyhViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/29.
//  Copyright © 2015年 yushuihepan. All rights reserved.
//

#import "WxyhViewController.h"
#import "WxyhPlayViewController.h"

@implementation WxyhViewController
@synthesize mainTableView;
@synthesize operationQueue;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"温馨夜话"];
    
    self.navigationItem.rightBarButtonItem = [[DSXUI sharedUI] barButtonWithStyle:DSXBarButtonStyleRefresh target:self action:@selector(clickRefresh)];
    
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - 60;
    self.mainTableView = [[DSXTableView alloc] initWithFrame:frame];
    self.mainTableView.pageSize = 20;
    self.mainTableView.tableViewDelegate = self;
    [self.view addSubview:self.mainTableView];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] dataForKey:@"wxyhList"];
    if (data) {
        [self reloadTableViewWithData:data];
    }else {
        [self.mainTableView.waitingView startAnimating];
        [self tableViewStartRefreshing];
    }
    
}

- (void)downloadData{
    [self.operationQueue addOperationWithBlock:^{
        NSString *urlString = [SITEAPI stringByAppendingFormat:@"&ac=wxyh&op=list&page=%d",_page];
        NSData *data = [[DSXUtil sharedUtil] dataWithURL:urlString];
        if ([data length]>2) {
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"wxyhList"];
        }
        [self performSelectorOnMainThread:@selector(reloadTableViewWithData:) withObject:data waitUntilDone:YES];
    }];
}

- (void)reloadTableViewWithData:(NSData *)data{
    [self.mainTableView reloadTableViewWithData:data];
}

- (void)tableViewStartRefreshing{
    _page = 1;
    [self.mainTableView setIsRefreshing:YES];
    [self downloadData];
}

- (void)tableViewStartLoading{
    _page++;
    [self downloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellForWxyh"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellForWxyh"];
    }else {
        for (UIView *subview in cell.contentView.subviews) {
            [subview removeFromSuperview];
        }
    }
    NSDictionary *item = [self.mainTableView.rows objectAtIndex:indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 50)];
    [imageView setImage:[UIImage imageNamed:@"gaoyang.png"]];
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    [cell.contentView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, SWIDTH-100, 20)];
    titleLabel.text = [item objectForKey:@"title"];
    titleLabel.font = [UIFont fontWithName:DSXFontStyleMedinum size:16.0];
    [cell.contentView addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 35, SWIDTH-100, 20)];
    detailLabel.text = @"高阳主持,心灵思雨,与你轻声附和";
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.font = [UIFont systemFontOfSize:14.0];
    [cell.contentView addSubview:detailLabel];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tag = [[item objectForKey:@"id"] intValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    WxyhPlayViewController *playViewController = [[WxyhPlayViewController alloc] init];
    playViewController.ID = cell.tag;
    playViewController.articleTitle = [self.mainTableView.rows[indexPath.row] objectForKey:@"title"];
    [self.navigationController pushViewController:playViewController animated:YES];
}

- (void)clickRefresh{
    [self.mainTableView.waitingView startAnimating];
    [self tableViewStartRefreshing];
}

@end
