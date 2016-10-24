//
//  YPPostWordViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/10/4.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPPostWordViewController.h"
#import "YPPlaceholderTextView.h"
#import "YPAddTagToolBar.h"

@interface YPPostWordViewController ()<UITextViewDelegate>

@property (nonatomic,weak) YPPlaceholderTextView * placeholder;

@property (nonatomic,weak) YPAddTagToolBar * toolBar;

@end

@implementation YPPostWordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpPlaceholder];
    
    [self setUpToolBar];
}

-(void)setUpNav{
    
    self.view.backgroundColor = YPGlobalColor;
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    //设置右边按钮默认不能点
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [UIBarButtonItem appearance];
    
    //当给navigationItem通过appearance设置属性时，要在ViewDidAppear方法中才会显示出效果
    //为了能够立即显示出效果 可以强制重绘
    [self.navigationController.navigationBar layoutIfNeeded];
}


-(void)setUpPlaceholder{
    
    YPPlaceholderTextView * placeholder = [[YPPlaceholderTextView alloc] init];
    placeholder.frame = self.view.bounds;
    placeholder.delegate = self;
    placeholder.placeholder = @"这里添加文字，请勿发布色情、政治等违反国家法律的内容，违者封号处理。";
    [self.view addSubview:placeholder];
    self.placeholder = placeholder;
    
}


-(void)setUpToolBar
{
    YPAddTagToolBar * toolBar = [YPAddTagToolBar toolBar];
    toolBar.width = self.view.width;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.toolBar = toolBar;
}

/**
  * 在viewDidAppear方法中设置placeholder为第一响应者，可以保证“发表文字控制器”在被modal出来
  * 或者由“添加标签控制器”返回时，都可以弹出键盘
 */
-(void)viewDidAppear:(BOOL)animated
{
    [self.placeholder becomeFirstResponder];
}


-(void)cancel{
    
    //控制器销毁
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)post{
    
}


#pragma  mark - UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}


#pragma  mark - UIScrollDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 * 监听到键盘的弹出与隐藏时，对toolbar做处理
 */
-(void)keyboardFrameChanged:(NSNotification *)notify
{
    //键盘最终的frame
    CGRect finalFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //键盘变化的动画时间
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    //让toolBar执行动画
    
    [UIView animateWithDuration:duration animations:^{
       
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, finalFrame.origin.y - YPScreenH);
        
    }];
    
}



@end
