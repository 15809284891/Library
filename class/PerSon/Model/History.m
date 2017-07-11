//
//  History.m
//  图书管理
//
//  Created by lixue on 16/7/15.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "History.h"

@implementation History{
    CGFloat _cellHeight;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.historyArray = [NSMutableArray array];
    }
    return self;
}
-(void)initHistoryData:(NSDictionary *)dic{
    
    NSArray *DetailArray = dic[@"Detail"];
    for (int i = 0;i<DetailArray.count; i++) {
        NSDictionary *tempDic = DetailArray[i];
                //必须要一个局部变量才可以，不能用self赋值
        History *history = [[History alloc]init];
        history.Barcode = tempDic[@"Barcode"];
        history.Date = tempDic[@"Date"];
        history.Title= tempDic[@"Title"];
        history.Type = tempDic[@"Type"];
        [self .historyArray addObject:history];
    }
          
}
-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGSize size = CGSizeMake(screenW-30, MAXFLOAT);
        CGSize lableSize = [self.Title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size;
        _cellHeight = lableSize.height+82;
    }
    return _cellHeight;
}

@end
