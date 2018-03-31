//
//  AppDelegate.h
//  手绘表情
//
//  Created by 李庆阳 on 15/8/28.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,sendMesgDelegate>
{
    enum WXScene _scene;
}

@property (strong, nonatomic) UIWindow *window;


@end

