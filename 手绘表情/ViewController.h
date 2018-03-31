//
//  ViewController.h
//  手绘表情
//
//  Created by 李庆阳 on 15/8/28.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendMesgDelegate<NSObject>
/**
 *  改变消息发送位置（好友、朋友圈）的方法
 *
 *  @param scene 好友or朋友圈
 */
- (void) changeScene:(int)scene;
/**
 *  发送附带图片信息的连接
 *
 *  @param image 绘图区View
 */
- (void)sendLinkContentWithImage:(UIImage *)image;

@end
@interface ViewController : UIViewController
@property (nonatomic,assign) id<sendMesgDelegate>sendMesgDelegate;

@end

