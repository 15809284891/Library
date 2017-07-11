//
//  FirstCell.h
//  图书管理
//
//  Created by lixue on 16/7/17.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookDetail;
@interface BasicInfoCell :UITableViewCell
+(BasicInfoCell *)addBasicInfoCell:(UITableView *)tableView;
@property(nonatomic,strong)BookDetail*bookDetail;
@end
