//
//  BasicIntoHead.m
//  图书管理
//
//  Created by shixihao on 16/7/22.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前

#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装

#import "Masonry.h"
#import "BasicIntoHead.h"
@interface BasicIntoHead()
@property(nonatomic,weak)UILabel *basicInfoLb;
@property(nonatomic,weak)UILabel *favirateLb;
@property(nonatomic,weak)UIImageView *imageV;
@property(nonatomic,weak)UIView *cellBac;
@end

@implementation BasicIntoHead

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *cellBac = [[UIImageView alloc]init];
        cellBac.image = [UIImage imageNamed:@"cellBac"];
        cellBac.userInteractionEnabled = YES;
        [self addSubview:cellBac];
        self.cellBac = cellBac;
        
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"1"];
        [self.cellBac addSubview:imageV];
        self.imageV = imageV;
        
        UILabel *basicInfoLb = [[UILabel alloc]init];
        basicInfoLb.text = @"基本资料";
        [self.cellBac addSubview:basicInfoLb];
        self.basicInfoLb = basicInfoLb;
        
        UIButton *favirateBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [favirateBt setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
        [favirateBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        favirateBt.layer.cornerRadius = 25;
        [self.cellBac addSubview:favirateBt];
        self.favirateBt = favirateBt;
        
        UILabel *favirateLb = [[UILabel alloc]init];
        favirateLb.text = @"收藏";
        [self.cellBac addSubview:favirateLb];
        self.favirateLb = favirateLb;
        }
    return self;
}
-(void)click:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(addFavirate:)]) {
        [self.delegate addFavirate:bt];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.cellBac.frame = CGRectMake(15, 5, self.frame.size.width-30, self.frame.size.height-10);

    [self.imageV makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(20);
        make.width.height.equalTo(40);
        make.top.equalTo(self.cellBac.top).offset(5);
        make.bottom.equalTo(self.cellBac.bottom).offset(-5);

    }];
    
    [self.basicInfoLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.right).offset(10);
        make.width.equalTo(80);
        make.height.equalTo(40);
        make.top.equalTo(10);
    }];
    [self.favirateLb makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-40);
        make.top.equalTo(self.basicInfoLb.top);
        make.width.equalTo(self.basicInfoLb.width).multipliedBy(0.5);
        make.height.equalTo(self.basicInfoLb.height);
    }];
    [self.favirateBt makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.favirateLb.left).offset(-10);
        make.top.equalTo(self.imageV.top);
        make.bottom.equalTo(self.imageV.bottom);
        make.width.equalTo(self.imageV.width);
    }];
   
    
    }

@end
