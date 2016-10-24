//
//  YPSettingController.m
//  百思不得姐
//
//  Created by yupeng on 16/10/9.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPSettingController.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"

@interface YPSettingController ()

@end

@implementation YPSettingController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self setUpNav];
    
}

-(void)setUpNav
{
    self.title = @"设置";
    self.tableView.backgroundColor = YPGlobalColor;
    
//    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const CellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        
    }
    
    //设置缓存大小
    CGFloat size  = [SDImageCache sharedImageCache].getSize / 1000.0/1000;
    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用%.02fMB)",size];
    
        //打印缓存路径
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *cachePath = [path stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
//        YPLog(@"%@",cachePath);
    
    
    return cell;
}

/**
 *  计算已经占用的缓存大小
 */
-(void)getcacheSize
{
    
}

/**
 *  监听清除缓存cell的点击
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        [SVProgressHUD showSuccessWithStatus:@"清除缓存完成~"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
        
        //刷新tableView
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
   
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
