//
//  LXTabBar.h
//  图书管理
//
//  Created by snow on 2017/5/2.
//  Copyright © 2017年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXTabBar : UIView
@property(nonatomic,copy)void (^clickItemBlock)(int index);
-(void)addtabBarItemWithImageName:(NSString *)imageName title:(NSString *)title;
@end
