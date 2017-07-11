//
//  ProblemCell.m
//  图书管理
//
//  Created by shixihao on 16/7/30.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "ProblemCell.h"
#import "Problem.h"
@interface ProblemCell()
@property(nonatomic)UILabel *titleLb;
@property(nonatomic)UILabel *textLb;
@property(nonatomic)UIImageView *cellBac;
@end
@implementation ProblemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *cellBac = [[UIImageView alloc]init];
        cellBac.image = [UIImage imageNamed:@"cellBac"];
        [self.contentView addSubview:cellBac];
        self.cellBac = cellBac;
        self.titleLb = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLb];
        self.textLb = [[UILabel alloc]init];
        [self.contentView addSubview:self.textLb];
        
    }
    return self;
}

+(ProblemCell*)addProblemCell:(UITableView *)tableView{
    NSString *identity = @"problemCell";
    ProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[ProblemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    return cell;
}
-(void)setProblem:(Problem *)problem{
    self.titleLb.text = problem.title;
    self.textLb.text = problem.text;
    CGRect frame = self.frame;
    self.titleLb.frame = [self lableSize:self.titleLb];
    self.textLb.frame = [self lableSize:self.textLb];
    frame.size.height = self.titleLb.frame.size.height+self.textLb.frame.size.height+50;
    self.frame = frame;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.cellBac.frame = CGRectMake(15, 10, self.frame.size.width-30, self.frame.size.height-20);

    [self.titleLb makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellBac.left).offset(10);
        make.right.equalTo(self.cellBac.right).offset(-10);
        make.top.equalTo(self.cellBac.top).offset(10);
    }];
    [self.textLb makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellBac.left).offset(10);
            make.right.equalTo(self.cellBac.right).offset(-10);
            make.bottom.equalTo(self.cellBac.bottom).offset(-10);
        
    }];
}
-(CGRect)lableSize:(UILabel *)lable{
    lable.numberOfLines = 0;
    CGSize size = CGSizeMake(300.f, MAXFLOAT);
    CGSize lableSize = [lable.text sizeWithFont:lable.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    lable.frame =  CGRectMake(lable.frame.origin.x, lable.frame.origin.y, lableSize.width,lableSize.height);
    return lable.frame;
}
@end
