//
//  YPCommentViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/9/27.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPCommentViewController.h"
#import "YPTopicCell.h"
#import "YPTopic.h"
#import "AFNetworking.h"
#import "YPComment.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "YPCommentHeaderView.h"
#import "YPCommentCell.h"

static NSString * YPCommentCellID = @"Comment";

@interface YPCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  工具条底部间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarSpace;
/**
 *  评论tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  最热评论
 */
@property (nonatomic,strong) NSArray * hotComment;
/**
 *  最新评论
 */
@property (nonatomic,strong) NSMutableArray * latestComment;
/**
 *  存储热门评论数据
 */
@property (nonatomic,strong) YPComment * save_top_cmt;
/**
 *  当前页码
 */
@property (nonatomic,assign) NSInteger  page;
/**
 *  Session Manager
 */
@property (nonatomic,strong) AFHTTPSessionManager * manager;

@end

@implementation YPCommentViewController

-(AFHTTPSessionManager *)manager{
    if ( !_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //基本设置
    [self setUpBasic];
    //设置tableView的headerView
    [self setUpHeaderView];
    //设置刷新控件
    [self setUpRefresh];
    
}

-(void)setUpBasic{
    
    //设置标题
    self.title = @"评论区";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    // cell高度设置
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    //添加监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //设置tableView背景色
    self.tableView.backgroundColor = YPGlobalColor;
    
    //注册评论表格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YPCommentCell class]) bundle:nil] forCellReuseIdentifier:YPCommentCellID];
    
    //关闭系统自带分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, YPTopicCellMargin,0 );
    
    
}


/**
 *  设置tableView的headerView
 */
-(void)setUpHeaderView{
    
    //创建headerView
    UIView * header = [[UIView alloc] init];
    
    //清空cell中的热门评论
     // 清空之前先保存
    if (self.topic.top_cmt) {
        self.save_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        //重新计算cell的高度
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    //headerView实际上是一个cell
    YPTopicCell *cell = [YPTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(YPScreenW, self.topic.cellHeight);//因为size方法没有重写，所以在调用size方法的时候，有效果。
    [header addSubview:cell];
    
    //headerView的高度
    header.height = self.topic.cellHeight + YPTopicCellMargin ;
    
    self.tableView.tableHeaderView = header;
    
    
}

/**
 *  添加刷新控件
 */
-(void)setUpRefresh{
    
    //头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)   ];
    [self.tableView.mj_header beginRefreshing];
    
    //尾部刷新控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    //因tableView是从xib中创建，一开始不会去调动numberOfSection方法，所以手都隐藏footer
    self.tableView.mj_footer.hidden = YES;
    
}


/**
 *  加载评论
 */
-(void)loadNewComments{
    
    //先取消以前的所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
      //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    //从服务器获取数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //处理服务器在没有评论时返回空数组的情况
        if ( ![responseObject  isKindOfClass:[NSDictionary class]]) //说明没有评论数据
        {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        //数据转模型
        self.hotComment = [YPComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComment = [YPComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //页码设置
        self.page = 1;
        
        //刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        //控制尾部刷新控件
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComment.count >= total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
    
}

/**
 *  加载更多评论
 */

-(void)loadMoreComments{
    
    //先取消以前的所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //页码控制
    NSInteger page = self.page + 1;
    
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    YPComment * comment = [self.latestComment lastObject];
    params[@"lastcid"] = comment.ID;

    
    //从服务器获取数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //如果服务器返回的数据不是一个字典，直接返回（解决空评论导致的报错）
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_header.hidden = YES;
            self.tableView.mj_footer.hidden = YES;
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        
        //数据转模型
        NSArray * newComment = [YPComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComment addObjectsFromArray:newComment ];
        
        //页码
        self.page = page;
        
        //刷新表格
        [self.tableView reloadData];
        
        
        //控制尾部刷新控件
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComment.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        } else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}

-(void)keyboardChangeFrame:(NSNotification *)notification{
    
    //键盘显示完毕/隐藏完毕的frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.toolBarSpace.constant = YPScreenH - frame.origin.y;
    //键盘弹出或消失的时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //设置工具条的动画
    [UIView animateWithDuration:duration animations:^{
        
        //当键盘的y值发生改变时，不断的强制重绘
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    if (hotCount) return 2; //有最热评论 和 最新评论
    if (latestCount) return 1; // 只有最新评论 没有最热评论
    return 0; //两种评论都没有，可能这个帖子刚刚发送
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    
    //尾部刷新控件显示控制
   tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第0组
    return latestCount;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    NSInteger hotCount = self.hotComment.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}
/**
 *  用UIView包装headerView
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
   //从缓存池中取出headerView
    YPCommentHeaderView * headerView = [YPCommentHeaderView headerViewWithTableView:tableView];
    
   //设置文字
    NSInteger hotCount = self.hotComment.count;
    if (section == 0) {
        headerView.title = hotCount ? @"最热评论" : @"最新评论" ;
    } else {
        headerView.title = @"最新评论";
    }
    
    return headerView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //实例化cell
    YPCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:YPCommentCellID];
    
    YPComment * comment = [self commentInSection:indexPath.section][indexPath.row];
    cell.comment = comment;
    return cell;
}

/**
 *  返回第section组的所有评论
 */
-(NSArray *)commentInSection:(NSInteger)section{
    
    if (section == 0) {
        return  self.hotComment.count ? self.hotComment : self.latestComment;
    }
    return self.latestComment;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //退出第一响应者身份
    [self.view endEditing:YES];
    
    //关闭UIMenuController
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

/**
 *  当控制器销毁的时候，必须把通知删除
 */

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.save_top_cmt) {
        
        //在关闭评论界面的时候  将热门评论数据赋值回去
        self.topic.top_cmt = self.save_top_cmt;
        //重新计算cell的高度
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
   
    //控制器销毁时，取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
    
}

#pragma  mark - tableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //显示UIMenuController
    UIMenuController * menu = [UIMenuController sharedMenuController];
    
    //重复点击一个cell，不会重复显示menu,并且让menu消失
    if (menu.isMenuVisible) {
        
        [menu setMenuVisible:NO animated:YES];
        
    }else{
        
        
        //取出被选中的cell 并成为第一响应者
        YPCommentCell * cell = (YPCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        
        UIMenuItem * ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem * replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem * report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        
        //添加到UIMenuController
        menu.menuItems = @[ding,replay,report];
        //设置menu的显示区域
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        //设置menu可见
        [menu setMenuVisible:YES animated:YES];
        
    }
    
    
}

#pragma mark - UIMenuController中MenuItem函数处理

-(void)ding:(UIMenuController *)menu{
    
    NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
    YPLog(@"%zd %zd",indexpath.section,indexpath.row);
    
}

-(void)replay:(UIMenuController *)menu{
    
}


-(void)report:(UIMenuController *)menu{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
