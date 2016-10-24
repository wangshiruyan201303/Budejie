//
//  YPRecommendViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/9.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "YPRecommendCategory.h"
#import "YPRecommendCategoryCell.h"
#import "YPRecommendUser.h"
#import "YPRecommendUserCell.h"
#import "MJRefresh.h"


#define YPSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface YPRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  左边类别表格TableView
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**
 *  右边用户表格TableView
 */

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/**
 *  存放左边类别数据模型数组
 */
@property (nonatomic,strong) NSArray * categories;
/**
 *  存放请求参数的字典(多次点击category，只需处理最后一次请求)
 */
@property (nonatomic,strong) NSMutableDictionary * params;

/**
 *  AFN请求管理者
 */
@property (nonatomic,strong) AFHTTPSessionManager * manager;

@end

@implementation YPRecommendViewController

static NSString * const YPCategoryCellId = @"category";
static NSString * const YPUserCellId = @"user";

/**
 *  懒加载manager
 */
-(AFHTTPSessionManager *)manager{
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //配置TableView
    [self setup];
    
    //添加刷新控件
    [self setupRefresh];
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //发送网络请求
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //数据转模型
        self.categories = [YPRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView  reloadData];
        
        //默认选中首行，一定要放在刷新数据之后
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让userTableView进入下拉刷新状态 即进入软件后，自动加载第一个category所对应的用户数据 负责要用户手动加载
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取推荐信息失败~"];
    }];
}

/**
 *  表格基本设置
 */

-(void)setup{
    
    
    //设置导航栏标题
    self.navigationItem.title = @"推荐关注";
    //设置背景颜色
    self.view.backgroundColor = YPGlobalColor;
    self.categoryTableView.backgroundColor = YPGlobalColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //注册categoryTableaView的cell
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YPRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:YPCategoryCellId];
     //注册userTableaView的cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YPRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:YPUserCellId];

    
}

/**
 *  添加刷新控件
 */

-(void)setupRefresh{
    
    //头部下拉刷新
    self.userTableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    //底部上拉刷新
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
//    self.userTableView.mj_footer.hidden = YES;
    
    
}

/**
 *  加载最新用户数据
 */

-(void)loadNewUsers{
    
    YPRecommendCategory * category = YPSelectedCategory;
    
    //没有数据时，应该请求第一页的数据
    category.currentPage = 1;
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        //字典转模型
        NSArray * users = [YPRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //下拉刷新 则需要展示最新数据，故应清空旧数据
        [category.users removeAllObjects];
        
        //将模型添加到该类别的数组中
        [category.users addObjectsFromArray:users];
        
        //保存当前类别的用户总数
        category.total = [responseObject[@"total"] integerValue];
        
        //多次点击，处理最后一次请求
        if (self.params != params) return ;
        
        //刷新表格
        [self.userTableView reloadData];
        
        //头部控件结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        //检测底部mj_footer应该显示的状态
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //多次点击，处理最后一次请求
        if (self.params != params) return ;
        
        //提醒用户数据加载失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败~"];
        
        //头部控件结束刷新
        [self.userTableView.mj_header endRefreshing];
        YPLog(@"%@",error);
    }];
    

    
    
}

/**
 *  加载更多用户数据
 */

-(void)loadMoreUsers{
    
    YPRecommendCategory * category = YPSelectedCategory;
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSArray * users = [YPRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //将模型添加到该类别的数组中
        [category.users addObjectsFromArray:users];
        
        //如果用户多次点击，只需处理最后一次请求
        if (self.params != params) return ;
        //刷新表格
        [self.userTableView reloadData];
        
        //检测底部mj_footer应该显示的状态
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //多次点击，处理最后一次请求
        if (self.params != params) return ;
        
        //如果是同一次请求，但请求失败了
        [SVProgressHUD showErrorWithStatus:@"请求数据失败~"];
        //底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];

    
}


/**
 *  检测底部mj_footer应该显示的状态
 */
-(void)checkFooterState{
    
    YPRecommendCategory * category = YPSelectedCategory;
    
    //设置右边userTableView的底部刷新控件的可见性
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    if (category.users.count == category.total) { //提示用户没有更多数据
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else{  //底部控件结束刷新
        
        [self.userTableView.mj_footer endRefreshing];
    }
    
}


#pragma mark - 左边和右边表格数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView) {
        
        return self.categories.count;
        
    } else{
        
        //检测底部footer的状态
        [self checkFooterState];
        return [YPSelectedCategory users].count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        YPRecommendCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:YPCategoryCellId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }
    else{
        
        YPRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:YPUserCellId];
        cell.user = [YPSelectedCategory users][indexPath.row];
        return cell;
    }
    
}


#pragma mark - 左边表格代理方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //首先结束头部和底部控件的刷新 防止上次的刷新动画出现在下个类别中
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    YPRecommendCategory * category = self.categories[indexPath.row];
    if (category.users.count) {
        
        //如果某个类别已有数据 直接刷新表格
        [self.userTableView reloadData];
        
    } else{//如果没有数据 发送请求
    
    //没有数据 也立即将右边用户表格刷新  防止用户看见上次的数据
    [self.userTableView reloadData];
    
    //没有数据，则让头部控件进入刷新状态 加载最新数据
    [self.userTableView.mj_header   beginRefreshing];
   
    }
}

#pragma mark - 控制器的销毁
/**
 *  当APP在请求数据但用户退出当前页面时 应取消所有网络请求
 */

-(void)dealloc{
    
    [self.manager.operationQueue cancelAllOperations];
}

@end
