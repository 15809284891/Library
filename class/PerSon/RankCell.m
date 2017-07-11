
//
//  RankCell.m
//  图书管理
//
//  Created by shixihao on 16/7/19.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前
#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装
#import "Masonry.h"
#import "RankCell.h"
#import "Rank.h"
@interface RankCell()
@property(nonatomic,weak)UILabel *TitleLb;
@property(nonatomic,weak)UILabel *BorNumLb;
@property(nonatomic,weak)UILabel *BorNumTipLb;
@end
@implementation RankCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *TitleLb = [[UILabel alloc]init];
        TitleLb.font = [UIFont systemFontOfSize:18.0];
        [self.contentView addSubview:TitleLb];
        self.TitleLb = TitleLb;
        
        UILabel *BorNumTipLb = [[UILabel alloc]init];
        BorNumTipLb.font = [UIFont systemFontOfSize:14.0];
        BorNumTipLb.text = @"浏览次数:";
        BorNumTipLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:BorNumTipLb];
        self.BorNumTipLb = BorNumTipLb;
        
         UILabel *BorNumLb = [[UILabel alloc]init];
        BorNumLb.font = BorNumTipLb.font;
        BorNumLb.font = [UIFont systemFontOfSize:14.0];
        BorNumLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:BorNumLb];
        self.BorNumLb = BorNumLb;
    }
    return self;
}
+(RankCell *)addRankCell:(UITableView *)tableView{
   static NSString *identity = @"rankCell";
    RankCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        cell = [[RankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
-(void)setRank:(Rank *)rank{
    
    self.TitleLb.font = [UIFont systemFontOfSize:18.0];
    self.TitleLb.text = rank.Title;
    self.TitleLb.lineBreakMode  = NSLineBreakByCharWrapping;
    self.TitleLb.numberOfLines = 0;
    self.BorNumLb.text = rank.BorNum;
   
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.TitleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(5);
        make.right.equalTo(-15);
        make.height.equalTo(self.TitleLb.height);
    }];
    [self.BorNumTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TitleLb.left).offset(5);
        make.width.equalTo(100);
        make.bottom.equalTo(self .bottom).offset(-5);
        make.top.equalTo(self.TitleLb.bottom).offset(10);
    }];
    [self.BorNumLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.top.equalTo(self.BorNumTipLb);
        make.left.equalTo(self.BorNumTipLb.right);
    }];
    
}
@end
