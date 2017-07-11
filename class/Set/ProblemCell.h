//
//  ProblemCell.h
//  图书管理
//
//  Created by shixihao on 16/7/30.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Problem;
@interface ProblemCell : UITableViewCell
@property(nonatomic,strong)NSString *textStr;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)Problem *problem;
+(ProblemCell *)addProblemCell:(UITableView *)tableView;
@end
