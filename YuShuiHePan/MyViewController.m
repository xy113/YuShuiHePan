//
//  MyViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "MyViewController.h"
#import "DSXNavigationController.h"
#import "LoginViewController.h"


@interface MyViewController ()

@end

@implementation MyViewController
@synthesize mainTableView;
@synthesize avatarView;
@synthesize userStatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"个人中心"];
    
    self.userStatus = [[DSXUserStatus alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userStatusChanged) name:UserStatusChangedNotification object:nil];
    
    CGRect frame = self.view.frame;
    frame.origin.y = frame.origin.y - 60;
    self.mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 3;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140.0;
    }else {
        return 50.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.section == 0) {
        UIView *headerView = [self headView];
        [cell.contentView addSubview:headerView];
        if (self.userStatus.isLogined) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    if (indexPath.section == 1) {
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
    if (indexPath.section == 2) {
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
    
    if (indexPath.section == 3) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:DSXFontStyleDemilight size:18.0];
        if (self.userStatus.isLogined) {
            cell.textLabel.textColor = [UIColor redColor];
            cell.textLabel.text = @"退出登录";
        }
        else {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"登录";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if (indexPath.section == 0) {
        if (!self.userStatus.isLogined) {
            [self showLogin];
        }
    }
    
    if (indexPath.section == 3) {
        if (self.userStatus.isLogined) {
            [self.userStatus logout];
            [self.mainTableView setContentOffset:CGPointMake(0, 0)];
        }else {
            [self showLogin];
        }
    }
}

#pragma mark - 
- (void)userStatusChanged{
    self.userStatus = [[DSXUserStatus alloc] init];
    [self.mainTableView reloadData];
}

- (void)showLogin{
    LoginViewController *loginView = [[LoginViewController alloc] init];
    DSXNavigationController *nav = [[DSXNavigationController alloc] initWithRootViewController:loginView];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -

- (UIView *)headView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 120)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 55, 70, 70)];
    imageView.layer.cornerRadius = 35.0;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    if (self.userStatus.isLogined) {
        [imageView setImage:self.userStatus.avatar];
    }else {
        [imageView setImage:[UIImage imageNamed:@"avatar.png"]];
    }
    [view addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 65, SWIDTH-110, 20)];
    nameLabel.font = [UIFont fontWithName:DSXFontStyleMedinum size:18.0];
    nameLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
    if (self.userStatus.isLogined) {
        nameLabel.text = self.userStatus.username;
    }else {
        nameLabel.text = @"未登录";
    }
    
    [view addSubview:nameLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 93, SWIDTH-110, 20)];
    detailLabel.font = [UIFont fontWithName:DSXFontStyleDemilight size:14.0];
    detailLabel.textColor = [UIColor grayColor];
    if (self.userStatus.isLogined) {
        detailLabel.text = self.userStatus.signature;
    }else {
        detailLabel.text = @"点击此处登录,享有更多特权";
    }
    [view addSubview:detailLabel];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
