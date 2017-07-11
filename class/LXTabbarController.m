//
//  LXTabbarController.m
//  图书管理
//
//  Created by snow on 2017/5/2.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "LXTabbarController.h"
#import "LXTabBar.h"
#import "LXNavigationController.h"
#import "HomeViewController.h"
#import "personViewController.h"
#import "setViewController.h"
@interface LXTabbarController ()
{
    UIViewController *indicatorVC;
}

@end

@implementation LXTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildControllers];
    [self addTabBar];
}

-(void)addTabBar{
    LXTabBar *tabbar = [[LXTabBar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    [self.view addSubview:tabbar];
    [tabbar addtabBarItemWithImageName:@"home" title:@"主页"];
    [tabbar addtabBarItemWithImageName:@"profile" title:@"我的"];
    [tabbar addtabBarItemWithImageName:@"set" title:@"设置"];
    [self addcurrentView:0];
    tabbar.clickItemBlock = ^(int index){
        NSLog(@"%d",index);
        [self addcurrentView:index];
        if (index == 2) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"upDateSize" object:nil];
        }
    };
    _tabbar = tabbar;
}
-(void)addcurrentView:(int)index{
    UIViewController *vc = self.childViewControllers[index];
    if (vc == indicatorVC) {
        return;
    }
    [indicatorVC.view removeFromSuperview];
    vc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    indicatorVC = vc;
    [self.view addSubview:vc.view];
}
-(void)addChildControllers{
    HomeViewController *mainVc = [[HomeViewController alloc]init];
    [self addChildViewController:mainVc];
    personViewController *personVc = [[personViewController alloc]init];
    [self addChildViewController:personVc];
    setViewController *setVc = [[setViewController alloc]init];
    [self addChildViewController:setVc];
}
-(void)addChildViewController:(UIViewController *)childController{
    LXNavigationController *nav = [[LXNavigationController alloc]initWithRootViewController:childController];
    [super addChildViewController:nav];
}
@end
