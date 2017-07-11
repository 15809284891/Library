//
//  anounceCell.m
//  图书管理
//
//  Created by lixue on 16/4/18.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "NewsCell.h"


#import "News.h"
@interface NewsCell ()
@property (nonatomic,weak) UIImageView *imageV;
@property (nonatomic,weak) UIView *lineView;
@property (nonatomic,weak) UILabel  *contentLb;
@property (nonatomic,weak) UILabel *dateLb;
@end
@implementation NewsCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.image = [UIImage imageNamed:@"circle"];
        [self.contentView addSubview:imageV];
        self.imageV = imageV;
        
        UILabel *contentLb = [[UILabel alloc]init];
        [self.contentView addSubview:contentLb];
        contentLb.font = [UIFont systemFontOfSize:18.0];
        contentLb.numberOfLines = 0;
        self.contentLb = contentLb;
        UILabel *dateLb = [[UILabel alloc]init];
        [self.contentView addSubview:dateLb];
        dateLb.font = [UIFont systemFontOfSize:14.0];
        dateLb.textColor = [UIColor darkGrayColor];
        self.dateLb = dateLb;

    }
    
    return self;
}

+(NewsCell *)addNewsCellWithTableView:(UITableView *)tableview{
    
    static NSString *cellIdentifier = @"cell";
    NewsCell *cell = [tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    return cell;
}

-(void)setModel:(News*)model{
    _model = model;
    self.contentLb.text = model.title;
    self.dateLb.text = model.date;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(5, 7, 8, 8);

    [self.contentLb makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-5);
        make.left.equalTo(self.left).offset(20);
        make.height.equalTo(self.contentLb.height);
        make.top.equalTo(self.top).offset(3);
    }];
    [self.imageV makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.width.height.equalTo(8);
        make.centerY.equalTo(self.contentLb.centerY);
    }];
//    self.imageView.frame = CGRectMake(0, 0, 20, 20);
    [self.dateLb makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-3);
        make.right.equalTo(self.right).offset(-5);
        make.width.equalTo(100);
        make.height.equalTo(20);
    }];
}
-(void)setFrame:(CGRect)frame{
    frame.size.height = frame.size.height - 1;
    [super setFrame:frame];
}
@end
