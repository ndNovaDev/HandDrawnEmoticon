//
//  AppDelegate.m
//  手绘表情
//
//  Created by 李庆阳 on 15/8/28.
//  Copyright (c) 2015年 NovaDev. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    加载入口
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *VC = [[ViewController alloc] init];
    VC.sendMesgDelegate =self;
    window.rootViewController = VC;
    [window makeKeyAndVisible];
    self.window = window;
    //    设置APPID
    [WXApi registerApp:@"wxc9722712a54a25e9"];
    return YES;
}
//母鸡（微信提供的）
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
//母鸡（微信提供的）
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    
    return  isSuc;
}
//设置消息发送方向（联系人or朋友圈）
-(void) changeScene:(int)scene
{
    _scene = scene;
}
//向微信发送消息
-(void)sendLinkContentWithImage:(UIImage *)image{
    WXMediaMessage *message = [WXMediaMessage message];
    WXImageObject *ima = [WXImageObject object];
    ima.imageData = UIImagePNGRepresentation(image);
    message.mediaObject = ima;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
