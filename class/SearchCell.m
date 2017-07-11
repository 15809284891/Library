//
//  SearchTableViewCell.m
//  图书管理
//
//  Created by shixihao on 16/7/23.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND//只要添加了这个宏，就不用带mas了,必须定义在#import "Masonry.h"之前
#define MAS_SHORTHAND_GLOBALS//添加了该宏，就可以用equlto了，会自动包装
#import "Masonry.h"
#import "SearchCell.h"
#import "BookData.h"
@interface SearchCell()
@property(nonatomic,weak)UILabel *titleLb;
@property(nonatomic,weak)UILabel *authorTipLb;
@property(nonatomic,weak)UILabel *authorLb;
@end
@implementation SearchCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.font = [UIFont systemFontOfSize:18.0];
        titleLb.numberOfLines = 0;
        titleLb.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:titleLb];
        self.titleLb = titleLb;
        
        UILabel *authorTipLb = [[UILabel alloc]init];
        authorTipLb.font = [UIFont systemFontOfSize:16.0];
        authorTipLb.text = @"作者:";
        [self.contentView addSubview:authorTipLb];
        self.authorTipLb = authorTipLb;

        UILabel *authorLb = [[UILabel alloc]init];
        authorLb.font = authorTipLb.font;
        [self.contentView addSubview:authorLb];
        self.authorLb = authorLb;
    }
    return self;
}
+(SearchCell *)addSearchCell:(UITableView *)tableView{
    static NSString *identity = @"searchCell";
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
    
}
-(void)setBookData:(BookData *)bookData{
    _bookData = bookData;
    _titleLb.text = bookData.Title;
    _authorLb.text = bookData.Author;
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(3);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(self.titleLb.height);
    }];//可以不用设置lable高度自动的奥lable高度；

    [self.authorLb makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-3);
        make.right.equalTo(-15);
        make.height.equalTo(20);
        make.width.equalTo(100);
    }];
    [self.authorTipLb makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_authorLb);
        make.right.equalTo(_authorLb.left);
        make.width.equalTo(40);
    }];
}
-(void)setFrame:(CGRect)frame{
    frame.size.height = frame.size.height - 1;
    [super setFrame:frame];
}
@end
