//
//  MenuPopover.m
//  Menu
//
//  Created by fcx on 15/7/31.
//  Copyright (c) 2015年 fcx. All rights reserved.
//

#import "MenuPopover.h"
#import "shareButton.h"
#import "howToButton.h"
@implementation MenuPopover
{
    UIImageView *menuImageView;
}
- (instancetype)initWithMenuFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        //        背景，偷的
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
        menuImageView = [[UIImageView alloc] initWithFrame:frame];
        menuImageView.userInteractionEnabled = YES;
        menuImageView.layer.anchorPoint = CGPointMake(1, 0);
        menuImageView.frame = frame;
        [self addSubview:menuImageView];
        //        保存到本地相册Btn
        shareButton *phptoBtn = [shareButton buttonWithType:UIButtonTypeCustom];
        phptoBtn.frame = CGRectMake(0, 0, 120, 30);
        phptoBtn.tag = 0;
        [phptoBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        [phptoBtn setTitle:@"系统相册" forState:UIControlStateNormal];
        phptoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [phptoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [phptoBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuImageView addSubview:phptoBtn];
        //        微信好友分享按钮
        shareButton *weChatFriendBtn = [shareButton buttonWithType:UIButtonTypeCustom];
        weChatFriendBtn.frame = CGRectMake(0, 35, 120, 30);
        weChatFriendBtn.tag = 1;
        [weChatFriendBtn setImage:[UIImage imageNamed:@"weChat"] forState:UIControlStateNormal];
        [weChatFriendBtn setTitle:@"微信好友" forState:UIControlStateNormal];
        weChatFriendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [weChatFriendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [weChatFriendBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuImageView addSubview:weChatFriendBtn];
        //        朋友圈分享按钮
        shareButton *friendsBtn = [shareButton buttonWithType:UIButtonTypeCustom];
        friendsBtn.frame = CGRectMake(0, 70, 120, 30);
        friendsBtn.tag = 2;
        [friendsBtn setImage:[UIImage imageNamed:@"pengyouquan"] forState:UIControlStateNormal];
        [friendsBtn setTitle:@"朋友圈" forState:UIControlStateNormal];
        friendsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [friendsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [friendsBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuImageView addSubview:friendsBtn];
        //        guide按钮
        howToButton *howToBtn = [howToButton buttonWithType:UIButtonTypeCustom];
        howToBtn.frame = CGRectMake(0, 105, 100, 30);
        howToBtn.tag = 3;
        [howToBtn setTitle:@"添加到微信自定义表情" forState:UIControlStateNormal];
        howToBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [howToBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [howToBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuImageView addSubview:howToBtn];
        //        母鸡
        UITapGestureRecognizer *tapGesgure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGesgure];
        
    }
    return self;
}

//按钮点击事件，通过代理将数据传回主Controller
- (void)buttonAction:(UIButton *)button {
    [self dismiss];
    [self.delegate finishWithButton:button];
}
//母鸡
- (void)show {
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    __weak UIImageView *weakImageView = menuImageView;
    
    menuImageView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakImageView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
//母鸡
- (void)dismiss {
    
    __weak __typeof(self)weakSelf = self;
    __weak UIImageView *weakImageView = menuImageView;
    
    [UIView animateWithDuration:.15 animations:^{
        
        weakImageView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
    
}



@end
