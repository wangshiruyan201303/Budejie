//
//  YPEssenceViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPEssenceViewController.h"
#import "YPRecommendTagViewController.h"
#import "YPTopicViewController.h"



@interface YPEssenceViewController () <UIScrollViewDelegate>
/**
 *  头部标签指示器
 */
@property (nonatomic,weak) UIView *indicatorView;
/**
 *  当前选中按钮
 */
@property (nonatomic,weak) UIButton *selectedButton;
/**
 *  顶部TitleView
 */
@property (nonatomic,weak) UIView *titleView;
/**
 *  内容scrollView
 */
@property (nonatomic,weak) UIScrollView *contenView;


@end

@implementation YPEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    [self setNav];
    
    //添加五个子控制器
    [self setChildVcs];
    
    //添加标签栏
    [self setTitleView];
    
    //添加中间内容ScrollView
    [self setContentView];
    
}

/**
 *  设置导航栏
 */
-(void)setNav{
    
    //设置导航栏的标题视图
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagBtnClick)];
    //设置视图的背景色
    self.view.backgroundColor = YPRGBColor(233, 233, 233);
    
}

/**
 *  添加顶部标签栏
 */
-(void)setTitleView{
    
    //整体标签
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titleView.y = 64;
    titleView.width = self.view.width;
    titleView.height = 35;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    
    //添加底部指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView = indicatorView;
    
    //添加内部子标签
    CGFloat width = titleView.width / self.childViewControllers.count;
    CGFloat height = titleView.height;
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.x = i * width;
        button.height = height;
        button.width = width;
        button.tag = i;
        UIViewController * vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        //如果是第一个按钮 则需要手动调用动画  让它自动选中
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            //让按钮内部的label根据文字来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
     [titleView addSubview:indicatorView];
   
}

/**
 *   添加中间内容scrollView
 */

-(void)setContentView{
    
    //不要自动调整子控件inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加中间内容ScrollView
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.contentSize= CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    self.contenView = contentView;
    
    //添加到当前控制器的View中
    [self.view insertSubview:contentView atIndex:0];
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}

/**
 *  添加五个子控制器
 */

-(void)setChildVcs{
    
    
    
    YPTopicViewController *all = [[YPTopicViewController  alloc] init];
    all.title = @"全部";
    all.type = YPTopicTypeAll;
    [self addChildViewController:all];
    
    YPTopicViewController *video = [[YPTopicViewController  alloc] init];
    video.title = @"视频";
    video.type = YPTopicTypeVideo;
    [self addChildViewController:video];
    
    
    YPTopicViewController *voice = [[YPTopicViewController  alloc] init];
    voice.title = @"声音";
    voice.type = YPTopicTypeVoice;
    [self addChildViewController:voice];
    
    //便于测试 先将图片控制器放在最前面
    YPTopicViewController *picture = [[YPTopicViewController  alloc] init];
    picture.title = @"图片";
    picture.type = YPTopicTypePicture;
    [self addChildViewController:picture];
    
    //便于测试 先将段子控制器放在最前面
    YPTopicViewController *word = [[YPTopicViewController  alloc] init];
    word.title = @"段子";
    word.type = YPTopicTypeWord;
    [self addChildViewController:word];
    
    
    
    
}

-(void)titleBtnClicked:(UIButton *)button{
    
    //当前按钮不可点击
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //设置内容ScrollView滚动
    CGPoint offset = self.contenView.contentOffset;
    offset.x = button.tag * self.view.width;
    [self.contenView setContentOffset:offset animated:YES];
    
}



-(void)tagBtnClick{
    
    YPRecommendTagViewController  * tag = [[YPRecommendTagViewController  alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
}


#pragma mark - scrollView Delegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出子控制器
    UIViewController * vc = self.childViewControllers[index];
    vc.view.y = 0;//设置tableView的y值为0，默认为20
    vc.view.height = scrollView.height;//默认高度为屏幕高度减去状态栏高度(比控制器view高度少20)
    vc.view.x = scrollView.contentOffset.x;
    
    //将TableViewController的view添加为scrollView的子控件
    [scrollView addSubview:vc.view];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //拖拽结束后 同样调用scrollView的滚动结束方法
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //手动调用点击按钮方法  让上边的按钮和指示器切换
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleBtnClicked:self.titleView.subviews[index]];
    
}

@end
