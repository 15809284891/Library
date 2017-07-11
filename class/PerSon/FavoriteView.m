//
//  FavoriteView.m
//  图书管理
//
//  Created by shixihao on 16/8/15.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "FavoriteView.h"
#import "Favorite.h"
#import "UIImageView+WebCache.h"
@interface FavoriteView()
@property(nonatomic,weak)UILabel *titleLb;
@property(nonatomic,weak)UILabel *authorTipLb;
@property(nonatomic,weak)UILabel *authorLb;
@property(nonatomic,weak)UILabel *pubTipLb;
@property(nonatomic,weak)UILabel *pubLb;
@property(nonatomic,weak)UILabel *subTitleTipLb;
@property(nonatomic,weak)UILabel *subTitleLb;
@property(nonatomic,weak)UILabel *isbnTipLb;
@property(nonatomic,weak)UILabel *isbnLb;
@property(nonatomic,weak)UILabel *bookIDTipLb;
@property(nonatomic,weak)UILabel *bookIDLb;
@property(nonatomic,weak)UILabel *sortTipLb;
@property(nonatomic,weak)UILabel *sortLb;
@property(nonatomic,weak)UIImageView *imageV;
@property(nonatomic,weak)UIImageView *imageBacV;
@property(nonatomic,weak)UIView *bacView;
@end
@implementation FavoriteView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bacView = [[UIView alloc]init];
        bacView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bacView];
        self.bacView = bacView;
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.font = [UIFont systemFontOfSize:18.0];
        [self.bacView addSubview:titleLb];
        self.titleLb = titleLb;
        
        UILabel *authorTipLb = [[UILabel alloc]init];
        authorTipLb.backgroundColor = [UIColor yellowColor];
        authorTipLb.text = @"作者:";
        authorTipLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:authorTipLb];
        self.authorTipLb = authorTipLb;
        
        UILabel *authorLb = [[UILabel  alloc]init];
        authorLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:authorLb];
        self.authorLb = authorLb;
        
        UIImageView *imageBacV = [[UIImageView alloc]init];
        imageBacV.image = [UIImage imageNamed:@"书籍背景.jpg"];
        [self.bacView addSubview:imageBacV];
        self.imageBacV = imageBacV;
        
        UIImageView *imageV = [[UIImageView alloc]init];
        [self.imageBacV addSubview:imageV];
        self.imageV = imageV;
        
        UILabel *bookIDTipLb = [[UILabel alloc]init];
        bookIDTipLb.backgroundColor = [UIColor yellowColor];
        bookIDTipLb.text = @"编码:";
        bookIDTipLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:bookIDTipLb];
        self.bookIDTipLb = bookIDTipLb;
        
        UILabel *bookIDLb = [[UILabel  alloc]init];
        bookIDLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:bookIDLb];
        self.bookIDLb= bookIDLb;

        
        UILabel *isbnTipLb = [[UILabel alloc]init];
        isbnTipLb.backgroundColor = [UIColor yellowColor];
        isbnTipLb.text = @"条形码:";
        isbnTipLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:isbnTipLb];
        self.isbnTipLb = isbnTipLb;
        
        UILabel *isbnLb = [[UILabel alloc]init];
        isbnLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:isbnLb];
        self.isbnLb = isbnLb;
        
        UILabel *sortTipLb = [[UILabel alloc]init];
        sortTipLb.backgroundColor = [UIColor yellowColor];
        sortTipLb.text = @"索书号:";
        sortTipLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:sortTipLb];
        self.sortTipLb = sortTipLb;
        
        UILabel *sortLb = [[UILabel alloc]init];
        sortLb.font =[UIFont systemFontOfSize:13];
        [self.bacView addSubview:sortLb];
        self.sortLb = sortLb;
        
        UILabel *pubTipLb = [[UILabel alloc]init];
        pubTipLb.backgroundColor = [UIColor yellowColor];
        pubTipLb.text = @"出版社";
        pubTipLb.font = [UIFont systemFontOfSize:13];
        [self.bacView addSubview:pubTipLb];
        self.pubTipLb = pubTipLb;
        
        UILabel *pubLb = [[UILabel alloc]init];
        pubLb.font =[UIFont systemFontOfSize:13];
        [self.bacView addSubview:pubLb];
        self.pubLb = pubLb;


    }
    return self;
}
-(void)setFavorite:(Favorite *)favorite{
    
    self.titleLb.text = favorite.Title;
    self.bookIDLb.text = favorite.BookID;
    self.isbnLb.text = favorite.ISBN;
    self.authorLb.text = favorite.Author;
    self.pubLb.text = favorite.Pub;
    self.sortLb.text = favorite.Sort;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:favorite.largeImage] placeholderImage:[UIImage imageNamed:@"NormalBookLarge"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.bacView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(50);
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.bottom.equalTo(-50);
    }];
    [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(10);
        make.height.equalTo(30);
        make.right.equalTo(-10);
    }];
    [self.authorTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLb.left);
        make.width.equalTo(60);
        make.height.equalTo(20);
        make.top.equalTo(self.titleLb.bottom).offset(10);
    }];
    [self.authorLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorTipLb.right);
        make.top.equalTo(self.authorTipLb.top);
        make.bottom.equalTo(self.authorTipLb.bottom);
        make.right.equalTo(self.right).offset(-10);
    }];
    [self.pubTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.authorTipLb);
        make.bottom.equalTo(self.bacView.bottom).offset(-10);
    }];
    [self.pubLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pubTipLb.right);
        make.right.equalTo(self.authorLb.right);
        make.height.top.equalTo(self.pubTipLb);
        
    }];
    [self.sortTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.authorTipLb);
        make.bottom.equalTo(self.pubLb.top).offset(-10);
    }];
    [self.sortLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sortTipLb.right);
        make.right.equalTo(self.authorLb.right);
        make.height.top.equalTo(self.sortTipLb);
        
    }];
    [self.isbnTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.authorTipLb);
        make.bottom.equalTo(self.sortTipLb.top).offset(-10);
    }];
    [self.isbnLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.isbnTipLb.right);
        make.right.equalTo(self.authorLb.right);
        make.height.top.equalTo(self.isbnTipLb);
        
    }];

    
    [self.bookIDTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.authorTipLb);
        make.bottom.equalTo(self.isbnTipLb.top).offset(-10);
    }];
    [self.bookIDLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bookIDTipLb.right);
        make.right.equalTo(self.authorLb.right);
        make.height.equalTo(self.bookIDTipLb.height);
        make.top.equalTo(self.bookIDTipLb.top);
    }];
  [self.imageBacV makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.authorTipLb.bottom).offset(20);
      make.bottom.equalTo(self.bookIDTipLb.top).offset(-20);
    }];
    
    [self.imageV makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageBacV.centerX);
        make.centerY.equalTo(self.imageBacV.centerY);
        make.height.equalTo(self.imageBacV.height).offset(-60);
        make.width.equalTo(self.imageBacV.height).multipliedBy(0.5);
    }];


}
@end
