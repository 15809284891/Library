//
//  Problem.m
//  图书管理
//
//  Created by shixihao on 16/7/30.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "Problem.h"

@implementation Problem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.problemArray = [NSMutableArray array];
    }
    return self;
}
-(void)loadData{
    Problem *p1 = [[Problem  alloc]init];
    p1.title = @"1.登录时的学号和密码指的是？";
    p1.text = @" 学号即各位同学在登录本校图书馆系统时所用的学号，密码即登录本校图书馆系统时所用的密码。";
    [self.problemArray addObject:p1];
    Problem *p2 = [[Problem  alloc]init];
    p2.title = @"2.学号和密码安全吗？";
    p2.text = @"  为了提高查询速度和环节服务器压力，我们只对一些图书信息进行了缓存，但不针对任何用户信息，请放心使用";
    [self.problemArray addObject:p2];
}
@end
