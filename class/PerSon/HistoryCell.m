//
//  HistoryCell.m
//  图书管理
//
//  Created by shixihao on 16/7/19.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前
#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装
#import "Masonry.h"
#import "HistoryCell.h"
#import "History.h"
@interface HistoryCell()
@property(nonatomic,weak)UILabel *TitleLb;
@property(nonatomic,weak)UILabel *TypeLb;
@property(nonatomic,weak)UILabel *DateLb;
@property(nonatomic,weak)UILabel *BarcodeLb;
@property(nonatomic,weak)UILabel *TypeTipLb;
@property(nonatomic,weak)UILabel *DateTipLb;
@property(nonatomic,weak)UILabel *BarcodeTipLb;
@end
@implementation HistoryCell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        UILabel *TitleLb = [[UILabel alloc]init];
        [self.contentView addSubview:TitleLb];
        TitleLb.numberOfLines = 0;
        TitleLb.font = [UIFont systemFontOfSize:18.0];
        TitleLb.lineBreakMode = NSLineBreakByCharWrapping;
        self.TitleLb = TitleLb;

        UILabel *TypeTipLb= [[UILabel alloc]init];
        TypeTipLb.font = [UIFont systemFontOfSize:16];
        TypeTipLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:TypeTipLb];
        TypeTipLb.text = @"操作类型:";
        self.TypeTipLb =TypeTipLb;
        
        UILabel*DateTipLb = [[UILabel alloc]init];
        DateTipLb.text = @"操作日期:";
        DateTipLb.textColor = [UIColor darkGrayColor];
        DateTipLb.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:DateTipLb];
        self.DateTipLb = DateTipLb;
        
        UILabel*BarcodeTipLb = [[UILabel alloc]init];
        BarcodeTipLb.text = @"索书号:";
        BarcodeTipLb.textColor = [UIColor darkGrayColor];
        BarcodeTipLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:BarcodeTipLb];
        self.BarcodeTipLb = BarcodeTipLb;
        
        UILabel*TypeLb = [[UILabel alloc]init];
        TypeLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:TypeLb];
        TypeLb.textColor = [UIColor darkGrayColor];
        self.TypeLb = TypeLb;
        
        UILabel *DateLb = [[UILabel alloc]init];
        DateLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:DateLb];
        DateLb.textColor = [UIColor darkGrayColor];
        self.DateLb = DateLb;
        
        UILabel *BarcodeLb = [[UILabel alloc]init];
        BarcodeLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:BarcodeLb];
        BarcodeLb.textColor = [UIColor darkGrayColor];
        self.BarcodeLb = BarcodeLb;
        
     }
    return self;
}
+(HistoryCell *)addHistoryCell:(UITableView *)tableView{
    NSString *identity = @"historyCell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[HistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}

-(void)setHistory:(History *)history{
    self.DateLb.text = history.Date;
    self.BarcodeLb.text = history.Barcode;
    self.TypeLb.text = history.Type;
    self.TitleLb.text = history.Title;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.TitleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(5);
        make.right.equalTo(-15);
        make.height.equalTo(self.TitleLb.height);
    }];

    [self.TypeTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TitleLb.left);
        make.top.equalTo(self.TitleLb.bottom).offset(5);
        make.height.equalTo(20);
        make.width.equalTo(80);
    }];
    [self.TypeLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TypeTipLb.right);
        make.right.equalTo(self.right);
        make.height.equalTo(self.TypeTipLb.height);
        make.top.equalTo(self.TypeTipLb.top);
    }];
    [self.DateTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TitleLb.left);
        make.top.equalTo(self.TypeTipLb.bottom).offset(5);
        make.width.equalTo(self.TypeTipLb.width);
        make.height.equalTo(self.TypeTipLb.height);
    }];
    
    [self.DateLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TypeLb.left);
        make.top.equalTo(self.DateTipLb.top);
        make.right.equalTo(self.TypeLb.right);
        make.height.equalTo(self.DateTipLb.height);
    }];
    
    [self.BarcodeTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TitleLb.left);
        make.top.equalTo(self.DateTipLb.bottom).offset(5);
        make.width.equalTo(self.TypeTipLb.width);
        make.height.equalTo(self.TypeTipLb.height);
    }];
    
    [self.BarcodeLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.DateLb.left);
        make.top.equalTo(self.BarcodeTipLb.top);
        make.right.equalTo(self.DateLb.right);
        make.height.equalTo(self.DateLb.height);
    }];
    
    
}
@end
