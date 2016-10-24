//
//  YPAddTagViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/10/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPAddTagViewController.h"
#import "YPTagButton.h"
#import "YPAddTagTextField.h"
#import "SVProgressHUD.h"


@interface YPAddTagViewController ()<UITextFieldDelegate>

/**
 * 包装子控件的View
 */
@property (nonatomic,weak) UIView * contentView;
/**
 * 文本输入框textField
 */
@property (nonatomic,weak) UITextField * textField;
/**
 * 添加标签的按钮
 */
@property (nonatomic,weak) UIButton * addTagBtn;
/**
 * 保存标签按钮数组
 */
@property (nonatomic,strong) NSMutableArray * tagButtons;

@end

@implementation YPAddTagViewController

/**
 * 懒加载addTagBtn
 */
-(UIButton *)addTagBtn{
    
    
    if (_addTagBtn == nil) {
        UIButton * addTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addTagBtn.width = self.contentView.width;
        addTagBtn.height = 35;
        //设置按钮label(包括imageView的图片)的文字左对齐
        addTagBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [addTagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addTagBtn.contentEdgeInsets = UIEdgeInsetsMake(0, YPAddTagMargin, 0, YPAddTagMargin);
        [addTagBtn setBackgroundColor:YPRGBColor(74, 139, 209)];
        [addTagBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [addTagBtn addTarget:self action:@selector(addTagBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addTagBtn];
        _addTagBtn = addTagBtn;
    }
    
    return _addTagBtn;
}

/**
 * 懒加载tagButtons
 */
-(NSMutableArray *)tagButtons{
    
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpContentView];
    
    [self setUpTextField];
    
    [self setUpTags];
}


-(void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"添加标签";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneBtnClicked)];
    
}

-(void)setUpContentView
{
    UIView * contentView = [[UIView alloc] init];
    contentView.x = YPAddTagMargin;
    contentView.y = 64 + YPAddTagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = YPScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    
}

-(void)setUpTags
{
    for (NSString * tag in self.tags) {
        
        self.textField.text = tag;
        
        [self addTagBtnClicked];
    }
}

-(void)setUpTextField
{
    YPAddTagTextField * textField = [[YPAddTagTextField alloc] init];
    
    //设置textField的代理，用于监听用户输入的是否为换行按钮
    textField.delegate = self;    
    
    //设置textField的block，用于监听到删除按钮点击时的回调
    __weak typeof(self) weakSelf = self;
    textField.deleteBlock = ^{
      
        if (weakSelf.textField.hasText) return ;
        
        [weakSelf tagButtonDelete:[weakSelf.tagButtons lastObject]];
    };
    
    textField.font = [UIFont systemFontOfSize:14];
    textField.width = self.contentView.width;
    [textField becomeFirstResponder];
    [textField addTarget:self action:@selector(textDidChanged) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

-(void)doneBtnClicked
{
    //回调block
     //取出所有标签的文字
    NSArray * tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    
    !self.addTagBlock ? : self.addTagBlock(tags);
    
    //控制器销毁
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addTagBtnClicked
{
    //最多添加五个标签
    if (self.tagButtons.count == 5) {
        
        [SVProgressHUD setMinimumDismissTimeInterval:2.0];
        [SVProgressHUD showErrorWithStatus:@"最多添加五个标签"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        return ;
    }
    
    YPTagButton  * button = [YPTagButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:self.textField.text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tagButtonDelete:) forControlEvents:UIControlEventTouchUpInside];
    button.height = self.textField.height;
    [self.contentView addSubview:button];
    [self.tagButtons addObject:button];
    
    //布局标签按钮
    [self setUpTagButtonFrame];
    
    //清空textField的文字 并隐藏textField
    self.textField.text = nil;
    self.addTagBtn.hidden = YES;
}

/**
 * 监听到textField文字发生了变化
 */
-(void)textDidChanged
{
    if (self.textField.hasText) { //有文字，按钮需要显示
        
        self.addTagBtn.hidden = NO;
        self.addTagBtn.y = CGRectGetMaxY(self.textField.frame) + YPAddTagMargin;
        [self.addTagBtn setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
        
        //监听输入的字符是否为逗号
        NSString * text = self.textField.text;
        NSUInteger length = text.length;
        NSString * lastLetter = [text substringFromIndex:length -1];
        if ([lastLetter isEqualToString:@","] || [lastLetter isEqualToString:@"，"]) {
            
            //首先，去掉最后一个逗号“,”或者“，”
            self.textField.text = [text substringToIndex:length -1];
            [self addTagBtnClicked];
        }
        
    }else{ //没有文字，按钮需要隐藏
        
        self.addTagBtn.hidden = YES;
    }
    
    //更新标签和文本框的frame
    [self setUpTagButtonFrame];
}

-(void)tagButtonDelete:(YPTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    //以动画的形式重新排版剩下的按钮
    [UIView animateWithDuration:0.25f animations:^{
        
        [self setUpTagButtonFrame];
    }];
}

/**
 *  布局所有按钮的frame
*/
-(void)setUpTagButtonFrame
{
    for (int i = 0; i < self.tagButtons.count; i++) {
        
        //根据索引i取出button
        YPTagButton * tagButton = self.tagButtons[i];
        
        if (i == 0) {  //如果是最前面的按钮，则坐标为（0，0）
            
            tagButton.x = 0;
            tagButton.y = 0;
        } else{ //其他按钮
            
            YPTagButton * lastTagButton = self.tagButtons[i-1];
            
            //左边已用距离
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + YPAddTagMargin;
            //右边剩余距离
            CGFloat rightWidth = self.contentView.width - leftWidth;
            
            if (rightWidth >= tagButton.width) {
                
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
            } else{
                
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + YPAddTagMargin;
            }
        }
    }
    
    //更新textField的frame
    YPTagButton * lastTagButton = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + YPAddTagMargin;
    
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagButton.y;
        self.textField.x = leftWidth;
    } else {
    
    self.textField.x = 0;
    self.textField.y = CGRectGetMaxY(lastTagButton.frame) + YPAddTagMargin;
    }
}

/**
 * 计算textField文字宽度
 */
-(CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font} ].width;
    
    return MAX(100, textW);
    
}

#pragma mark- UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //如果输入了换行，在有文字的情况下，添加标签
    if (self.textField.hasText) {
        
        [self addTagBtnClicked];
    }
    
    return YES;
}

@end
