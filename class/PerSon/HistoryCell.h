//
//  HistoryCell.h
//  图书管理
//
//  Created by shixihao on 16/7/19.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class History;
@interface HistoryCell : UITableViewCell
+(HistoryCell *)addHistoryCell:(UITableView*)tableView;
@property(nonatomic,strong)History *history;
@end
