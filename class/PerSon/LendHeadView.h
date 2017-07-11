//
//  LendHeadView.h
//  图书管理
//
//  Created by lixue on 16/7/16.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Lend;
@interface LendHeadView : UIView

@property(assign)  NSInteger haveLendCount ;
@property(assign)   NSInteger canLendCount;
@property(assign)   NSInteger lendAgainCount;
@property(assign)   NSInteger outDateCount;
-(void)initHeadView;
@end
