//
//  AppDelegate.m
//  图书管理
//
//  Created by lixue on 16/4/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "ChangePwdViewController.h"
#import "Reachability.h"
#import "RootRankViewController.h"
#import "SSKeychain.h"
#import "LandModel.h"
#import "LXTabbarController.h"
#import "AFNetworking.h"
BOOL whetherHaveNetwork;
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //ios 8推送的形式
#ifdef __IPHONE_8_0 //这里主要是针对iOS 8.0,相应的8.1,8.2等版本各程序员可自行发挥，如果苹果以后推出更高版本还不会使用这个注册方式就不得而知了……
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }  else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
#else
    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
#endif
    [self isNetWorking];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.rootViewController = [[LXTabbarController alloc]init];
     [self.window makeKeyAndVisible];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"%@",path);
    //设置缓存
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    //改变状态栏背景颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
//
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    // 何时开始执行第一个任务
    // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(600 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    NSArray *temp = [[SSKeychain accountsForService:ServiceName]lastObject];
    if (temp.count) {
        NSString *userName = [temp valueForKey:@"acct"];
        NSString *passWord = [SSKeychain passwordForService:ServiceName account:userName];
        NSMutableString *url = [NSMutableString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/login"];
        NSDictionary *paramas = @{@"username":userName,@"password":passWord};
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        // 设置回调
        dispatch_source_set_event_handler(self.timer, ^{
            [[LXHTTPHelperClass shareInstanse]LXPOST:url parameters:paramas Value:^(id responseObject) {
                
                [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"Detail"] forKey:@"session"];
                NSLog(@"%@",responseObject);
                
            } Error:^(NSError *error) {
                
            }];
        });
        // 启动定时器
        dispatch_resume(self.timer);
    }
    
    return YES;
}
-(void)isNetWorking{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        UIViewController *vc = [self getCurrentVC];
        if (status == AFNetworkReachabilityStatusNotReachable) {
            whetherHaveNetwork = NO;
        }
        else{
            whetherHaveNetwork = YES;
        }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"isNetWork" object:nil ];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"isHaveNetWork" object:nil ];
        NSLog(@"11111111111111111111111111111111");
        
    }];
}
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken NS_AVAILABLE_IOS(3_0){
    NSLog(@"regisger success:%@",deviceToken);
    //注册成功，将deviceToken保存到应用服务器数据库中
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0){
     NSLog(@"Registfail%@",error);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_DEPRECATED_IOS(3_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications"){
    // 处理推送消息
    NSLog(@"userinfo:%@",userInfo);
    
    NSLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    
}



@end
