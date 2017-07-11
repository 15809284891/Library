
//
//  MainRootViewController.m
//  图书管理
//
//  Created by shixihao on 16/8/13.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewController.h"
#import "AnounceViewController.h"
#import "SearchViewController.h"
#import "UIBarButtonItem+Navigation.h"
@interface HomeViewController ()
@property (nonatomic,weak)UIView *titleView;
@property (nonatomic,weak)UIButton *indicatorBt;
@property (nonatomic,weak)UIScrollView *scroller;
@end

@implementation HomeViewController

-(id)init{
    self = [super init];
    if (self) {
        self.title = @"西邮图书馆";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = LXViewBacColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemwithImage:@"search" target:self action:@selector(searchAction)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = LXbarTintColor;
    [self setupChildControllers];
    [self setupTitleView];
    [self setupContentView];
    [self scrollViewDidEndScrollingAnimation:self.scroller];
}
-(void)searchAction{
    SearchViewController *searchVc =[[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];
    self.navigationController.hidesBottomBarWhenPushed = YES;
}
-(void)setupTitleView{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    CGFloat width = self.view.frame.size.width/self.childViewControllers.count;
    CGFloat height = 40;
    NSArray *titles = @[@"公告信息",@"新闻信息"];
    for (int i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"normal_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"disabled_button"] forState:UIControlStateDisabled];
        button.frame = CGRectMake(i*width, 0, width, height);
        [button addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:button];
        if (i == 0) {
            self.indicatorBt = button;
            self.indicatorBt.enabled = NO;
        }
    }
}
-(void)setupContentView{
    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+40, Viewwidth, Viewheight - NavigationBarHeight-StatusHeight-40-44)];
    scroller.contentSize = CGSizeMake(scroller.frame.size.width*self.childViewControllers.count, 0);
    scroller.delegate = self;
    scroller.backgroundColor = LXViewBacColor;
    scroller.pagingEnabled = YES;
    scroller.showsHorizontalScrollIndicator = NO;
    scroller.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroller];
    self.scroller = scroller;
}

-(void)setupChildControllers{
    AnounceViewController *announceVc =[[AnounceViewController alloc]init];
    [self addChildViewController:announceVc];
    NewsViewController *newsVc = [[NewsViewController alloc]init];
    [self addChildViewController:newsVc];
}
-(void)changeView:(UIButton *)sender{
    self.indicatorBt.enabled = YES;
    sender.enabled = NO;
    self.indicatorBt = sender;
    [self.scroller setContentOffset:CGPointMake(sender.tag*self.scroller.frame.size.width, 0) animated:YES];
}
#pragma mark - scrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    [self.scroller addSubview:vc.view];
    
   }
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    UIButton *button = self.titleView.subviews[index];
    [self changeView:button];

}
@end
