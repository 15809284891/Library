//
//  ChangePwdView.h
//  图书管理
//
//  Created by shixihao on 16/7/26.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXPlaceholderTextField;
@interface ChangePwdView : UIView
@property (nonatomic) UITextField *userNameField;
@property (nonatomic) UITextField *oldPwdField;
@property (nonatomic) UITextField *changedPwdField;
@property (nonatomic) UITextField *surePwdField;
@property (nonatomic)UIButton *changeBT;
@end
