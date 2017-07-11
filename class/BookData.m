//
//  BookData.m
//  图书管理
//
//  Created by shixihao on 16/7/23.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "BookData.h"
#import "MJExtension.h"
@implementation BookData{
    CGFloat _cellHeight;
}
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"bookID":@"ID"};
}
-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGSize size = CGSizeMake(250, MAXFLOAT);
        CGSize titleSize = [self.Title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:
                            @{NSFontAttributeName:[UIFont systemFontOfSize:18.0]
                              
                              } context:nil].size;
        _cellHeight = titleSize.height+26;
    }
    
    return _cellHeight;
}
@end
