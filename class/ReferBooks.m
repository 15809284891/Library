//
//  ReferBooks.m
//  图书管理
//
//  Created by shixihao on 16/7/20.
//  Copyright © 2016年 lixue. All rights reserved.
//

#import "ReferBooks.h"
#import "MJExtension.h"
@implementation ReferBooks
+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ReferBooks_ID":@"ID"
             
             };
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
