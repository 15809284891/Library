//
//  AnnounceOrNews.m
//  图书管理
//
//  Created by shixihao on 16/8/13.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "News.h"
#import "MJExtension.h"
@implementation News{
    CGFloat _cellHeight;
}
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"NewsID":@"ID",
             @"title":@"Title",
             @"date":@"Date"
             };
}
-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGSize size = CGSizeMake(350, MAXFLOAT);
        CGSize titleSize = [self.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0]} context:nil].size;
        _cellHeight =titleSize.height+26;

    }
    return _cellHeight;
}
@end
