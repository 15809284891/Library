//
//  Lend.m
//  图书管理
//
//  Created by lixue on 16/6/12.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "Lend.h"
@implementation Lend{
    CGFloat _cellHeight;
}

-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGSize size = CGSizeMake(screenW-30, MAXFLOAT);
        CGSize lableSize = [self.Title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size;
        _cellHeight = lableSize.height+92;
    }
    return _cellHeight;
}

@end
