//
//  RankViewController.h
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankViewController :UITableViewController
@property(nonatomic)NSMutableArray *rankArray;
-(NSString *)type;
@end
