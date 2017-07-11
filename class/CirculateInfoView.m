//
//  CirculateInfoView.m
//  图书管理
//
//  Created by shixihao on 16/7/21.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前

#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装

#import "Masonry.h"
#import "CirculateInfoView.h"
#import "CirculationInfo.h"
@interface CirculateInfoView()
@property(nonatomic,weak)UILabel *barCodeTipLb;
@property(nonatomic,weak)UILabel *barCodeLb;
@property(nonatomic,weak)UILabel *statusLd;
@property(nonatomic,weak)UILabel *statusTipLb;
@property(nonatomic,weak)UILabel *depatmentLb;
@property(nonatomic,weak)UILabel *depatmentTipLb;
@end
@implementation CirculateInfoView

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *barCodeTipLb =[[UILabel alloc]init];
        barCodeTipLb.text = @"条码:";
        barCodeTipLb.font = [UIFont systemFontOfSize:14.0];
        barCodeTipLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:barCodeTipLb];
        self.barCodeTipLb = barCodeTipLb;
        
        UILabel *barCodeLb = [[UILabel alloc]init];
        barCodeLb.font = [UIFont systemFontOfSize:14];
        barCodeLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:barCodeLb];
        self.barCodeLb = barCodeLb;
        
        UILabel *statusTipLb = [[UILabel alloc]init];
        statusTipLb.font = [UIFont systemFontOfSize:14];
        statusTipLb.textColor = [UIColor darkGrayColor];
        statusTipLb.text = @"状态:";
        [self.contentView addSubview:statusTipLb];
        self.statusTipLb = statusTipLb;
        
        UILabel *statusLd = [[UILabel alloc]init];
        statusLd.font = [UIFont systemFontOfSize:14];
        statusLd.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:statusLd];
        self.statusLd = statusLd;
        
        UILabel *depatmentTipLb = [[UILabel alloc]init];
        depatmentTipLb.text = @"所在书库";
        depatmentTipLb.font = [UIFont systemFontOfSize:14];
        depatmentTipLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:depatmentTipLb];
        self.depatmentTipLb = depatmentTipLb;
                
        UILabel *depatmentLb = [[UILabel alloc]init];
        depatmentLb.font = [UIFont systemFontOfSize:14];
        depatmentLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:depatmentLb];
        self.depatmentLb = depatmentLb;
    }
    return self;
}

+(CirculateInfoView *)addCirculateCell:(UITableView *)tableView{
    NSString *identity = @"circulateCell";
    CirculateInfoView *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[CirculateInfoView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
-(void)setCirculationInfo:(CirculationInfo *)circulationInfo{
//    NSLog(@"%@",circulationInfo.CirculationInfo_Barcode);
    self.barCodeLb.text = [NSString stringWithFormat:@"%ld",circulationInfo.Barcode];
    self.statusLd.text = circulationInfo.Status;
    self.depatmentLb.text = circulationInfo.Department;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.barCodeTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self).offset(5);
        make.height.equalTo(20);
        make.width.equalTo(80);
    }];
   
    [self.barCodeLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.barCodeTipLb.right);
        make.right.equalTo(self.right);
        make.height.equalTo(self.barCodeTipLb.height);
        make.top.equalTo(self.barCodeTipLb.top);
    }];
    
    [self.statusTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self.barCodeTipLb.bottom).offset(5);
        make.width.equalTo(self.barCodeTipLb.width);
        make.height.equalTo(self.barCodeTipLb.height);
    }];
    
    [self.statusLd makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.barCodeLb.left);
        make.top.equalTo(self.statusTipLb.top);
        make.right.equalTo(self.barCodeLb.right);
        make.height.equalTo(self.statusTipLb.height);
    }];
    
    [self.depatmentTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self.statusLd.bottom).offset(5);
        make.width.equalTo(self.statusTipLb.width);
        make.height.equalTo(self.statusTipLb.height);
    }];
    
    [self.depatmentLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.depatmentTipLb.right);
        make.bottom.equalTo(self.depatmentTipLb.bottom);
        make.right.equalTo(self.right);
        make.height.equalTo(self.depatmentTipLb.height);

    }];
   
}
@end
