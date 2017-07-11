//
//  BasicIntoHead.h
//  图书管理
//
//  Created by shixihao on 16/7/22.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BasicIntoHeadDelegate <NSObject>

-(void)addFavirate:(UIButton *)bt;

@end
@interface BasicIntoHead : UIView
@property(nonatomic,weak)UIButton  *favirateBt;
@property(nonatomic,weak)id<BasicIntoHeadDelegate>delegate;
@end
