//
//  YPRecommendTagViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/11.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPRecommendTagViewController.h"
#import "YPRecommendTag.h"
#import "YPRecommendTagCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

@interface YPRecommendTagViewController ()

@property (nonatomic,strong) NSArray * tags;

@end

static NSString * const YPRecommendCellID = @"tag";

@implementation YPRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self setUp];
    
    //加载推荐标签
    [self loadRecommendTag];
    
}

-(void)setUp{
    
    self.navigationItem.title = @"推荐关注";
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = YPGlobalColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YPRecommendTagCell  class]) bundle:nil] forCellReuseIdentifier:YPRecommendCellID];
    
}

/**
 *  从服务器加载推荐关注数据
 */
-(void)loadRecommendTag{
    
    //添加遮盖
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    
    //连接服务器
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //数组转模型
        self.tags = [YPRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        
        //删除遮盖
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 提醒加载数据失败
        [SVProgressHUD showErrorWithStatus:@"推荐表前数据加载失败~"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPRecommendTagCell * cell = [tableView dequeueReusableCellWithIdentifier:YPRecommendCellID];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}



@end
