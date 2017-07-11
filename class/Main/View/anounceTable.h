//
//  anounceTable.h
//  图书管理
//
//  Created by lixue on 16/4/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "anounceModel.h"
#import "DetailViewController.h"
#import "DetailView.h"
#import "DetailModel.h"

@interface anounceTable : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSTimer *timer;//模拟数据刷新需要的时间控制器
@property (nonatomic,assign) int time;
@property(nonatomic)anounceModel *model;
@property(nonatomic)anounceModel *modelA;
@property(nonatomic)DetailModel *dmodel;
//@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
//@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组
//

@end
