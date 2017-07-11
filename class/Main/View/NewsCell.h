//
//  anounceCell.h
//  图书管理
//
//  Created by lixue on 16/4/18.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;

@interface NewsCell : UITableViewCell
+(NewsCell *)addNewsCellWithTableView:(UITableView *)tableview;
@property(nonatomic,strong)News *model;

@end
