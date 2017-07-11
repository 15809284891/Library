//
//  RootRankViewController.m
//  图书管理
//
//  Created by shixihao on 16/8/12.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "RootRankViewController.h"
#import "LendRankViewController.h"
#import "SearchRankViewController.h"
#import "FavoriteRankViewController.h"
#import "LookRankViewController.h"
@interface RootRankViewController ()
@property (nonatomic,weak)UIScrollView *scrollerView;
@property (nonatomic,weak)UIView *titleView;
@property (nonatomic,weak)UIView *indicatorView;
@property (nonatomic,weak)UIButton *indicatorBt;
@end

@implementation RootRankViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    self.view.backgroundColor = LXViewBacColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 42)];
    titleView.backgroundColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0] ;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    [self setupTitleViews];
    [self setupChildControllers];
    [self setupContent];
    [self scrollViewDidEndDecelerating:self.scrollerView];
}
-(void)setupTitleViews{
    /*初始化指示器*/
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 40, 2)];
    indicatorView.backgroundColor = [UIColor colorWithRed:242/255.0 green:92/255.0 blue:90/255.0 alpha:1.0];
    
    CGFloat width = self.view.bounds.size.width/4.0;
    CGFloat height = 42;
    NSArray *titles = @[@"借阅",@"搜索",@"收藏",@"查看"];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width, 0, width, height);
        button.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitleColor:[UIColor colorWithRed:242/255.0 green:92/255.0 blue:90/255.0 alpha:1.0] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:button];
        if (i==0) {
            [button.titleLabel sizeToFit];
            CGRect frame = indicatorView.frame;
            frame.size.width = button.titleLabel.frame.size.width;
            indicatorView.frame = frame;
            CGPoint center = indicatorView.center;
            center.x = button.center.x;
            indicatorView.center = center;
            self.indicatorBt = button;
            self.indicatorBt.enabled = NO;
        }
    }
    [self.titleView addSubview:indicatorView];
    self.indicatorView  = indicatorView;
}
-(void)setupChildControllers{
    LendRankViewController *lendRankVc = [[LendRankViewController alloc]init];
    [self addChildViewController:lendRankVc];
    SearchRankViewController *searchRankVc = [[SearchRankViewController alloc]init];
    [self addChildViewController:searchRankVc];
    FavoriteRankViewController *favoriteRankVc = [[FavoriteRankViewController alloc]init];
    [self addChildViewController:favoriteRankVc];
    LookRankViewController *lookRankVc = [[LookRankViewController alloc]init];
    [self addChildViewController:lookRankVc];
}
-(void)setupContent{
    UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollerView.delegate = self;
    scrollerView.pagingEnabled = YES;
    scrollerView.scrollEnabled = YES;
    scrollerView.contentSize = CGSizeMake(self.childViewControllers.count*self.view.frame.size.width,0);
    [self.view insertSubview:scrollerView atIndex:0];
    self.scrollerView = scrollerView;
}


-(void)changeView:(UIButton *)sender{
    self.indicatorBt.enabled = YES;
    sender.enabled = NO;
    self.indicatorBt = sender;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.indicatorView.frame;
        frame.size.width = sender.titleLabel.frame.size.width;
        self.indicatorView.frame = frame;
        CGPoint center = self.indicatorView.center;
        center.x = sender.center.x;
        self.indicatorView.center = center;
    }];
    CGFloat offsetx = self.scrollerView.frame.size.width *sender.tag;
    [self.scrollerView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [self scrollViewDidEndScrollingAnimation:scrollView];
    int index =scrollView.contentOffset.x/scrollView.frame.size.width;
    UIButton *button = self.titleView.subviews[index];
    [self changeView:button];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
   
    int index =scrollView.contentOffset.x/scrollView.frame.size.width;
    UITableViewController *tableVc = self.childViewControllers[index];
    tableVc.tableView.frame = CGRectMake(index*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    tableVc.tableView.contentInset = UIEdgeInsetsMake(64+32+10, 0, 49, 0);
    [scrollView addSubview:tableVc.tableView];
}
@end
