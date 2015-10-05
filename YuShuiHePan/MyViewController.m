//
//  MyViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "MyViewController.h"
#import "DSXCommon.h"

@interface MyViewController ()

@end

@implementation MyViewController
@synthesize mainTableView;
@synthesize avatarView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"个人中心"];
    CGRect frame = self.view.frame;
    frame.size.height = frame.size.height - self.tabBarController.tabBar.frame.size.height;
    self.mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    [self setupHeadView];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 3;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我发布的";
        }
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"我关注的";
        }
        
        if (indexPath.row == 2) {
            cell.textLabel.text = @"我的收藏";
        }
    }
    if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关于";
        }
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"评分";
        }
        
        if (indexPath.row == 2) {
            cell.textLabel.text = @"反馈";
        }
    }
    
    if (indexPath.section == 2) {
        cell.textLabel.text = @"退出登录";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
}

#pragma mark - 
- (void)setupHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 100)];
    headView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.tableHeaderView = headView;
    
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    self.avatarView.image = [UIImage imageNamed:@"avatar.png"];
    [headView addSubview:self.avatarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
