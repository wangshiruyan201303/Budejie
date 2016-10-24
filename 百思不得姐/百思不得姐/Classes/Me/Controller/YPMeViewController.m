//
//  YPMeViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPMeViewController.h"
#import "YPMeCell.h"
#import "YPMeFooterView.h"
#import "YPSettingController.h"

@interface YPMeViewController ()

@end

static NSString * YPMeCellId = @"cell";

@implementation YPMeViewController



- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTableView];
    
    
}

-(void)setUpNav{
    
    
    self.navigationItem.title = @"我的";
    
    //设置左边item
    
    UIBarButtonItem * settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingBtnClick)];
    UIBarButtonItem * moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonModelBtnClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
    //设置视图的背景色
    self.tableView.backgroundColor = YPRGBColor(233, 233, 233);
}

-(void)setUpTableView{
    
    [self.tableView registerClass:[YPMeCell class] forCellReuseIdentifier:YPMeCellId];
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置Footer
    YPMeFooterView * footer = [[YPMeFooterView alloc] init];
    self.tableView.tableFooterView = footer;
    self.tableView.contentInset = UIEdgeInsetsMake(YPTopicCellMargin - 35, 0, 850, 0);
    [self.tableView setNeedsDisplay];

    
    
    
}


-(void)settingBtnClick{
    
    [self.navigationController pushViewController:[[YPSettingController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}

-(void)moonModelBtnClick{
    
    YPLogFunc
}

#pragma  mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


#pragma  mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPMeCell * cell = [tableView dequeueReusableCellWithIdentifier:YPMeCellId];
    if (indexPath.section == 0) {
//        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if(indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}










@end
