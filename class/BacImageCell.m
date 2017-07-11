//
//  BacImageCell.m
//  图书管理
//
//  Created by shixihao on 16/7/21.
//  Copyright © 2016年 lixue. All rights reserved.
//


#import "Masonry.h"
#import "BacImageCell.h"
#import "BookDetail.h"
#import "UIImageView+WebCache.h"
#import "BookImage.h"
#import "DoubanInfo.h"
@implementation BacImageCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *imageBacV = [[UIImageView alloc]init];
        imageBacV.image = [UIImage imageNamed:@"书籍背景"];
        [self addSubview:imageBacV];
        self.imageBacV = imageBacV;
        self.bookImageV = [[UIImageView alloc]init];
        [self addSubview:self.bookImageV];
        
        self.TitleLb = [[UILabel alloc]init];
        [self addSubview:self.TitleLb];

    }
    return self;
}
-(void)initContent:(BookDetail *)bookdetail{
      self.TitleLb.text = bookdetail.Title;
    CGRect frame =CGRectMake(0, 0, self.bounds.size.width, 230);

    self.TitleLb.numberOfLines = 3;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.TitleLb.text sizeWithFont:self.TitleLb.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    
    self.TitleLb.frame = CGRectMake(self.TitleLb.frame.origin.x, self.TitleLb.frame.origin.y, labelSize.width, labelSize.height);
    frame.size.height = labelSize.height+190;
    self.frame = frame;
    [self.bookImageV sd_setImageWithURL:[NSURL URLWithString:bookdetail.doubanInfo.Images.small] placeholderImage:[UIImage imageNamed:@"nilBook"]];

}
-(void)layoutSubviews{
    [super layoutSubviews];

    [self.imageBacV makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.width);
        make.leading.equalTo(self.leading);
        make.top.equalTo(self.top);
        make.height.equalTo(160);
       
    }];
    [self.bookImageV makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(60);
        make.height.equalTo(120);
        make.centerX.equalTo(self.centerX);
        make.centerY.equalTo(self.imageBacV.centerY);
    }];
    [self.TitleLb makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.width).offset(-40);
        make.left.equalTo(self.left).offset(20);
        make.top.equalTo(self.imageBacV.bottom).offset(20);
    }];
}
@end
