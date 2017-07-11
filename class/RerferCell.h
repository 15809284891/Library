//
//  FourthCell.h
//  图书管理
//
//  Created by lixue on 16/7/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReferBooks;
@interface RerferCell : UITableViewCell
@property(nonatomic,strong)ReferBooks *referBook;
+(RerferCell *)addRerferCell:(UITableView *)tableView;
@end
