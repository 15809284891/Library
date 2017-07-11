//
//  BookSortTool.h
//  图书管理
//
//  Created by snow on 2017/5/19.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookSortTool : UIView
-(BookSortTool *)creatViewWithViewTitle:(NSString *)title withSubViews:(NSArray *)subViews cols:(NSInteger)cols;
@end
