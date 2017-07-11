//
//  AppDelegate.h
//  图书管理
//
//  Created by lixue on 16/4/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)dispatch_source_t timer;
@end

