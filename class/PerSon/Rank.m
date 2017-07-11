


//
//  Rank.m
//  图书管理
//
//  Created by shixihao on 16/7/19.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "Rank.h"
#import "MJExtension.h"
@implementation Rank{
    CGFloat _cellHeight;
}
+replacedKeyFromPropertyName{
    return @{
             @"BookRank":@"Rank",
             @"LibarayId":@"ID"
             };
}
-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGSize size = CGSizeMake(screenW-30, MAXFLOAT);
        CGSize lableSize = [self.Title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
        _cellHeight = lableSize.height+52;
    }
    return _cellHeight;
}
@end
