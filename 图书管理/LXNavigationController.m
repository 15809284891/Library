//
//  LXNavigationController.m
//  图书管理
//
//  Created by shixihao on 16/8/3.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "LXNavigationController.h"
#import "LXTabbarController.h"
#import "LXTabBar.h"
@interface LXNavigationController ()

@end

@implementation LXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = LXbarTintColor;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19.0];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:dic];

}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    if (self.childViewControllers.count>0) {
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
        viewController.hidesBottomBarWhenPushed = YES;

    }
     [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated; {
    [SVProgressHUD dismiss];
    [self setHidesBottomBarWhenPushed:NO];
    return [super popViewControllerAnimated:YES];
}
-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed{
    UIWindow *window = [UIApplication  sharedApplication].keyWindow;
    LXTabbarController *tabbarVc = (LXTabbarController *)window.rootViewController;
    for (int i = 0; i<tabbarVc.childViewControllers.count; i++) {
        UIViewController *vc = tabbarVc.childViewControllers[i];
        if(hidesBottomBarWhenPushed)
        vc.view.frame = CGRectMake(0, 0, screenW, screenH);
        else
        vc.view.frame = CGRectMake(0, 0, screenW, screenH-44);
    }
    tabbarVc.tabbar.hidden = hidesBottomBarWhenPushed;
}
@end
