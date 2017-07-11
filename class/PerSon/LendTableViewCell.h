//
//  LendTableViewCell.h
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Lend;
typedef void (^clickBTBlock) (UIButton *bt, UILabel *dateLb);
@protocol  LendTableViewCellDelegate <NSObject>

-(void)lendAgain:(UIButton *)bt;

@end
@interface LendTableViewCell : UITableViewCell
+(LendTableViewCell *)addLendTableViewCell:(UITableView*)tableView;
@property(nonatomic)Lend *lend;
@property (nonatomic,weak)id<LendTableViewCellDelegate>delegate;
@property (nonatomic,copy)clickBTBlock block;
@property(nonatomic)UILabel *DateLb;
@property(nonatomic)UIButton *StateBt;
@end

