//
//  LendTableViewCell.m
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前
#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装

#import "LendTableViewCell.h"
#import "Lend.h"
#import "Masonry.h"
@interface LendTableViewCell()
@property(nonatomic)UILabel *TitleLb;
@property(nonatomic)UILabel *DepartmentLb;

@property(nonatomic)UILabel *DepartmentLbTip;
@property(nonatomic)UILabel *DateLbTip;
@property(nonatomic)UILabel *StateLbTip;
@end
@implementation LendTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UILabel *titleLable = [[UILabel alloc]init];
        [self.contentView addSubview:titleLable];
        titleLable.font = [UIFont systemFontOfSize:18.0];
        self.TitleLb = titleLable;
        
        self.DepartmentLbTip = [[UILabel alloc]init];
        self.DepartmentLbTip.text = @"分馆:";
        self.DepartmentLbTip.font = [UIFont systemFontOfSize:14.0];
        self.DepartmentLbTip.textColor = [UIColor darkGrayColor];
        [self .contentView addSubview:self.DepartmentLbTip];
        
        UILabel *DepartmentLb = [[UILabel   alloc]init];
        [self.contentView addSubview:DepartmentLb];
        DepartmentLb.font = [UIFont systemFontOfSize:14.0];
        DepartmentLb.textColor = [UIColor darkGrayColor];
        self.DepartmentLb = DepartmentLb;
        
        self.DateLbTip = [[UILabel alloc]init];
        self.DateLbTip.font = [UIFont systemFontOfSize:14.0];
        self.DateLbTip.textColor = [UIColor darkGrayColor];
        self.DateLbTip.text = @"到期时间:";
        [self .contentView addSubview:self.DateLbTip];
        
        UILabel *DateLb = [[UILabel alloc]init];
        DateLb.font = [UIFont systemFontOfSize:14.0];
        self.DateLb.textColor = LXbarTintColor;
        [self.contentView addSubview:DateLb];
        self.DateLb = DateLb;
        
        self.StateLbTip = [[UILabel alloc]init];
        self.StateLbTip.font = [UIFont systemFontOfSize:14.0];
        self.StateLbTip.textColor = [UIColor darkGrayColor];
        self.StateLbTip.text = @"状态:";
        [self .contentView addSubview:self.StateLbTip];
        
        UIButton *StateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        StateButton.font = [UIFont systemFontOfSize:14.0];
        StateButton.layer.cornerRadius = 5;
        [StateButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:StateButton];
        self.StateBt = StateButton;
        
    }
    return self;
}
+(LendTableViewCell*)addLendTableViewCell:(UITableView *)tableView{
    NSString *identity = @"lend";
    LendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[LendTableViewCell   alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
-(void)setLend:(Lend *)lend{
    NSLog(@"%@",lend.State);
    self.TitleLb.text = lend.Title;
    self.TitleLb.numberOfLines = 0;
    self.TitleLb.lineBreakMode = NSLineBreakByClipping;
    self.DepartmentLb .text = lend.Department;
    self.DateLb.text = lend.Date;
    self.DateLb.textColor =  [UIColor colorWithRed:242/255.0 green:92/255.0 blue:90/255.0 alpha:1.0];
    if([lend.State isEqualToString:@"本馆借出"]){
        [self.StateBt setTitle:@"我要续借" forState:UIControlStateNormal];
        [self.StateBt setBackgroundColor: [UIColor colorWithRed:242/255.0 green:92/255.0 blue:90/255.0 alpha:1.0]];
    }
    else if ([lend.State isEqualToString:@"本馆续借"]){
        self.StateBt.backgroundColor = [UIColor whiteColor  ];
        [self.StateBt setTitle:lend.State forState:UIControlStateNormal];
        [self.StateBt setTitleColor: [UIColor colorWithRed:84/255.0 green:229/255.0 blue:7/255.0 alpha:1.0] forState:UIControlStateNormal];
            }
    else if([lend.State isEqualToString:@"过期暂停"]){
        [self.StateBt setTitle:@"过期暂停" forState:UIControlStateNormal];
        self.StateBt.backgroundColor = [UIColor blueColor];
        [self.StateBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];

    [self.TitleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(5);
        make.right.equalTo(-15);
        make.height.equalTo(self.TitleLb.height);
    }];

    [self.DepartmentLbTip makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TitleLb.bottom).offset(5);
        make.left.equalTo(self.TitleLb.left);
        make.height.equalTo(20);
        make.width.equalTo(40);
    }];
    
    [self.DepartmentLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DepartmentLbTip.top);
        make.left.equalTo(self.DepartmentLbTip.right);
        make.height.equalTo(20);
        make.right.equalTo(self.right);
    }];
    
    [self.DateLbTip makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DepartmentLbTip.bottom).offset(5);
        make.left.equalTo(self.DepartmentLbTip.left);
        make.width.equalTo(80);
        make.height.equalTo(20);
    }];
    [self.DateLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DateLbTip.top);
        make.left.equalTo(self.DateLbTip.right);
        make.right.equalTo(self.DepartmentLb.right);
        make.height.equalTo(20);
    }];
    
    [self.StateLbTip makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.DateLb.bottom).offset(5);
        make.left.equalTo(self.DateLbTip.left);
        make.right.equalTo(self.DateLbTip.right);
        make.height.equalTo(20);
    }];
    [self.StateBt makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.StateLbTip.top);
        make.left.equalTo(self.DateLb.left);
        make.height.equalTo(20);
        make.width.equalTo(80);
    }];
}
-(void)click:(UIButton *)bt{
    if (self.block) {
        self.block(bt,self.DateLb);
    }
}

@end
