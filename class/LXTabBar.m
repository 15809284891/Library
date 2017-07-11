//
//  LXTabBar.m
//  图书管理
//
//  Created by snow on 2017/5/2.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import "LXTabBar.h"
#import "LXTabBarItem.h"

@interface LXTabBar ()
{
    LXTabBarItem *_indicatorItem;
}
@end
@implementation LXTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)addtabBarItemWithImageName:(NSString *)imageName title:(NSString *)title{
    LXTabBarItem *item = [[LXTabBarItem alloc]init];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] forState:UIControlStateSelected];
    [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    [self layoutItems];
}
-(void)clickItem:(LXTabBarItem *)bt{
    _indicatorItem.selected = NO;
    bt.selected = !bt.selected;
    _indicatorItem = bt;
    if (self.clickItemBlock) {
        self.clickItemBlock((int)bt.tag);
    }
}
-(void)layoutItems{
    int count = (int)self.subviews.count;
    CGFloat height = 44;
    CGFloat width = self.frame.size.width/count;
    for (int i = 0; i<count; i++) {
       
        LXTabBarItem *item = self.subviews[i];
        item.tag = i;
        item.frame = CGRectMake(i*width, 0, width, height);
        if (i==0) {
            item.selected = YES;
            _indicatorItem = item;
        }
    }
}
@end
