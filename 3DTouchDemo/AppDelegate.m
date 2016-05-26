//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by changpengkai on 16/5/25.
//  Copyright © 2016年 changpengkai. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    UIAlertView *alert;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [self configHomeScreenQuickActionItem];
    return YES;
}

// 点击Home screen quick action会回调此方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler {
    
    NSString *actionType = shortcutItem.type;
    if ([actionType isEqualToString:@"免打扰"]) {
        // 处理对应逻辑
        NSLog(@"免打扰处理");
    }else if ([actionType isEqualToString:@"二维码"]) {
        NSLog(@"二维码");

    }else if ([actionType isEqualToString:@"录制视频"]) {
        NSLog(@"录制视频");
    }else if ([actionType isEqualToString:@"新建聊天"]) {
        NSLog(@"新建聊天");
    }
    
    // 暂时没发现此 block 回调的主要用途
    completionHandler(YES);
    
}

- (void)configHomeScreenQuickActionItem {
    
    // 3DTouch需要ios9的支持
    if (!([UIDevice currentDevice].systemVersion.floatValue >= 9.0)) {
        return ;
    }
    
    // 图片要求35*35，单一颜色，系统会强制改变图片的风格，使得图片风格和系统自定义的一样（🐂）
    UIApplicationShortcutIcon *qrIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"qrCode"];
    // type：区分 action 用的
    UIApplicationShortcutItem *qrCodeItem = [[UIApplicationShortcutItem alloc]initWithType:@"二维码" localizedTitle:@"我的二维码" localizedSubtitle:@"子标题2" icon:qrIcon userInfo:nil];
    
    UIApplicationShortcutIcon *recordVideoIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"video"];
    UIApplicationShortcutItem *recordVideoItem = [[UIApplicationShortcutItem alloc]initWithType:@"录制视频" localizedTitle:@"录制😊视频" localizedSubtitle:@"子标题3" icon:recordVideoIcon userInfo:nil];
    
    UIApplicationShortcutIcon *chatIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"chat"];
    UIApplicationShortcutItem *chatItem = [[UIApplicationShortcutItem alloc]initWithType:@"新建聊天" localizedTitle:@"❤️建聊天" localizedSubtitle:@"子标题4" icon:chatIcon userInfo:nil];

    
    // 系统会先动态加代码里的，再加 plist 文件里的
    UIApplication *app = [UIApplication sharedApplication];
    // 数量最大为4个
    app.shortcutItems = @[qrCodeItem,recordVideoItem,chatItem];
    
    // UIMutableApplicationShortcutItem  为动态的，可以在 app 期间内进行更改
    
}

@end
