//
//  FavoriteCell.m
//  图书管理
//
//  Created by shixihao on 16/7/20.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前
#define MAS_SHORTHAND_GLOBALS//
#import "FavoriteCell.h"
#import "Masonry.h"
#import "Favorite.h"
#import "UIImageView+WebCache.h"
@interface FavoriteCell()
@property(nonatomic,weak)UILabel *titleLb;
@property(nonatomic,weak)UILabel *authorTipLb;
@property(nonatomic,weak)UILabel *authorLb;
@property(nonatomic,weak)UILabel *pubTipLb;
@property(nonatomic,weak)UILabel *pubLb;
@property(nonatomic,weak)UILabel *subTitleTipLb;
@property(nonatomic,weak)UILabel *subTitleLb;
@property(nonatomic,weak)UILabel *sortTipLb;
@property(nonatomic,weak)UILabel *sortLb;
@property(nonatomic,weak)UIImageView *imageV;
@end
@implementation FavoriteCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.font = [UIFont systemFontOfSize:18.0];
        titleLable.numberOfLines = 0;
        titleLable.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:titleLable];
        self.titleLb = titleLable;
        
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:imageV];
        self.imageV = imageV;
        
        UILabel *authorTipLb = [[UILabel alloc]init];
        authorTipLb.text = @"作者:";
        authorTipLb.font = [UIFont systemFontOfSize:14.0];
        authorTipLb.textColor = [UIColor darkGrayColor];
        [self .contentView addSubview:authorTipLb];
        self.authorTipLb = authorTipLb;
        
        UILabel *authorLb = [[UILabel   alloc]init];
        authorLb.font = [UIFont systemFontOfSize:14.0];
        authorLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:authorLb];
        self.authorLb = authorLb;
        
        UILabel *pubTipLb = [[UILabel alloc]init];
        pubTipLb.text = @"出版社:";
        pubTipLb.font = [UIFont systemFontOfSize:14.0];
        pubTipLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:pubTipLb];
        self.pubTipLb = pubTipLb;
        
        UILabel *pubLb = [[UILabel alloc]init];
        pubLb.font = [UIFont systemFontOfSize:14.0];
        pubLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:pubLb];
        self.pubLb = pubLb;
        
        UILabel *sortTipLb = [[UILabel alloc]init];
        sortTipLb.text = @"索书号:";
        sortTipLb.textColor = [UIColor darkGrayColor];
        sortTipLb.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:sortTipLb];
        self.sortTipLb = sortTipLb;
        
        UILabel *sortLb = [[UILabel alloc]init];
        sortLb.textColor = [UIColor darkGrayColor];
        sortLb.font =[UIFont systemFontOfSize:14.0];
        sortLb.text = @"索书号:";
        [self.contentView addSubview:sortLb];
        self.sortLb = sortLb;
        
        UIButton *favoriteBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [favoriteBt setBackgroundImage:[UIImage imageNamed:@"singleSelectDefaultMark"] forState:UIControlStateNormal];
        [favoriteBt setBackgroundImage:[UIImage imageNamed:@"yesMarkSmall"] forState:UIControlStateSelected];
        [self.contentView addSubview:favoriteBt];
        self.favoriteBt = favoriteBt;
    
        
    }
    return self;
}
+(FavoriteCell *)addFavoriteCell:(UITableView *)tableView{
    NSString *identity = @"favoriteCell";
    FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell==nil) {
        cell = [[FavoriteCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identity];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    return cell;
}
-(void)setFavorite:(Favorite *)favorite{
   
    self.titleLb.text = favorite.Title;
    self.authorLb.text = favorite.Author;
    self.pubLb.text = favorite.Pub;
    self.sortLb.text = favorite.Sort;
    self.favoriteBt.selected = favorite.isDelete;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:favorite.largeImage] placeholderImage:[UIImage imageNamed:@"NormalBookLarge"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.favoriteBt makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.width.equalTo(30);
        make.centerY.equalTo(self.contentView.centerY);
        make.height.equalTo(30);
    }];
    [self.imageV makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favoriteBt.right).offset(10);
        make.width.equalTo(50);
        make.centerY.equalTo(self.centerY);
        make.height.equalTo(80);
    }];
    [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV.right).offset(10);
        make.top.equalTo(5);
        make.right.equalTo(-10);
        make.height.equalTo(self.titleLb.height);
    }];
    [self.authorTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLb.bottom).offset(5);
        make.left.equalTo(self.titleLb.left);
        make.height.equalTo(20);
        make.width.equalTo(40);
    }];
    
    [self.authorLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorTipLb.top);
        make.left.equalTo(self.authorTipLb.right);
        make.height.equalTo(20);
        make.right.equalTo(self.right);
    }];
    
    [self.pubTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorTipLb.bottom).offset(5);
        make.left.equalTo(self.authorTipLb.left);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    [self.pubLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pubTipLb.top);
        make.left.equalTo(self.pubTipLb.right);
        make.right.equalTo(self.titleLb.right);
        make.height.equalTo(20);
    }];

    [self.sortTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pubTipLb.bottom).offset(5);
        make.left.equalTo(self.pubTipLb.left);
        make.right.equalTo(self.pubTipLb.right);
        make.height.equalTo(20);
    }];
    [self.sortLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortTipLb.top);
        make.left.equalTo(self.pubLb.left);
        make.height.equalTo(20);
        make.width.equalTo(80);
    }];

}

@end
