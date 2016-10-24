//
//  YPTopicViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/16.
//  Copyright © 2016年 yupeng. All rights reserved.
//  段子控制器

#import "YPTopicViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "YPTopic.h"
#import "MJExtension.h"
#import "YPTopicCell.h"
#import "YPCommentViewController.h"
#import "YPNewViewController.h"

@interface YPTopicViewController ()

/**
 *  帖子数组
 */
@property (nonatomic,strong) NSMutableArray *topics;
/**
 *  当前页的最大时间
 *  需要加载下页数据时用到该参数
 */
@property (nonatomic,copy) NSString *maxTime;
/**
 *  当前的页码
 */
@property (nonatomic,assign) NSInteger page;
/**
 *  当前的请求参数（处理慢速网络下上拉、下拉同时进行的问题）
 */
@property (nonatomic,strong) NSMutableDictionary *params;
/**
 * 记录上次选中的索引
 */
@property (nonatomic,assign) NSInteger lastSelcetedIndex;


@end



@implementation YPTopicViewController



/**
 *  懒加载topics数组
 */
-(NSMutableArray *)topics{
    
    if ( !_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
/**
 * 设置参数a的getter方法
 */
-(NSString *)a{
    
    return [self.parentViewController isKindOfClass:[YPNewViewController class]] ? @"newlist" : @"list";
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置表格
    [self setupTableView];
    
    //添加头部控件
    [self setUpRefresh];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 设置tableView内边距

static NSString * const YPTopicCellID = @"topic";

-(void)setupTableView{
    
    CGFloat top = YPTitleViewH + YPTitleViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);//设置滚动条的内边距与tableView的内边距一样
    
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //设置表格背景色和分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册表格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YPTopicCell class]) bundle:nil] forCellReuseIdentifier:YPTopicCellID];
    
    //注册通知 监听TabBarContoller的点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClicked) name:YPTabBarDidSelectNotification object:nil];
}


#pragma mark - 添加tableView头部刷新控件
-(void)setUpRefresh{
    
    //添加头部刷新控件 默认隐藏
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //设置头部刷新控件的透明度随着下拉的幅度变化
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //自动开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    //添加底部上拉刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
}



#pragma mark - loadNewTopics
/**
 *  下拉加载最新数据
 */
-(void)loadNewTopic{
    
    //首先结束底部控件刷新（防止先下拉 再上拉）
    [self.tableView.mj_footer endRefreshing];
    
    //设置参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    //    params[@"page"] = @(self.page);
    self.params = params;
    
    
    //发送网络请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //如果两次参数不一致 返回
        if (self.params != params) return;
        
        //存储最新数据中的最大时间 用来加载下页数据
        self.maxTime = responseObject[@"info"][@"maxtime"];
        
        //取出数组数据(因为下拉获取最新数据 所以可以将原来数组中的数据直接覆盖掉)
        self.topics = [YPTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];;
        
        //刷新表格
        [self.tableView reloadData];
        
        //头部控件结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //加载最新数据 则一定是第0页的数据 (成功了之后再把page清零)
        self.page = 0;//初始化为0即可
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //如果两次参数不一致 返回
        if (self.params != params) return;
        
        //头部控件结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
    
    
}

#pragma  mark - loadMoreTopic
/**
 *  上拉加载更多数据
 */
-(void)loadMoreTopic{
    
    //结束头部控件刷新(防止先下拉再上拉)
    [self.tableView.mj_header endRefreshing];
    
    //加载更多数据 page++
    self.page++;
    
    //设置参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxTime;
    self.params = params;
    
    //发送网络请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //如果两次参数不一致 返回
        if (self.params != params) return;
        
        //存储最新数据中的最大时间 用来加载下页数据
        self.maxTime = responseObject[@"info"][@"maxtime"];
        
        //将更多数据添加到数组末尾
        NSArray *topics = [YPTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:topics];
        
        //刷新表格
        [self.tableView reloadData];
        
        //头部控件结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //如果两次参数不一致 返回
        if (self.params != params) return;
        
        //底部控件结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //恢复页码
        self.page--;
        
    }];
    
}





#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //设置底部控件是否可见
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YPTopicCell * cell = [tableView  dequeueReusableCellWithIdentifier:YPTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
       
    return cell;
}


#pragma  mark - tableView 代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出topic模型 计算cell的高度
    YPTopic * topic = self.topics[indexPath.row];
    
    //返回这个模型对应的cell高度
    return topic.cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YPCommentViewController *commentVC = [[YPCommentViewController alloc] init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

#pragma  mark - YPTabBarDidSelectNotification 处理通知
-(void)tabBarClicked{
    
    //如果是两次连续选中 直接刷新
    if (self.lastSelcetedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnKeyWindow) {
        
        [self.tableView.mj_header beginRefreshing];
    }
    
    //记录这一次选中的索引
    self.lastSelcetedIndex = self.tabBarController.selectedIndex;
}


@end
