//
//  FourthCell.m
//  图书管理
//
//  Created by lixue on 16/7/17.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前

#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装

#import "Masonry.h"
#import "RerferCell.h"
#import "ReferBooks.h"
@interface RerferCell()
@property(nonatomic,weak)UILabel *titleTipLb;
@property(nonatomic,weak)UILabel *titleLb;
@property(nonatomic,weak)UILabel *authorLd;
@property(nonatomic,weak)UILabel *authorTipLb;
@property(nonatomic,weak)UILabel *bookIDLb;
@property(nonatomic,weak)UILabel *bookIDTipLb;
@end
@implementation RerferCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleTipLb =[[UILabel alloc]init];
        titleTipLb.font = [UIFont systemFontOfSize:14];
        titleTipLb.text = @"书名:";
        titleTipLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:titleTipLb];
        self.titleTipLb = titleTipLb;
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.font = [UIFont systemFontOfSize:14];
        titleLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:titleLb];
        self.titleLb = titleLb;
        
        UILabel *authorTipLb = [[UILabel alloc]init];
        authorTipLb.font = [UIFont systemFontOfSize:14];
        authorTipLb.textColor = [UIColor darkGrayColor];
        authorTipLb.text = @"作者:";
        [self.contentView addSubview:authorTipLb];
        self.authorTipLb = authorTipLb;
        
        UILabel *authorLd = [[UILabel alloc]init];
        authorLd.font = [UIFont systemFontOfSize:14];
        authorLd.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:authorLd];
        self.authorLd = authorLd;
        
        UILabel *bookIDTipLb = [[UILabel alloc]init];
        bookIDTipLb.font = [UIFont systemFontOfSize:14];
        bookIDTipLb.textColor = [UIColor darkGrayColor];
        bookIDTipLb.text = @"索书号";
        [self.contentView addSubview:bookIDTipLb];
        self.bookIDTipLb = bookIDTipLb;
        
        UILabel *bookIDLb = [[UILabel alloc]init];
        bookIDLb.font = [UIFont systemFontOfSize:14];
        bookIDLb.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:bookIDLb];
        self.bookIDLb = bookIDLb;
    }
    return self;
}
+(RerferCell *)addRerferCell:(UITableView *)tableView{
    NSString *identity = @"refer";
    RerferCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell== nil) {
        cell = [[RerferCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
-(void)setReferBook:(ReferBooks *)referBook{
    self.titleLb.text = referBook.Title;
    self.authorLd.text = referBook.Author;
    self.bookIDLb.text = referBook.ReferBooks_ID;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(5);
        make.height.equalTo(20);
        make.width.equalTo(80);
    }];
   
    [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleTipLb.right);
        make.right.equalTo(self.right);
        make.height.equalTo(self.titleTipLb.height);
        make.top.equalTo(self.titleTipLb.top);
    }];
    
    [self.authorTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self.titleTipLb.bottom).offset(5);
        make.width.equalTo(self.titleTipLb.width);
        make.height.equalTo(self.titleTipLb.height);
    }];
    
    
    [self.authorLd makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.left);
        make.top.equalTo(self.authorTipLb.top);
        make.right.equalTo(self.titleLb.right);
        make.height.equalTo(self.authorTipLb.height);
    }];
    
    [self.bookIDTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(self.authorTipLb.bottom).offset(5);
        make.width.equalTo(self.authorTipLb.width);
        make.height.equalTo(self.authorTipLb.height);
    }];
        [self.bookIDLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bookIDTipLb.right);
        make.bottom.equalTo(self.bookIDTipLb.bottom);
        make.right.equalTo(self.right);
        make.height.equalTo(self.bookIDTipLb.height);
        
    }];
    
    

}

@end
