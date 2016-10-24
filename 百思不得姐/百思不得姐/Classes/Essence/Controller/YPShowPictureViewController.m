//
//  YPShowPictureViewController.m
//  百思不得姐
//
//  Created by yupeng on 16/8/22.
//  Copyright © 2016年 yupeng. All rights reserved.
//

#import "YPShowPictureViewController.h"
#import "YPTopic.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "YPProgressView.h"


@interface YPShowPictureViewController ()

/**
 *  滚动scrollView
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  图片imageView
 */
@property (nonatomic,weak) UIImageView *imageView;
/**
 *  图片的下载进度条
 */
@property (weak, nonatomic) IBOutlet YPProgressView *pictureProgressView;

@end

@implementation YPShowPictureViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片尺寸
    CGFloat pictureW = YPScreenW;
    CGFloat pictureH =  pictureW * self.topic.height / self.topic.width ;
    if (pictureH > YPScreenH) { //如果图片的长度大于一个屏幕的长度 则需要滚动查查
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else{   //如果图片长度小于一个屏幕的长度  则让图片居中显示
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        imageView.centerY = YPScreenH * 0.5;
        
    }
    
    //进入查看大图后  应立即显示当前图片的下载进度
    [self.pictureProgressView setProgress:self.topic.pictureProgress animated:YES];
    
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //更新进度值
        [self.pictureProgressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //下载完成后 关闭进度条
        self.pictureProgressView.hidden = YES;
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  点击图片返回
 */
-(IBAction)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)save{
    
    if (self.imageView.image == nil) {
        //图片下载未完成 无法保存
        [SVProgressHUD showErrorWithStatus:@"图片还未下载完毕~"];
        return;
    }
    
    //将图片存进手机相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}



@end
