//
//  YPAddTagToolBar.m
//  百思不得姐
//
//  Created by yupeng on 16/10/5.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPAddTagToolBar.h"
#import "YPAddTagViewController.h"

@interface YPAddTagToolBar()

/**
 *  顶部View父控件
 */
@property (weak, nonatomic) IBOutlet UIView *topView;

/**
 * 添加标签按钮
 */
@property (nonatomic,weak) UIButton * addTagButton;

/**
 *  保存添加的tagLabel数组
 */
@property (strong,nonatomic) NSMutableArray *tagLabels;


@end


@implementation YPAddTagToolBar


+(instancetype)toolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 *  懒加载tagLabels数组
 */
-(NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}


-(void)awakeFromNib
{
    UIButton * button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    button.size = button.currentImage.size;
    [button addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.x = YPAddTagMargin;
    [self.topView addSubview:button];
    self.addTagButton = button;
    
    //默认有两个标签
    [self createTagLabel:@[@"吐槽",@"糗事"]];
}

/**
 * 添加标签按钮被点击时，需要push出添加标签控制器
 */
-(void)addButtonClicked
{
    YPAddTagViewController * addTag = [[YPAddTagViewController alloc] init];
    
    //赋值block，用于addTag往回传tags数组
    __weak typeof(self) weakSelf = self;
    [addTag setAddTagBlock:^(NSArray * tags) {
       
        //创建标签
        [weakSelf createTagLabel:tags];
        
    }];
    
    //给addTag传递已有标签数组
    addTag.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    UIViewController * tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * nav = (UINavigationController *)tabBarController.presentedViewController;
    [nav pushViewController:addTag animated:YES];
}

/**
 *  创建标签
 */
-(void)createTagLabel:(NSArray *)tags
{
    //清空上次的数据
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    //添加标签
    for (int i = 0; i < tags.count ; i++) {
        //根据索引i取出button
        UILabel * tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        
        //应该在设置按钮的文字和字体后，调用sizeToFit
        [tagLabel sizeToFit];
        tagLabel.height = 25;
        
        tagLabel.backgroundColor = YPRGBColor(74, 139, 209);
        tagLabel.width += 2 * YPAddTagMargin;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
            }
    
         //重新布局子控件
        [self setNeedsLayout];
}

/**
 *  在layoutSubviews方法中设置子控件的size最准确
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //计算子控件的坐标
    for (int i =0; i < self.tagLabels.count; i++) {
        UILabel * tagLabel = self.tagLabels[i];
        
        //位置
        if (i == 0) {  //如果是最前面的按钮，则坐标为（0，0）
            tagLabel.x = 0;
            tagLabel.y = 0;
            
        } else{ //其他按钮
            
            UILabel * lastLabel = self.tagLabels[i-1];
            
            //左边已用距离
            CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + YPAddTagMargin;
            //右边剩余距离
            CGFloat rightWidth = self.topView.width - leftWidth;
            
            if (rightWidth >= tagLabel.width) {
                
                tagLabel.x = leftWidth;
                tagLabel.y = lastLabel.y;
                
            } else{
                
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastLabel.frame) + YPAddTagMargin;
            }
        }

    }
    
    //重新计算添加标签按钮的frame
    UILabel * lastLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + YPAddTagMargin;
    
    if (self.topView.width - leftWidth >= self.addTagButton.width ) {
        self.addTagButton.y = lastLabel.y;
        self.addTagButton.x = leftWidth;
    } else {
        
        self.addTagButton.x = 0;
        self.addTagButton.y = CGRectGetMaxY(lastLabel.frame) + YPAddTagMargin;
    }

    
    //设置toolBar自身的高度
      //先保留住上次的高度
    CGFloat lastHeigh = self.height;
    self.height = CGRectGetMaxY(self.addTagButton.frame) + 45;
    //当toolBar随着子控件的frame改变时，需要调整它的y值
    self.y -= self.height - lastHeigh;
}

@end
