//
//  YPMeFooterView.m
//  百思不得姐
//
//  Created by yupeng on 16/10/4.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPMeFooterView.h"
#import "YPSquare.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YPSquareButton.h"
#import "YPWebViewController.h"

@implementation YPMeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //参数
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSArray * squares = [YPSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            //根据squares数组创建对应个数方块
            
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
    return self;
}


/**
 * 创建方块
 */
-(void)createSquares:(NSArray *)squares{
    
    int maxCols = 4;
    CGFloat buttonW = YPScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count ; i++) {
        
        YPSquareButton * button = [YPSquareButton buttonWithType:UIButtonTypeCustom];
        
        //传递模型
        button.square = squares[i];
        
        //添加监听
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //计算button的frame
        int col = i % maxCols;
        int row = i / maxCols;
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
      [self addSubview:button];
        
    }
    
    //计算footer的高度
    NSUInteger rows = (squares.count + maxCols - 1) / maxCols;
    self.height = rows * buttonH;
    self.scrollHeigh = self.height;
    
    //由于square的数据是从网络返回的，但是footer的高度是在视图加载完毕设置的，故要强制重绘。
    [self setNeedsDisplay];
    
}

-(void)buttonClicked:(YPSquareButton *)button{
    
    if (![button.square.url hasPrefix:@"http://"]) {
        return;
    }
    
    YPWebViewController * webViewVC = [[YPWebViewController alloc] init];
    webViewVC.url = button.square.url;
    webViewVC.title = button.square.name;
    
    //push 出webViewVC
    UITabBarController * tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * navVC = (UINavigationController *)tabBarVC.selectedViewController;
    [navVC pushViewController:webViewVC animated:YES];
    
}


//
//- (void)drawRect:(CGRect)rect {
//    
//    //UIView 无image或者backGroundImage属性，所以可以通过drawRect方法设置UIView的背景图片
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}


@end
