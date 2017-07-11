//
//  ChangePwdView.m
//  图书管理
//
//  Created by shixihao on 16/7/26.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "ChangePwdView.h"
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前
#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装
#import "Masonry.h"
#import "LXPlaceholderTextField.h"
@interface ChangePwdView()
@property(nonatomic,weak)UIView *lineView1;
@property(nonatomic,weak)UIView *lineView2;
@property(nonatomic,weak)UIView *lineView3;
@property(nonatomic,weak)UIView *bacView;
@end
@implementation ChangePwdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *bacView = [[UIView alloc]init];
        bacView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        bacView.layer.cornerRadius = 5.0;
        bacView.layer.masksToBounds = YES;
        [self addSubview:bacView];
        self.bacView = bacView;
        self.userNameField = [[LXPlaceholderTextField alloc]init];
        self.userNameField.placeholder = @"账户";
        self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.userNameField.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.userNameField];
        UIView *lineView1 = [[UIView alloc]init];
        lineView1.backgroundColor = [UIColor grayColor];
        [self.bacView addSubview:lineView1];
        self.lineView1 = lineView1;
        
        self.oldPwdField = [[LXPlaceholderTextField alloc]init];
        self.oldPwdField.placeholder = @"旧密码";
        self.oldPwdField.secureTextEntry = YES;
        self.oldPwdField.clearsOnBeginEditing = YES;
        self.oldPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.oldPwdField.adjustsFontSizeToFitWidth = YES;
        [self.bacView addSubview:self.oldPwdField];
        
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.backgroundColor = [UIColor grayColor];
        [self.bacView addSubview:lineView2];
        self.lineView2 = lineView2;
        
        self.changedPwdField = [[LXPlaceholderTextField alloc]init];
        self.changedPwdField.placeholder = @"新密码";
        self.changedPwdField.secureTextEntry = YES;
        self.changedPwdField.clearsOnBeginEditing = YES;
        self.changedPwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.changedPwdField.adjustsFontSizeToFitWidth = YES;
        [self.bacView addSubview:self.changedPwdField];
        
        UIView *lineView3 = [[UIView alloc]init];
        lineView3.backgroundColor = [UIColor grayColor];
        [self.bacView addSubview:lineView3];
        self.lineView3 = lineView3;
        
        self.surePwdField = [[LXPlaceholderTextField alloc]init];
        self.surePwdField.placeholder = @"确认新密码";
        self.surePwdField.secureTextEntry = YES;
        self.surePwdField.clearsOnBeginEditing = YES;
        self.surePwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.surePwdField.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.surePwdField];

        
        
        self.changeBT = [UIButton buttonWithType:UIButtonTypeCustom];
        self.changeBT.backgroundColor = [UIColor colorWithRed:245/255.0 green:91/255.0 blue:86/255.0 alpha:1.0];
        self.changeBT.layer.cornerRadius = 5;
        [self.changeBT setTitle:@"修改" forState:UIControlStateNormal];
        [self addSubview:self.changeBT];

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.bacView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(30);
        make.leading.equalTo(40);
        make.right.equalTo(self.right).offset(-40);
        make.height.equalTo(self.bacView.width).multipliedBy(0.8);
    }];

    [self.userNameField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bacView.left).offset(8);
        make.right.equalTo(self.bacView.right).offset(-8);
        make.top.equalTo(self.bacView.top);
        make.height.equalTo(self.userNameField.width).multipliedBy(0.2).offset(-0.5);
    }];
    
    [self.oldPwdField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameField.left);
        make.right.equalTo(self.userNameField.right);
        make.top.equalTo(self.userNameField.bottom).offset(1);
        make.height.equalTo(self.userNameField.height);
    }];
    [self.lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bacView.leading);
        make.right.equalTo(self.bacView.right);
        make.top.equalTo(self.userNameField.bottom);
        make.bottom.equalTo(self.oldPwdField.top);
    }];
    
    [self.changedPwdField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameField.left);
        make.right.equalTo(self.userNameField.right);
        make.top.equalTo(self.oldPwdField.bottom).offset(1);
        make.height.equalTo(self.userNameField.height);
    }];
    
    [self.lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView1.leading);
        make.right.equalTo(self.lineView1.right);
        make.top.equalTo(self.oldPwdField.bottom);
        make.bottom.equalTo(self.changedPwdField.top);
    }];

    [self.surePwdField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameField.left);
        make.right.equalTo(self.userNameField.right);
        make.top.equalTo(self.changedPwdField.bottom).offset(1);
        make.height.equalTo(self.userNameField.height);
    }];
    
    [self.lineView3 makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView1.leading);
        make.right.equalTo(self.lineView1.right);
        make.top.equalTo(self.changedPwdField.bottom);
        make.bottom.equalTo(self.surePwdField.top);
    }];
    
    [self.changeBT makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.changedPwdField.left);
        make.right.equalTo(self.changedPwdField.right);
        make.top.equalTo(self.surePwdField.bottom).offset(30);
        make.height.equalTo(40);
    }];
}


@end
