//
//  CirculateInfoView.h
//  图书管理
//
//  Created by shixihao on 16/7/21.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CirculationInfo;
@interface CirculateInfoView : UITableViewCell
@property(nonatomic,strong)CirculationInfo *circulationInfo;
//-(void)initContent:(CirculationInfo *)circulationInfo;
+(CirculateInfoView *)addCirculateCell:(UITableView *)tableView;
@end
