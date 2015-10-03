//
//  HomeViewController.m
//  YuShuiHePan
//
//  Created by songdewei on 15/9/15.
//  Copyright (c) 2015年 yushuihepan. All rights reserved.
//

#import "HomeViewController.h"
#import "ListViewController.h"
#import "LoginViewController.h"
#import "Common.h"

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"玉水河畔"];
    [self.navigationController.tabBarItem setTitle:@"玉水文苑"];
    [self.view setBackgroundColor:BGCOLOR];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(showLogin)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.categoryList = [[NSUserDefaults standardUserDefaults] arrayForKey:@"categorylist"];
    if (!self.categoryList) {
        NSString *urlString = [SITEAPI stringByAppendingString:@"&ac=category"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        id array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            self.categoryList = array;
        }
    }
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self setView:self.mainTableView];
}

- (void)showLogin{
    LoginViewController *loginController = [[LoginViewController alloc] init];
    [self presentViewController:loginController animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.categoryList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.categoryList[section] objectForKey:@"childs"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellForCate"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellForCate"];
    }
    NSDictionary *category = [[self.categoryList[indexPath.section] objectForKey:@"childs"] objectAtIndex:indexPath.row];
    cell.textLabel.text = [category objectForKey:@"cname"];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    NSDictionary *category = [[self.categoryList[indexPath.section] objectForKey:@"childs"] objectAtIndex:indexPath.row];
    ListViewController *listViewController = [[ListViewController alloc] init];
    [listViewController setTitle:[category objectForKey:@"cname"]];
    [listViewController setCatid:[[category objectForKey:@"catid"] intValue]];
    [self.navigationController pushViewController:listViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
    label.text = [self.categoryList[section] objectForKey:@"cname"];
    label.font = [UIFont systemFontOfSize:18.0 weight:600];
    [label sizeToFit];
    [view addSubview:label];
    return view;
}

@end
