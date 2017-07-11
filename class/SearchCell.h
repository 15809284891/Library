//
//  SearchCell.h
//  图书管理
//
//  Created by shixihao on 16/8/14.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookData;
@interface SearchCell : UITableViewCell
@property(nonatomic,strong)BookData *bookData;
+(SearchCell*)addSearchCell:(UITableView*)tableVCiew;
@end
