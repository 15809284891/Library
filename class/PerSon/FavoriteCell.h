//
//  FavoriteCell.h
//  图书管理
//
//  Created by shixihao on 16/7/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Favorite;
@interface FavoriteCell : UITableViewCell
@property(nonatomic,strong)Favorite *favorite;
@property(nonatomic)UIView *checkView;
@property(nonatomic)UIView *deleteView;
@property(nonatomic)UIButton *favoriteBt;
@property(assign,nonatomic,getter=isCheck)BOOL checked;
@property(assign,nonatomic,getter=isDelete)BOOL deleted;
+(FavoriteCell *)addFavoriteCell:(UITableView *)tableView;

@end
