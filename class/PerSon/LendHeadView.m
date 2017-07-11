//
//  LendHeadView.m
//  图书管理
//
//  Created by lixue on 16/7/16.
//  Copyright © 2016年 lixue. All rights reserved.
//
#define Viewwidth1 self.bounds.size.width
#define Viewheight1 self.bounds.size.height

#import "LendHeadView.h"
#import "Lend.h"
@interface LendHeadView()@property(nonatomic) UILabel  *havelendLb;
@property(nonatomic) UILabel * canLendLb;
@property(nonatomic) UILabel *  lendAgainLb;
@property(nonatomic)UILabel * outDateLb;

@end
@implementation LendHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)initHeadView{

    UILabel *haveLent = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 80, 25)];
    haveLent.text = @"已借图书";
    haveLent.textColor =  [UIColor colorWithRed:125/255.0 green:198/255.0 blue:203/255.0 alpha:1.0];
    [self addSubview:haveLent];
    self.havelendLb = [[UILabel  alloc]initWithFrame:CGRectMake(115, 5, 40, 25)];
    self.havelendLb.text = [NSString stringWithFormat:@"%ld",self.haveLendCount];
    self.havelendLb.textColor  =  [UIColor colorWithRed:125/255.0 green:198/255.0 blue:203/255.0 alpha:1.0];
    [self addSubview:self.havelendLb];
    
    
    UILabel*canLend = [[UILabel alloc]initWithFrame:CGRectMake(25, 35, 80, 25)];
    canLend.text = @"剩余可借";
    canLend.textColor =  [UIColor colorWithRed:170/255.0 green:236/255.0 blue:170/255.0 alpha:1.0];
    [self addSubview:canLend];
    self.canLendLb = [[UILabel alloc]initWithFrame:CGRectMake(115, 35, 40, 25)];
    self.canLendLb.text = [NSString stringWithFormat:@"%ld",self.canLendCount];
    self.canLendLb.textColor = [UIColor colorWithRed:170/255.0 green:236/255.0 blue:170/255.0 alpha:1.0];
    [self addSubview:self.canLendLb];
    
    UILabel *lendAgain = [[UILabel alloc]initWithFrame:CGRectMake(25, 65, 80, 25)];
    lendAgain.text = @"续借图书";
    lendAgain.textColor  =  [UIColor colorWithRed:247/255.0 green:172/255.0 blue:122/255.0 alpha:1.0];
    [self addSubview:lendAgain ];
    self.lendAgainLb = [[UILabel alloc]initWithFrame:CGRectMake(115, 65, 40, 25)];
    self.lendAgainLb.text = [NSString stringWithFormat:@"%ld",self.lendAgainCount];
    self.lendAgainLb.textColor  = [UIColor colorWithRed:247/255.0 green:172/255.0 blue:122/255.0 alpha:1.0];
    [self addSubview:self.lendAgainLb];
    
    UILabel *outDate = [[UILabel alloc]initWithFrame:CGRectMake(25, 95, 80, 20)];
    outDate.text = @"超期图书";
    outDate.textColor =  [UIColor colorWithRed:230/255.0 green:111/255.0 blue:113/255.0 alpha:1.0];
    [self addSubview:outDate];
    
    self.outDateLb =[ [UILabel alloc]initWithFrame:CGRectMake(115, 95, 40, 20)];
    self.outDateLb.text = [NSString stringWithFormat:@"%ld",self.outDateCount];
    self.outDateLb.textColor  = [UIColor colorWithRed:230/255.0 green:111/255.0 blue:113/255.0 alpha:1.0];
    [self addSubview:self.outDateLb];

}
@end
