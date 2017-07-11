//
//  RankCell.h
//  图书管理
//
//  Created by shixihao on 16/7/19.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Rank;
@interface RankCell : UITableViewCell
@property(nonatomic,strong)Rank *rank;//记住了，一定要是strong
+(RankCell *)addRankCell:(UITableView *)tableView;
@end
