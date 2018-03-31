//
//  ViewController.m
//  SuperDrawer
//
//  Created by 李庆阳 on 15/8/20.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "ViewController.h"
#import "drawView.h"
#import "showView.h"
#import "MBProgressHUD+CZ.h"
#import "MenuPopover.h"
#import "guideTableViewController.h"
#import "WXApi.h"
#define margin 10
#define shareViewWidth 40
@interface ViewController ()<menuPopoerDelegate>
//画笔颜色预览区
@property (nonatomic,strong)UIView *colorView;
//绘图区
@property (nonatomic,strong)drawView *dView;
//画笔及背景预览区
@property (nonatomic,strong)showView *sView;
//画笔尺寸滑块
@property (nonatomic,strong)UISlider *slider;
//分享按钮弹出View
@property (nonatomic, strong)MenuPopover *menuView;
//警告View
@property (nonatomic, strong) UIAlertView *alertView;
@end
@implementation ViewController
#pragma mark - lazy
//警告View
- (UIAlertView *)alertView{
    
    if (!_alertView) {
        
        self.alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"亲，您没有安装微信哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
    }
    
    return _alertView;
}
//分享按钮弹出View
- (MenuPopover *)menuView {
    
    if (!_menuView) {
        _menuView = [[MenuPopover alloc] initWithMenuFrame:CGRectMake(self.view.frame.size.width - 95.5 - 10, self.dView.frame.origin.y, 95.5, 180)];
        _menuView.delegate = self;
    }
    return _menuView;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat line = 0;
    CGFloat x = 0;
    if (self.view.frame.size.height / self.view.frame.size.width > 1.5) {
        line = self.view.frame.size.height * 0.02;
        x = 1.18;
    }else{
        line = self.view.frame.size.height * 0.01;
        x = 1;
    }
    //    主View背景颜色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    //    清除按钮
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    clearBtn.frame = CGRectMake(margin, 20 + line, 30 * x, 15 * x);
    [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    //    撤销按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(CGRectGetMaxX(clearBtn.frame) + 2 * margin, clearBtn.frame.origin.y, 30 * x, 15 * x);
    [backBtn setTitle:@"撤销" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //    分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    shareBtn.frame = CGRectMake(self.view.frame.size.width - 40 - margin, clearBtn.frame.origin.y, 30 * x, 15 * x);
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    //    画笔恢复默认按钮
    UIButton *defaulBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    defaulBtn.frame = CGRectMake(0, 0, 60 * x, 15 * x);
    defaulBtn.center = CGPointMake(shareBtn.center.x - backBtn.center.x, shareBtn.center.y);
    [defaulBtn setTitle:@"恢复画笔" forState:UIControlStateNormal];
    [defaulBtn addTarget:self action:@selector(setDefaul) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:defaulBtn];
    //    绘图区
    CGFloat dvSize = self.view.frame.size.width - 2 * margin;
    drawView *dView = [[drawView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(backBtn.frame) + line, dvSize, dvSize)];
    dView.backgroundColor = [UIColor whiteColor];
    self.dView = dView;
    dView.width = 4;
    dView.color = [UIColor blackColor];
    [self.view addSubview:dView];
    
    //    画笔颜色预览区
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(dView.frame) + line, self.view.frame.size.width - 2 * margin, self.view.frame.size.height * 0.015)];
    colorView.backgroundColor = [UIColor blackColor];
    self.colorView = colorView;
    [self.view addSubview:colorView];
    //    画笔颜色选择按钮
    CGFloat colorBtnMargin = (self.view.frame.size.width - 2 * margin - 8 * self.view.frame.size.width / 9) / 7;
    NSArray *colorArray = @[[UIColor blackColor],[UIColor whiteColor],[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor]];
    for (int i = 0; i < 8; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(margin + i * (colorBtnMargin + self.view.frame.size.width / 9), CGRectGetMaxY(colorView.frame) + line, self.view.frame.size.width / 9, self.view.frame.size.width / 18)];
        btn.backgroundColor = colorArray[i];
        [btn addTarget:self action:@selector(colorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    //    下方空隙
    CGFloat colorBtnMaxY = CGRectGetMaxY(colorView.frame) +  line + self.view.frame.size.width / 18;
    CGFloat els = self.view.frame.size.height - colorBtnMaxY;
    CGFloat showSize = els * 0.8;
    CGFloat showMargin = (els - showSize) * 0.1;
    //    画笔效果预览区
    showView *sView = [[showView alloc] initWithFrame:CGRectMake(margin, colorBtnMaxY + showMargin + line, showSize / x, showSize / x)];
    sView.backgroundColor = [UIColor whiteColor];
    sView.width = 4;
    self.sView = sView;
    [self.view addSubview:sView];
    //    画笔尺寸滑块
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sView.frame) + margin, CGRectGetMinY(sView.frame) + sView.frame.size.height * 0.6 * x, self.view.frame.size.width - 2 * margin - sView.frame.size.width, 30)];
    self.slider = slider;
    slider.minimumValue = 4;
    slider.maximumValue = 60;
    [slider addTarget:self action:@selector(widthChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    //    绘图背景颜色按钮
    CGFloat backColorBtnSize = sView.frame.size.width * 0.4 * x;
    CGFloat backColorBtnMargin = (self.view.frame.size.width - 2 * margin - sView.frame.size.width - 3 * backColorBtnSize) * 0.25;
    NSArray *backColors = @[[UIColor whiteColor],[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1],[UIColor blackColor]];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(sView.frame) + margin + backColorBtnMargin + i *(backColorBtnSize + backColorBtnMargin) , sView.frame.origin.y + line, backColorBtnSize, backColorBtnSize)];
        btn.backgroundColor = backColors[i];
        [btn addTarget:self action:@selector(changeBackgroundClolor:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
}
#pragma mark - 分享
//分享按钮点击
-(void)shareBtnClick{
    [self.menuView show];
}
//分享分按钮点击代理事件
-(void)finishWithButton:(UIButton *)btn{
    if (btn.tag == 0) {
        [self saveClick];
    }else if (btn.tag == 1){
        [self sendLinkContent:1];
    }else if (btn.tag == 2){
        [self sendLinkContent:2];
    }else if (btn.tag == 3){
        [self guideShow];
    }
}
//取得已绘制图片
-(UIImage *)getShareImage{
    UIGraphicsBeginImageContext(self.dView.frame.size);
    [self.dView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}
//保存图片到相册
-(void)saveClick{
    UIImage *image = [self getShareImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
//向微信发送请求
- (void)sendLinkContent:(int)BtnTag{
    BOOL isinstall = [WXApi isWXAppInstalled];
    if (isinstall) {
        if (BtnTag == 1) {
            [self.sendMesgDelegate changeScene: WXSceneSession];
        }else{
            [self.sendMesgDelegate changeScene:WXSceneTimeline];
        }
        if (self.sendMesgDelegate) {
            [self.sendMesgDelegate sendLinkContentWithImage:[self getShareImage]];
            
        }
    }else{
        [self.alertView show];
    }
}
//帮助界面弹出
-(void)guideShow{
    guideTableViewController *gVC = [[guideTableViewController alloc] init];
    UINavigationController *nVC = [[UINavigationController alloc] initWithRootViewController:gVC];
    [self presentViewController:nVC animated:YES completion:nil];
}
#pragma mark - 清除、撤销、恢复默认、保存
//清除
-(void)clearClick{
    [self.dView clear];
}
//撤销
-(void)backClick{
    [self.dView back];
}
//恢复默认
-(void)setDefaul{
    self.slider.value = self.slider.minimumValue;
    [self widthChange:self.slider];
    if (self.dView.backgroundColor == [UIColor blackColor]) {
        self.colorView.backgroundColor = [UIColor whiteColor];
        [self setDrawColor];
    }else{
        self.colorView.backgroundColor = [UIColor blackColor];
        [self setDrawColor];
    }
}
#pragma mark - 画笔颜色选取
-(void)colorBtnClick:(UIButton *)btn{
    self.colorView.backgroundColor = btn.backgroundColor;
    [self setDrawColor];
}
#pragma mark - 画笔宽度调节
-(void)widthChange:(UISlider *)slider{
    self.sView.width = slider.value;
    self.dView.width = slider.value;
}
#pragma mark - 系统提供的方法（使用HUD提示保存成功、失败）
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [MBProgressHUD showError:@"失败"];
    }else{
        [MBProgressHUD showSuccess:@"成功"];
    }
}
#pragma mark - 改变绘图背景颜色
-(void)changeBackgroundClolor:(UIButton *)btn{
    self.dView.backgroundColor = btn.backgroundColor;
    self.sView.backgroundColor = btn.backgroundColor;
    if (btn.backgroundColor == [UIColor blackColor]) {
        self.colorView.backgroundColor = [UIColor whiteColor];
        [self setDrawColor];
    }else if (btn.backgroundColor == [UIColor whiteColor]){
        self.colorView.backgroundColor = [UIColor blackColor];
        [self setDrawColor];
    }else{
        self.colorView.backgroundColor = [UIColor blackColor];
        [self setDrawColor];
    }
}
#pragma mark - 设置画笔颜色到绘图和预览View
-(void)setDrawColor{
    self.sView.color = self.colorView.backgroundColor;
    self.dView.color = self.colorView.backgroundColor;
}
@end
